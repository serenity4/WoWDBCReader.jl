using WoWDataParser

mpq_file(name) = joinpath("/home/serenity4/Games/world-of-warcraft-wrath-of-the-lich-king/drive_c/world_of_warcraft_wrath_of_the_lich_king/Data", "$name.MPQ")

# DXT5 compression.
collection = MPQCollection([mpq_file("enUS/locale-enUS"), mpq_file("common"), mpq_file("lichking")])
icon = MPQFile(collection, "Environments\\Stars\\HellFireSkyNebula03.blp")
file = BLPFile(read(icon))
data = BLPData(file.image)

@btime write(io, $data) setup = io = IOBuffer()

@profview for _ in 1:200 write(IOBuffer(), data) end
