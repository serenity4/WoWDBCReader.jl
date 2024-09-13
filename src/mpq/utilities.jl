function listfile(archive::MPQArchive)
  file = find_file(archive, "(listfile)")
  isnothing(file) && return nothing
  data = read(file)
  split(String(data), in(('\r', '\n', ';')); keepempty = false)
end

Base.getindex(archive::MPQArchive, filename::AbstractString) = MPQFile(archive, filename)
Base.get(archive::MPQArchive, filename::AbstractString, default) = something(find_file(archive, filename), default)
