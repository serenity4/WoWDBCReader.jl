using WoWDataParser
using WoWDataParser: RGBA, RGB16, N0f8
using BinaryParsingTools: read_binary
const WoW = WoWDataParser
using Test

dbc_file(name) = joinpath(DBC_DIRECTORY, "$name.dbc")

mpq_file(name) = joinpath(DATA_DIRECTORY, "$name.MPQ")

@testset "WoWDataParser.jl" begin
  @testset "Localization" begin
    @test get_locale() === :enUS
    set_locale(:enGB)
    @test get_locale() === :enGB
    set_locale(:enUS)

    @test get_default_mpq_locale() === MPQ_LOCALE_NEUTRAL
    set_default_mpq_locale(MPQ_LOCALE_ENGLISH)
    @test get_default_mpq_locale() === MPQ_LOCALE_ENGLISH
    set_default_mpq_locale(MPQ_LOCALE_NEUTRAL)

    @test get_default_dbc_locale() === DBC_LOCALE_EN_US
    set_default_dbc_locale(DBC_LOCALE_FR_FR)
    @test get_default_dbc_locale() === DBC_LOCALE_FR_FR
    set_default_dbc_locale(DBC_LOCALE_EN_US)

    set_locale(:enUS)
    lstr = l"English text"
    @test lstr[] == "English text"
    set_locale(:frFR)
    @test lstr[] == ""
    lstr = l"Texte français"
    @test lstr[] == "Texte français"
    set_locale(:enUS)
    @test lstr[] == ""
    lstr = LString((:enUS, :frFR))
    @test lstr[] == ""
    lstr = setproperties(lstr, (frFR = "Texte français", enUS = "English text"))
    @test lstr[] == "English text"
    set_locale(:frFR)
    @test lstr[] == "Texte français"
    set_locale(:enUS)

    x = l"Hello"
    y = l"Hello"
    @test x == y
    x = l"ello"
    y = l"Hello"
    @test x != y
    x = setproperties(LString(), (; enUS = "US", frFR = "FR"))
    y = l"US"
    @test x ≠ y && x[] == y[]
  end

  @testset "DBC files" begin
    @testset "Reading DBC files" begin
      dbc = DBCData(dbc_file(:TalentTab))
      @test dbc.name === :TalentTab
      @test isa(dbc, DBCData{TalentTabData})
      @test length(dbc.rows) == 33

      dbc = DBCData(dbc_file(:Talent))
      @test isa(dbc, DBCData{TalentData})
      @test length(dbc.rows) == 892

      dbc = DBCData(dbc_file(:Map))
      @test isa(dbc, DBCData{MapData})
      @test length(dbc.rows) == 135

      dbc = DBCData(dbc_file(:Spell))
      @test isa(dbc, DBCData{SpellData})
      @test length(dbc.rows) > 49000

      file = DBCFile(dbc_file(:Map))
      @test file.name === :Map
      @test read(file) == DBCData(dbc_file(:Map))
    end

    @testset "Writing DBC files" begin
      dbc = DBCData(dbc_file(:TalentTab))
      file = DBCFile(dbc)
      dbc2 = read(file)
      @test dbc == dbc2

      dbc = DBCData(dbc_file(:Spell))
      file = DBCFile(dbc)
      dbc2 = read(file)
      @test dbc == dbc2
    end
  end

  @testset "MPQ files" begin
    # Missing features:
    # - Sector checksum verification.
    # Missing tests:
    # - Sector-based encryption/decryption.

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
      talent_tabs = DBCData(talent_tabs_dbc, :TalentTab)
      ref = DBCData(dbc_file(:TalentTab))
      @test talent_tabs == ref

      archive = MPQArchive(mpq_file("enUS/patch-enUS-3"))
      map_dbc = read(archive["DBFilesClient\\Map.dbc"])
      map = DBCData(map_dbc, :Map)
      ref = DBCData(dbc_file(:Map))
      @test map == ref
      spell_dbc = read(archive["DBFilesClient\\Spell.dbc"])
      spell = DBCData(spell_dbc, :Spell)
      ref = DBCData(dbc_file(:Spell))
      @test spell == ref
    end

    @testset "Writing MPQ files" begin
      # Archive with no files.
      archive = MPQArchive()
      buffer = IOBuffer()
      nb = write(buffer, archive)
      @test nb > 65536
      seekstart(buffer)
      archive2 = MPQArchive(buffer)
      @test length(archive2.block_table.entries) == 1 # listfile
      seekstart(buffer)
      @test write(buffer, archive2) == nb

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
      @test length(archive2.block_table.entries) == 3
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
      @test length(archive2.block_table.entries) == 3
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

    @testset "MPQ collections" begin
      collection = MPQCollection([mpq_file("enUS/patch-enUS-3"), mpq_file("enUS/locale-enUS")])
      file = MPQFile(collection, "DBFilesClient\\Achievement.dbc")
      @test file === MPQFile(collection.archives[1], file.filename)
      file = MPQFile(collection, "Fonts\\FRIENDS.TTF")
      @test file === MPQFile(collection.archives[1], file.filename)
      file = MPQFile(collection, "Fonts\\MORPHEUS.TTF")
      @test file === MPQFile(collection.archives[2], file.filename)

      mpq_files = WoW.ClientMPQFiles(DATA_DIRECTORY)
      sorted = WoW.files_sorted_by_priority(mpq_files)
      priority(file) = length(sorted) - findfirst(==(file), sorted)
      @test priority("enUS/patch-enUS-3.MPQ") > priority("enUS/patch-enUS-2.MPQ")
      @test priority("enUS/patch-enUS-3.MPQ") > priority("patch-3.MPQ")
      @test priority("patch-3.MPQ") > priority("patch-2.MPQ")
      @test priority("patch-2.MPQ") > priority("patch.MPQ")
      @test priority("lichking.MPQ") > priority("expansion.MPQ")
      @test priority("common-2.MPQ") > priority("common.MPQ")
      collection = MPQCollection(DATA_DIRECTORY)
      @test length(collection.archives) > 10
      @test length(collection.file_sources) > 200000
    end
  end

  @testset "BLP files" begin
    # The following example files were identified on https://wowwiki-archive.fandom.com/wiki/BLP_file
    # for their specific features suitable for testing.
    @testset "Reading BLP files" begin
      collection = MPQCollection([mpq_file("enUS/locale-enUS"), mpq_file("common"), mpq_file("lichking")])

      @testset "BLP compression" begin
        # No alpha.
        icon = MPQFile(collection, "Interface\\GLUES\\LoadingBar\\Loading-BarGlow.blp")
        file = BLPFile(read(icon))
        nx, ny = size(file.image)
        @test nx == 512 && ny == 128
        @test length(file.mipmaps) == log2(ny)
        @test size(file.mipmaps[end]) == (4, 1)
        @test file.image[400, 64] === RGBA{N0f8}(0.0, 0.008, 0.012, 0.02)

        # 1-bit alpha.
        icon = MPQFile(collection, "Interface\\CURSOR\\Attack.blp")
        file = BLPFile(read(icon))
        nx, ny = size(file.image)
        @test nx == 32 && ny == 32
        @test length(file.mipmaps) == log2(nx)
        @test size(file.mipmaps[end]) == (1, 1)
        @test file.image[16, 14] === RGBA{N0f8}(0.0, 0.565, 0.725, 0.776)

        # 4-bit alpha.
        icon = MPQFile(collection, "Character\\Tauren\\Female\\TAURENFEMALESKIN00_01_EXTRA.BLP")
        file = BLPFile(read(icon))
        @test file.image[16, 14] === RGBA{N0f8}(0.0, 0.141, 0.125, 0.988)

        # 8-bit alpha.
        icon = MPQFile(collection, "Interface\\CURSOR\\Buy.blp")
        file = BLPFile(read(icon))
        @test file.image[16, 14] === RGBA{N0f8}(0.0, 0.482, 0.369, 0.973)
      end

      @testset "DTX1 compression" begin
        @testset "RGB16" begin
          rgb = RGB16(N0f8(0.5), N0f8(0.2), N0f8(0.3))
          @test rgb.r === N0f8(0.502)
          @test rgb.g === N0f8(0.188)
          @test rgb.b === N0f8(0.282)
        end

        # No alpha.
        icon = MPQFile(collection, "Interface\\Icons\\Trade_Alchemy.blp")
        file = BLPFile(read(icon))
        @test file.image[6] === RGBA{N0f8}(0.0, 0.016, 0.031, 1.0)
        @test file.image[89] === RGBA{N0f8}(0.251, 0.251, 0.251, 1.0)
        @test file.image[465] === RGBA{N0f8}(0.878, 0.863, 0.784, 1.0)

        # 1-bit alpha.
        icon = MPQFile(collection, "Interface\\AUCTIONFRAME\\BuyoutIcon.blp")
        file = BLPFile(read(icon))
        @test file.image[2] === RGBA{N0f8}(0.847, 0.706, 0.0, 1.0)

        # Has a with of 768 pixels.
        icon = MPQFile(collection, "TILESET\\Terrain Cube Maps\\TCB_CrystalSong_A.blp")
        @test_throws "must be a power of two" file = BLPFile(read(icon))
      end

      @testset "DTX3 compression" begin
        # 4-bit alpha.
        icon = MPQFile(collection, "Interface\\Icons\\INV_Fishingpole_02.blp")
        file = BLPFile(read(icon))
      end

      @testset "DTX5 compression" begin
        # No alpha.
        icon = MPQFile(collection, "Environments\\Stars\\HellFireSkyNebula03.blp")
        file = BLPFile(read(icon))

        # 8-bit alpha.
        icon = MPQFile(collection, "Interface\\Icons\\Ability_Rogue_Shadowstep.blp")
        file = BLPFile(read(icon))
      end

      @testset "No compression" begin
        # TODO (requires data from Cataclysm or later)
      end
    end
  end
end;
