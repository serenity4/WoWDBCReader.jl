using WoWDBCReader
using BinaryParsingTools: read_binary
const WoW = WoWDBCReader
using Test

dbc_file(name) = joinpath("/home/serenity4/Documents/programming/wow-local/node-dbc-reader/data/dbc", "$name.dbc")

mpq_file(name) = joinpath("/home/serenity4/Games/world-of-warcraft-wrath-of-the-lich-king/drive_c/world_of_warcraft_wrath_of_the_lich_king/Data", "$name.MPQ")

archive = MPQArchive(mpq_file("patch-3"))
block = find_block(archive, "(listfile)")
files = listfile(archive)

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
  end
end;
