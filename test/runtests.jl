using WoWDBCReader
using BinaryParsingTools: read_binary
const WoW = WoWDBCReader
using Test

dbc_file(name) = joinpath("/home/serenity4/Documents/programming/wow-local/node-dbc-reader/data/dbc", "$name.dbc")

mpq_file(name) = joinpath("/home/serenity4/Games/world-of-warcraft-wrath-of-the-lich-king/drive_c/world_of_warcraft_wrath_of_the_lich_king/Data", "$name.MPQ")

@testset "WoWDBCReader.jl" begin
  @testset "Reading DBC files" begin
    dbc = read_dbc(dbc_file(:TalentTab), :talenttab)
    @test isa(dbc, Vector{TalenttabData})
    @test length(dbc) == 33

    dbc = read_dbc(dbc_file(:Talent), :talent)
    @test isa(dbc, Vector{TalentData})
    @test length(dbc) == 892

    dbc = read_dbc(dbc_file(:Map), :map)
    @test isa(dbc, Vector{MapData})
    @test length(dbc) == 135

    dbc = read_dbc(dbc_file(:Spell), :spell)
    @test isa(dbc, Vector{SpellData})
    @test length(dbc) > 49000
  end

  @testset "Writing DBC files" begin
    dbc = read_dbc(dbc_file(:TalentTab), :talenttab)
    buffer = IOBuffer()
    write_dbc(buffer, dbc)
    seekstart(buffer)
    dbc2 = read_dbc(buffer, :talenttab)
    @test dbc == dbc2

    dbc = read_dbc(dbc_file(:Spell), :spell)
    buffer = IOBuffer()
    write_dbc(buffer, dbc)
    seekstart(buffer)
    dbc2 = read_dbc(buffer, :spell)
    @test dbc == dbc2
  end

  @testset "MPQ files" begin
    @testset "Hash computations" begin
      @test WoW.SEED_BUFFER[1] === 0x55c636e2
      @test WoW.SEED_BUFFER[2] === 0x2be0170
      @test WoW.SEED_BUFFER[1140] === 0xf32f1333
      @test WoW.hash_filename("(hash table)", WoW.MPQ_HASH_FILE_KEY) === 0xc3af3770
      @test WoW.hash_filename("(block table)", WoW.MPQ_HASH_FILE_KEY) === 0xec83b3a3
    end

    header = open(io -> read_binary(io, MPQHeader), mpq_file("patch-3"))
    @test header.sector_size == 4096
    @test header.hash_table_length == 4096
    @test header.block_table_length == 2996
    archive = MPQArchive(mpq_file("patch-3"))
    (; hash_table, block_table) = archive
    nh = length(hash_table.entries)
    @test nh == header.hash_table_length
    @test count(==(MPQHashTableEntry()), hash_table.entries) < 0.3nh
    nb = length(block_table.entries)
    @test nb == header.block_table_length
    for block in block_table.entries
      if in(MPQ_FILE_DELETE_MARKER, block.flags)
        @test block.compressed_file_size == 0
        @test block.uncompressed_file_size == 0
      end
    end
    @test count(x -> x.compressed_file_size ≠ 0, block_table.entries) > 0.9nb
    slot = WoW.hash_table_slot(hash_table, "(listfile)")
    @test Int(slot) === 2138
    hash_entry = hash_table.entries[slot]
    @test Int(hash_entry.block_index) === 2994
    block = archive.block_table.entries[hash_entry.block_index + 1]
    @test Int(block.compressed_file_size) === 22027
    @test Int(block.uncompressed_file_size) === 166702
    @test block.flags === MPQ_FILE_COMPRESS | MPQ_FILE_SECTOR_CRC | MPQ_FILE_EXISTS
    @test block === block_table.entries[2995]
    data = find_file(archive, "(listfile)")
    @test length(data) === Int(block.uncompressed_file_size)
    files = listfile(archive)
    @test length(files) === 2994
    @test files[begin] == "CHARACTER\\BloodElf\\Female\\BloodElfFemale.M2"
    @test files[end] == "WTF\\DefaultBindings.wtf"

    archive = MPQArchive(mpq_file("enUS/patch-enUS"))
    talent_tabs_dbc = find_file(archive, "DBFilesClient\\TalentTab.dbc")
    talent_tabs = read_dbc(talent_tabs_dbc, :talenttab)
    ref = read_dbc(dbc_file(:TalentTab), :talenttab)
    @test talent_tabs == ref

    archive = MPQArchive(mpq_file("enUS/patch-enUS-3"))
    map_dbc = find_file(archive, "DBFilesClient\\Map.dbc")
    map = read_dbc(map_dbc, :map)
    ref = read_dbc(dbc_file(:Map), :map)
    @test map == ref
    spell_dbc = find_file(archive, "DBFilesClient\\Spell.dbc")
    spell = read_dbc(spell_dbc, :spell)
    ref = read_dbc(dbc_file(:Spell), :spell)
    @test spell == ref
  end
end;
