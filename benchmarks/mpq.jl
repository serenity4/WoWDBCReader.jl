using WoWDataParser

mpq_file(name) = joinpath("/home/serenity4/Games/world-of-warcraft-wrath-of-the-lich-king/drive_c/world_of_warcraft_wrath_of_the_lich_king/Data", "$name.MPQ")

@btime read(archive["DBFilesClient\\Spell.dbc"]) setup = archive = MPQArchive(mpq_file("enUS/patch-enUS-3"));
@profview for _ in 1:10; archive = MPQArchive(mpq_file("enUS/patch-enUS-3")); read(archive["DBFilesClient\\Spell.dbc"]); end

@profview for _ in 1:5
  archive = MPQArchive(mpq_file("enUS/patch-enUS-3"))
  data = read(archive["DBFilesClient\\Spell.dbc"])
  new = MPQArchive()
  file = MPQFile(new, "DBFilesClient\\Spell.dbc", data)
  io = IOBuffer()
  write(io, new)
end
