using WoWDBCReader
using BinaryParsingTools: read_binary
const WoW = WoWDBCReader
using Test

dbc_file(name) = joinpath("/home/serenity4/Documents/programming/wow-local/node-dbc-reader/data/dbc", "$name.dbc")

mpq_file(name) = joinpath("/home/serenity4/Games/world-of-warcraft-wrath-of-the-lich-king/drive_c/world_of_warcraft_wrath_of_the_lich_king/Data", "$name.MPQ")

@testset "WoWDBCReader.jl" begin
  @testset "DBC files" begin
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
  end

  @testset "MPQ files" begin
    @testset "Hash computations" begin
      @test WoW.SEED_BUFFER[1] === 0x55c636e2
      @test WoW.SEED_BUFFER[2] === 0x2be0170
      @test WoW.SEED_BUFFER[1140] === 0xf32f1333
      @test WoW.hash_filename("(hash table)", WoW.MPQ_HASH_FILE_KEY) === 0xc3af3770
      @test WoW.hash_filename("(block table)", WoW.MPQ_HASH_FILE_KEY) === 0xec83b3a3
    end

    @testset "Encryption" begin
      data = rand(UInt32, 1024)
      key = rand(UInt32)
      original = deepcopy(data)
      WoW.encrypt_block!(data, key)
      @test data ≠ original
      WoW.decrypt_block!(data, key)
      @test data == original
    end

    @testset "Reading MPQ files" begin
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
      @test_throws "No file" archive["doesnotexist"]
      data = read(archive["(listfile)"])
      @test length(data) === Int(block.uncompressed_file_size)
      files = listfile(archive)
      @test length(files) === 2994
      @test files[begin] == "CHARACTER\\BloodElf\\Female\\BloodElfFemale.M2"
      @test files[end] == "WTF\\DefaultBindings.wtf"

      archive = MPQArchive(mpq_file("enUS/patch-enUS"))
      talent_tabs_dbc = read(archive["DBFilesClient\\TalentTab.dbc"])
      talent_tabs = read_dbc(talent_tabs_dbc, :talenttab)
      ref = read_dbc(dbc_file(:TalentTab), :talenttab)
      @test talent_tabs == ref

      archive = MPQArchive(mpq_file("enUS/patch-enUS-3"))
      map_dbc = read(archive["DBFilesClient\\Map.dbc"])
      map = read_dbc(map_dbc, :map)
      ref = read_dbc(dbc_file(:Map), :map)
      @test map == ref
      spell_dbc = read(archive["DBFilesClient\\Spell.dbc"])
      spell = read_dbc(spell_dbc, :spell)
      ref = read_dbc(dbc_file(:Spell), :spell)
      @test spell == ref
    end

    @testset "Writing MPQ files" begin
      # Archive with no files.
      archive = MPQArchive()
      buffer = IOBuffer()
      @test write(buffer, archive) == 65536 + 44
      seekstart(buffer)
      archive2 = MPQArchive(buffer)
      @test isempty(archive2.block_table.entries)
      @test write(buffer, archive2) == 65536 + 44

      # Archive with two user-created files.
      archive = MPQArchive()
      # This file will be stored as a single uncompressed sector in practice,
      # because compression will not make it smaller than its data.
      file_a = MPQFile(archive, "Test\\A", UInt8[0x18, 0x9a, 0xdf, 0xe1, 0xad])
      @test_throws "already exists" MPQFile(archive, "Test\\A", file_a.data)
      file_b = MPQFile(archive, "Test\\B", ones(UInt8, 5000))
      buffer = IOBuffer()
      nb = write(buffer, archive)
      @test nb > 65536 + 44

      seekstart(buffer)
      archive2 = MPQArchive(buffer)
      @test length(archive2.block_table.entries) == 2
      file_a_2 = archive2["Test\\A"]
      file_b_2 = archive2["Test\\B"]
      @test file_a_2.block[].uncompressed_file_size == 5
      @test file_b_2.block[].uncompressed_file_size == 5000
      @test read(file_a_2) == read(file_a)
      @test read(file_b_2) == read(file_b)
      @test write(IOBuffer(), archive2) == nb

      # Same, but with one file uncompressed.
      archive = MPQArchive()
      file_a = MPQFile(archive, "Test\\A", ones(UInt8, 256); compression = nothing)
      @test_throws "already exists" MPQFile(archive, "Test\\A", rand(UInt8, 256))
      file_b = MPQFile(archive, "Test\\B", ones(UInt8, 5000))
      buffer = IOBuffer()
      nb = write(buffer, archive)
      @test nb > 65536 + 44

      seekstart(buffer)
      archive2 = MPQArchive(buffer)
      @test length(archive2.block_table.entries) == 2
      file_a_2 = archive2["Test\\A"]
      file_b_2 = archive2["Test\\B"]
      @test file_a_2.block[].uncompressed_file_size == 256
      @test file_a_2.block[].compressed_file_size == 256
      @test file_b_2.block[].uncompressed_file_size == 5000
      @test read(file_a_2) == read(file_a)
      @test read(file_b_2) == read(file_b)

      archive = MPQArchive(mpq_file("enUS/patch-enUS"))
      data = read(archive["DBFilesClient\\TalentTab.dbc"])
      part = MPQArchive()
      file = MPQFile(part, "DBFilesClient\\TalentTab.dbc", data)
      buffer = IOBuffer()
      write(buffer, part)
      seekstart(buffer)
      archive2 = MPQArchive(buffer)
      data2 = read(archive2["DBFilesClient\\TalentTab.dbc"])
      @test data2 == data
    end
  end
end;
