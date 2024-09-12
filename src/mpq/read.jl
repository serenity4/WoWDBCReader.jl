function read_mpq(path::AbstractString, ::Type{T} = MPQArchive) where {T}
  open(io -> read_binary(io, T), path, "r")
end

function Base.read(io::BinaryIO, ::Type{MPQArchive})
  header = read(io, MPQHeader)
  ht = read(io, MPQHashTable, header)
  bt = read(io, MPQBlockTable, header)
  MPQArchive(ht, bt)
end

function extended_offset(hi, offset)
  hi == 0 && return UInt64(offset)
  (UInt64(hi) << 32) | UInt64(offset)
end

function decompose_offset(offset)
  offset = convert(UInt64, offset)
  offset & 0xffff0000 == 0 && return (UInt16(0), UInt32(offset))
  hi = UInt16(offset >> 32)
  low = UInt32(offset & 0x0000ffff)
  (hi, low)
end

const MPQ_MAGIC_NUMBER = Tag4(('M', 'P', 'Q', '\x1A'))

function Base.read(io::IO, ::Type{MPQHeader})
  magic_number = read(io, Tag4)
  magic_number === MPQ_MAGIC_NUMBER || error("The file's magic number does not correspond to a MPQ format.")
  header_size = read(io, UInt32)
  header_size == 44 || error("Expected a header size of 44 bytes.")
  archive_size = read(io, UInt32)
  format = read(io, UInt16)
  format == 1 || error("Only WOTLK-compatible MPQ files are supported; format must therefore be 1, but is $format")
  block_size_exponent = read(io, UInt16)
  block_size = exp2(block_size_exponent)

  hash_table_offset = read(io, UInt32)
  block_table_offset = read(io, UInt32)
  hash_table_length = read(io, UInt32)
  block_table_length = read(io, UInt32)

  hi_block_table_offset_64 = read(io, UInt64)
  hi_hash_table_offset = read(io, UInt16)
  hi_block_table_offset = read(io, UInt16)

  hash_table_offset = extended_offset(hi_hash_table_offset, hash_table_offset)
  block_table_offset = extended_offset(hi_block_table_offset, block_table_offset)

  if hi_block_table_offset_64 ≠ 0
    error("Expected value of `hi_block_table_offset_64` to be zero; got $hi_block_table_offset_64 instead")
  end

  MPQHeader(block_size, hash_table_length, block_table_length, hash_table_offset, block_table_offset)
end

function Base.read(io::IO, ::Type{MPQHashTable}, header::MPQHeader)
  compressed = ht_size_compressed(header) < ht_size(header)
  !compressed || error("Compressed hash tables are not supported")

  seek(io, header.hash_table_offset)
  data = [read(io, UInt32) for _ in 1:(ht_size_compressed(header) ÷ 4)]
  decrypt_block!(data, MPQ_KEY_HASH_TABLE)
  # Decompression step would go there.
  entries = reinterpret(MPQHashTableEntry, data)
  MPQHashTable(entries)
end

function Base.read(io::IO, ::Type{MPQBlockTable}, header::MPQHeader)
  seek(io, header.block_table_offset)
  data = [read(io, UInt32) for _ in 1:4header.block_table_length]
  decrypt_block!(data, MPQ_KEY_BLOCK_TABLE)
  entries = reinterpret(MPQBlock, data)
  MPQBlockTable(entries)
end
