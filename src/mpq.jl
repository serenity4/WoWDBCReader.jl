struct MPQFile end

struct MPQHashTable end

struct MPQArchive end

function initialize_mpq_archive(io::IO; max_file_count, block_size = 512)
  header_size = UInt32(44)

  # Size of MPQ archive
  # This field is deprecated in the Burning Crusade MoPaQ format, and the size of the archive
  # is calculated as the size from the beginning of the archive to the end of the hash table,
  # block table, or extended block table (whichever is largest).
  archive_size = UInt32(0)

  # Header.

  magic_number = "MPQ\x1A"
  write(io, magic_number) # 4
  write(io, header_size) # 8
  write(io, archive_size) # 12

  # Format for Burning Crusade & newer up to Cataclysm Beta.
  format = UInt16(1)
  write(io, format) # 14

  # Power of two exponent specifying the number of 512-byte disk sectors in each logical sector
  # in the archive. The size of each logical sector in the archive is 512 * 2^block_size.
  block_size = 0
  write(io, block_size) # 16

  # Offset to the beginning of the hash table, relative to the beginning of the archive.
  hash_table_offset = header_size
  # Number of entries in the hash table. Must be a power of two, and must be less than 2^16 for
  # the original MoPaQ format, or less than 2^20 for the Burning Crusade format.
  hash_table_length = UInt32(0)
  # Offset to the beginning of the block table, relative to the beginning of the archive.
  block_table_offset = hash_table_offset + hash_table_length * sizeof(MPQHashTable)
  # Number of entries in the block table
  block_table_length = UInt32(0)

  write(io, hash_table_offset) # 20
  write(io, block_table_offset) # 24
  write(io, hash_table_length) # 28
  write(io, block_table_length) # 32

  # Offset to the beginning of array of 16-bit high parts of file offsets.
  hi_block_table_offset_64 = UInt64(0)
  write(io, hi_block_table_offset_64) # 40

  # High 16 bits of the hash table offset for large archives.
  hi_hash_table_offset = UInt16(0)
  write(io, hi_hash_table_offset) # 42

  # High 16 bits of the block table offset for large archives.
  hi_block_table_offset = UInt16(0)
  write(io, hi_block_table_offset) # 44

  hash_table_length ≠ 0 && write_hash_table(io)
  max_file_count > 0 && write_file_table(io)
end
