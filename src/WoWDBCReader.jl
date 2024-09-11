module WoWDBCReader

using BinaryParsingTools

struct ClientDatabase end

include("schemas.jl")

schema_type(schema) = Symbol(uppercasefirst(string(schema)), :Data)

function read_dbc(path::AbstractString, schema::Symbol)
  T = getproperty(@__MODULE__, schema_type(schema))
  read_dbc(path, T)
end

function read_dbc(path::AbstractString, ::Type{T}) where {T}
  open(io -> read_binary(io, ClientDatabase; T), path, "r")
end

function read_strings(io::IO, string_block_size::UInt32)
  # Strings are all the way to the end of the file.
  seekend(io)
  p = position(io)
  seek(io, p - string_block_size)
  (io, -Int64(string_block_size))
  strings = String[]
  indices = Dict{Int64,Int64}()
  i = 1
  while !eof(io)
    string = read_null_terminated_string(io)
    n = length(string) + 1 # add one for the null byte character that we don't keep
    push!(strings, string)
    indices[i] = lastindex(strings)
    i += n
  end
  strings, indices
end

function find_string(strings, indices, char_index)
  i = get(indices, char_index, nothing)
  isnothing(i) && error("Could not find string at index $char_index")
  strings[i]
end

BinaryParsingTools.cache_stream_in_ram(io::IO, ::Type{ClientDatabase}) = true

@generated function read_dbc_row(io::IO, strings, indices, ::Type{T}) where {T}
  ex = Expr(:call, T)
  for i in 1:fieldcount(T)
    subT = fieldtype(T, i)
    if subT === String
      push!(ex.args, :(find_string(strings, indices, 1 + read(io, Int32))))
    else
      push!(ex.args, :(read(io, $subT)))
    end
  end
  ex
end

function Base.read(io::BinaryIO, ::Type{ClientDatabase}; T::DataType)
  magic = read(io, Tag4)
  magic === tag4"WDBC" || error("The provided file has an invalid signature: $magic")
  record_count = read(io, UInt32)
  field_count = read(io, UInt32)
  fieldcount(T) == field_count || error("Inconsistent field counts between DBC and its schema: $(fieldcount(T)) ≠ $field_count")
  record_size = read(io, UInt32)
  string_block_size = read(io, UInt32)
  p = position(io)
  strings, indices = read_strings(io, string_block_size)
  seek(io, p)
  rows = T[]
  for i in 1:record_count
    seek(io, p + (i - 1)record_size)
    push!(rows, read_dbc_row(io, strings, indices, T))
  end
  rows
end

export read_dbc

end
