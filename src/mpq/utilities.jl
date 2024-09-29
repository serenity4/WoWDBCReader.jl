function listfile(archive::MPQArchive)
  file = find_file(archive, "(listfile)")
  isnothing(file) && return nothing
  data = read(file)
  split(replace(lowercase(String(data)), '\\' => '/'), in(('\r', '\n', ';')); keepempty = false)
end

Base.getindex(archive::MPQArchive, filename::AbstractString) = MPQFile(archive, filename)
Base.get(archive::MPQArchive, filename::AbstractString, default) = something(find_file(archive, filename), default)

# TODO: Preserve listfile entries for blocks we will be rewriting without modification.
function regenerate_listfile!(archive::MPQArchive)
  filename = "(listfile)"
  haskey(archive.files, filename) && delete!(archive.files, filename)
  list = join(keys(archive.files), '\n')
  io = IOBuffer()
  write(io, list)
  seekstart(io)
  bytes = take!(io)
  MPQFile(archive, filename, bytes; locale = MPQ_LOCALE_NEUTRAL)
  archive
end
