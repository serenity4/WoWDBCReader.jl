struct MPQHeader
  block_size::UInt32
  # Number of entries in the hash table. Must be a power of two, and must be less than 2^16 for
  # the original MoPaQ format, or less than 2^20 for the Burning Crusade format.
  hash_table_length::UInt32
  # Number of entries in the block table.
  block_table_length::UInt32
  # Offset to the beginning of the hash table, relative to the beginning of the archive.
  hash_table_offset::UInt64
  # Offset to the beginning of the block table, relative to the beginning of the archive.
  block_table_offset::UInt64
end

function MPQHeader(block_size, hash_table_length, block_table_length; hash_table_offset = 44, block_table_offset = hash_table_offset + hash_table_length * sizeof(MPQHashTable))
  MPQHeader(block_size, hash_table_length, block_table_length, hash_table_offset, block_table_offset)
end

struct MPQFile end

struct MPQHashTable end

struct MPQArchive{IO<:Base.IO}
  io::IO
  max_file_count::UInt32
  hash_table
end
