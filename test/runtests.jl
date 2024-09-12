using WoWDBCReader
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

  @testset "MPQ files" begin
    @testset "Hash computations" begin
      @test WoW.SEED_BUFFER[1] === 0x55c636e2
      @test WoW.SEED_BUFFER[2] === 0x2be0170
      @test WoW.SEED_BUFFER[1140] === 0xf32f1333
      @test WoW.hash_filename("(hash table)", WoW.MPQ_HASH_FILE_KEY) === 0xc3af3770
      @test WoW.hash_filename("(block table)", WoW.MPQ_HASH_FILE_KEY) === 0xec83b3a3
    end

    header = read_mpq(mpq_file("patch-3"), MPQHeader)
    @test header.hash_table_length == 4096
    @test header.block_table_length == 2996
    archive = read_mpq(mpq_file("patch-3"), MPQArchive)
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
  end
end;
