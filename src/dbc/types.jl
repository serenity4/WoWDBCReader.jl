schema_type(schema) = getproperty(@__MODULE__, Symbol(uppercasefirst(string(schema)), :Data))
schema_name(::Type{T}) where {T<:DBCDataType} = Symbol(lowercasefirst(string(nameof(T)))[1:(end - 4)])
dbc_filename(path::AbstractString) = Symbol(first(splitext(basename(path))))

struct DBCData{T<:DBCDataType}
  name::Symbol
  schema::Symbol
  rows::Vector{T}
end

Base.:(==)(x::DBCData, y::DBCData) = x.name == y.name && x.schema == y.schema && x.rows == y.rows

DBCData(name, rows::AbstractVector{T}) where {T<:DBCDataType} = DBCData{T}(name, schema_name(T), rows)

DBCData(io::IO, name::Symbol, schema::Symbol) = DBCData{schema_type(schema)}(io, name)
DBCData(path::AbstractString, schema::Symbol) = DBCData{schema_type(schema)}(path)
DBCData(data::AbstractVector{UInt8}, name::Symbol, schema::Symbol) = DBCData(IOBuffer(data), name, schema)
function DBCData{T}(io::IO, path::AbstractString) where {T<:DBCDataType}
  name = dbc_filename(path)
  DBCData{T}(io, name)
end
DBCData{T}(io::IO, name::Symbol) where {T<:DBCDataType} = read_binary(io, DBCData{T}; name)
DBCData{T}(path::AbstractString) where {T<:DBCDataType} = open(io -> DBCData{T}(io, path), path, "r")

struct DBCFile
  name::Symbol
  schema::Symbol
  data::Vector{UInt8}
end

DBCFile(path::AbstractString, schema) = DBCFile(DBCData(path, schema))

Base.read(file::DBCFile) = DBCData(IOBuffer(file.data), file.name, file.schema)
Base.read(file::DBCFile, ::Type{DBCData{T}}) where {T<:DBCDataType} = DBCData{T}(IOBuffer(file.data), file.schema)

function DBCFile(data::DBCData)
  io = IOBuffer()
  write_dbc(io, data.rows)
  seekstart(io)
  DBCFile(data.name, data.schema, read(io))
end
