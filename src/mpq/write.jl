function Base.write(io::IO, archive::MPQArchive)
  header = MPQHeader(archive)
  write(io, header)
  write(io, archive.hash_table)
  padding = (header.block_table_offset - header.hash_table_offset) - ht_size(archive.hash_table)
  for _ in 1:padding
    write(io, UInt8)
  end
  write(io, archive.block_table)
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

function MPQHeader(archive::MPQArchive)
  hash_table_length = length(archive.hash_table.entries)
  block_table_length = length(archive.block_table.entries)
  hash_table_offset = 44
  block_table_offset = 4cld(44 + ht_size(archive.hash_table), 4)
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
