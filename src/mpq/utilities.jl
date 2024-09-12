function listfile(archive::MPQArchive)
  data = find_file(archive, "(listfile)")
  split(String(data), in(('\r', '\n', ';')); keepempty = false)
end
