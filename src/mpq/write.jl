function Base.write(io::IO, archive::MPQArchive)
  archive_start = position(io)
  # Write dummy header, it will be updated once we know what to put in there.
  for _ in 1:44 write(io, UInt8(0)) end

  hash_table, block_overrides = recompute_hash_table(archive)
  block_table = write_blocks(io, archive, block_overrides)
  hash_table_offset = position(io) - archive_start
  write(io, hash_table)
  padding = (position(io) - archive_start) % 4
  for _ in 1:padding write(io, UInt8(0)) end
  block_table_offset = position(io) - archive_start
  write(io, block_table)
  archive_end = position(io)
  header = MPQHeader(archive, hash_table, block_table, hash_table_offset, block_table_offset)
  seek(io, archive_start)
  write(io, header)
  archive_end - archive_start
end

function write_blocks(io::IO, archive::MPQArchive, block_overrides)
  blocks = Vector{MPQBlock}(undef, length(archive.block_table.entries))
  overwritten_files = IdSet{MPQFile}()
  for (i, block) in enumerate(archive.block_table.entries)
    override = get(block_overrides, i - 1, nothing)
    if !isnothing(override)
      push!(overwritten_files, override)
      block = write_block(io, archive, override)
    else
      seek(archive.io, block.file_offset)
      bytes = read(archive.io, block.compressed_file_size)
      block = @set block.file_offset = position(io)
      write(io, bytes)
    end
    blocks[i] = block
  end
  for file in archive.files
    # If the file has been written already, skip it.
    in(file, overwritten_files) && continue
    block = write_block(io, archive, file)
    push!(blocks, block)
  end
  MPQBlockTable(blocks)
end

function write_block(io::IO, archive::MPQArchive, file::MPQFile)
  offset = position(io)
  isempty(file.data) && read(file)
  uncompressed_size = length(file.data)
  key = shouldencrypt(file) ? file_decryption_key(file.filename, offset, uncompressed_size, file.flags) : nothing
  compressed_size = if shouldcompress(file)
    write_compressed_sectors(io, archive, file, key)
  else
    write_uncompressed_sectors(io, archive, file, key)
  end
  MPQBlock(offset, compressed_size, uncompressed_size, file.flags | MPQ_FILE_EXISTS)
end

function write_uncompressed_sectors(io::IO, archive::MPQArchive, file::MPQFile, key::Optional{UInt32})
  (; sector_size) = archive
  nb = length(file.data)
  ns = cld(nb, sector_size)
  final_size = nb % sector_size
  written = 0
  for i in 1:ns
    size = i == ns ? final_size : sector_size
    sector = @view file.data[1 + ((i - 1) * sector_size):((i - 1) * sector_size + size)]
    sector = reinterpret(UInt32, sector)
    !isnothing(key) && encrypt_block!(sector, key + UInt32(i - 1))
    written += write(io, sector)
  end
  written
end

function write_compressed_sectors(io::IO, archive::MPQArchive, file::MPQFile, key::Optional{UInt32})
  (; sector_size) = archive
  nb = length(file.data)
  ns = cld(nb, sector_size)
  final_size = nb % sector_size
  method = something(file.compression, DEFAULT_COMPRESSION_METHOD)
  start = position(io)
  for _ in 1:(ns + 1) write(io, Int32(0)) end
  offset::Int32 = 4(ns + 1)
  offsets = Int32[offset]
  compression_buffer = zeros(UInt8, 2sector_size)
  for i in 1:ns
    uncompressed_sector_size = i == ns ? final_size : sector_size
    sector = @view file.data[(1 + (i - 1) * sector_size):((i - 1) * sector_size + uncompressed_sector_size)]
    !isnothing(key) && encrypt_block!(reinterpret(UInt32, sector), key + UInt32(i - 1))
    compressed = compress!(compression_buffer, IOBuffer(sector), method)
    compressed_sector_size = 1 + length(compressed)
    if compressed_sector_size ≥ uncompressed_sector_size
      # Compression failed to yield a smaller sector size.
      # Store the sector uncompressed.
      write(io, sector)
      offset += uncompressed_sector_size
    else
      write(io, UInt8(method))
      write(io, compressed)
      offset += compressed_sector_size
    end
    push!(offsets, offset)
  end
  after = position(io)
  seek(io, start)
  write(io, offsets)
  seek(io, after)
  offset
end

function recompute_hash_table(archive::MPQArchive)
  block_overrides = Dictionary{UInt32, MPQFile}()
  isempty(archive.files) && return archive.hash_table, block_overrides
  if length(archive.block_table.entries) + length(archive.files) > length(archive.hash_table.entries)
    error("Maximum number of files reached; you must create a new archive with a greater upper bound on the file limit.")
  end
  ht = deepcopy(archive.hash_table)
  block_index_start = length(archive.block_table.entries)
  for (i, file) in enumerate(archive.files)
    (; filename, locale) = file
    slot = hash_table_slot(ht, filename; locale, find_free = true)
    prev = ht.entries[slot]
    if prev.block_index !== 0xffffffff
      insert!(block_overrides, prev.block_index, file)
    end
    ha = hash_filename(filename, MPQ_HASH_NAME_A)
    hb = hash_filename(filename, MPQ_HASH_NAME_B)
    entry = MPQHashTableEntry(ha, hb, something(locale, get_locale()), 0, 0, block_index_start + (i - 1))
    ht.entries[slot] = entry
  end
  ht, block_overrides
end

function Base.write(io::IO, ht::MPQHashTable)
  data = reinterpret(UInt32, ht.entries)
  encrypt_block!(data, MPQ_KEY_HASH_TABLE)
  write(io, data)
end

function Base.write(io::IO, bt::MPQBlockTable)
  data = reinterpret(UInt32, bt.entries)
  encrypt_block!(data, MPQ_KEY_BLOCK_TABLE)
  write(io, data)
end

function MPQHeader(archive::MPQArchive, hash_table::MPQHashTable, block_table::MPQBlockTable, hash_table_offset, block_table_offset)
  hash_table_length = length(hash_table.entries)
  block_table_length = length(block_table.entries)
  MPQHeader(archive.sector_size, hash_table_length, block_table_length, hash_table_offset, block_table_offset)
end

function Base.write(io::IO, header::MPQHeader)
  header_size = UInt32(44)
  write(io, MPQ_MAGIC_NUMBER) # 4
  write(io, header_size) # 8

  # This field has been deprecated and should be recomputed for robustness.
  archive_size = UInt32(0)
  write(io, archive_size) # 12

  # Format for Burning Crusade & newer up to Cataclysm Beta.
  format = UInt16(1)
  write(io, format) # 14

  # Power of two exponent specifying the number of 512-byte disk sectors in each logical sector
  # in the archive. The size of each logical sector in the archive is 512 * 2^block_size.
  write(io, UInt16(log2(header.sector_size ÷ 512))) # 16

  hi_hash_table_offset, hash_table_offset = decompose_offset(header.hash_table_offset)

  hi_block_table_offset, block_table_offset = decompose_offset(header.block_table_offset)

  write(io, hash_table_offset) # 20
  write(io, block_table_offset) # 24
  write(io, UInt32(header.hash_table_length)) # 28
  write(io, UInt32(header.block_table_length)) # 32

  # Offset to the beginning of array of 16-bit high parts of file offsets.
  hi_block_table_offset_64 = UInt64(0)
  write(io, hi_block_table_offset_64) # 40

  # High 16 bits of the hash table offset for large archives.
  write(io, hi_hash_table_offset) # 42

  # High 16 bits of the block table offset for large archives.
  write(io, hi_block_table_offset) # 44
end
