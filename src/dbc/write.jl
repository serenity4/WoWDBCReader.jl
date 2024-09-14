function write_dbc(filename, data)
  open(filename, "w+") do io
    write_dbc(io, data)
  end
end

function string_block(data)
  strings = Set{String}()
  for entry in data
    add_strings!(strings, entry)
  end
  strings = sort!(collect(strings))
  block = UInt8[]
  offsets = Dict{String,Int32}()
  for string in strings
    offsets[string] = length(block)
    for char in string
      push!(block, char)
    end
    push!(block, '\0')
  end
  block, offsets
end

@generated function add_strings!(strings, entry)
  ex = Expr(:block)
  for (name, subT) in zip(fieldnames(entry), fieldtypes(entry))
    subT === String && push!(ex.args, :(push!(strings, entry.$name)))
    subT === LString && push!(ex.args, :(add_strings!(strings, entry.$name)))
  end
  ex
end

@generated function sizeofentry(::Type{T}) where {T}
  sum(fieldtypes(T); init = 0) do subT
    subT === String && return 4
    subT === LString && return sizeofentry(LString)
    sizeof(subT)
  end
end

@generated function write_dbc_row(io::IO, entry, offsets)
  ex = Expr(:block)
  for (name, subT) in zip(fieldnames(entry), fieldtypes(entry))
    if subT === String
      push!(ex.args, :(write(io, offsets[entry.$name])))
    elseif subT === LString
      for (_name, _subT) in zip(fieldnames(subT), fieldtypes(subT))
        if _subT === String
          push!(ex.args, :(write(io, offsets[entry.$name.$_name])))
        else
          push!(ex.args, :(write(io, entry.$name.$_name)))
        end
      end
    else
      push!(ex.args, :(write(io, entry.$name)))
    end
  end
  ex
end

function write_dbc(io::IO, data::AbstractVector{T}) where {T}
  write(io, tag4"WDBC") # magic number
  write(io, UInt32(length(data))) # record count
  write(io, UInt32(_fieldcount(T))) # field count
  write(io, UInt32(sizeofentry(T))) # record size
  block, offsets = string_block(data)
  write(io, UInt32(length(block))) # string block size
  for entry in data
    write_dbc_row(io, entry, offsets)
  end
  write(io, block)
end
