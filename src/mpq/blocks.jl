function find_file(archive::MPQArchive, filename::AbstractString)
  hash_entry = find_hash_entry(archive, filename)
  isnothing(hash_entry) && return nothing
  block = archive.block_table.entries[hash_entry.block_index + 1]
  MPQFile(archive, filename, hash_entry, block)
end

function MPQFile(archive::MPQArchive, filename::AbstractString)
  get!(archive.files, filename) do
    file = find_file(archive, filename)
    isnothing(file) && error("No file named '$filename' exists in this archive")
    file
  end
end

function Base.read(file::MPQFile)
  !isempty(file.data) && return file.data
  (; archive, filename) = file
  isdefined(file.block, 1) || error("The file must be associated with a block for data to be read")
  block = file.block[]
  seek(archive.io, block.file_offset)
  n = cld(Int64(block.uncompressed_file_size), archive.sector_size)
  key = in(MPQ_FILE_ENCRYPTED, block.flags) ? file_decryption_key(block, filename) : nothing
  compressed = block.uncompressed_file_size ≠ block.compressed_file_size
  imploded = in(MPQ_FILE_IMPLODE, block.flags)
  imploded && error("Imploded data is not supported at the moment.")
  if compressed
    read_compressed_block_data!(file.data, archive.io, block, n, archive.sector_size, key)
  else
    read_uncompressed_block_data(file.data, archive.io, block, n, archive.sector_size, key)
  end
  file.data
end

function find_hash_entry(archive::MPQArchive, filename::AbstractString)
  slot = hash_table_slot(archive.hash_table, filename)
  slot == 0xffffffff && return nothing
  archive.hash_table.entries[slot]
end

function read_compressed_block_data!(data::Vector{UInt8}, io::IO, block::MPQBlock, ns, sector_size, key::Optional{UInt32})
  p = position(io)
  sector_offsets = Int64[read(io, Int32) for _ in 1:(ns + 1)]
  final_size = Int64(block.uncompressed_file_size) % sector_size
  sector_buffer = zeros(UInt8, sector_size)
  decompression_buffer = zeros(UInt8, sector_size)
  for i in 1:ns
    i == ns && (decompression_buffer = zeros(UInt8, final_size))
    offset, next_offset = sector_offsets[i], sector_offsets[i + 1]
    compressed_sector_size = next_offset - offset
    seek(io, p + offset)
    in(MPQ_FILE_IMPLODE, block.flags) && error("PKWARE data compression is not supported at the moment.")
    method = read(io, MPQCompressionFlags)
    datasize = compressed_sector_size - one(compressed_sector_size)
    for j in 1:datasize
      sector_buffer[j] = read(io, UInt8)
    end
    sector = @view sector_buffer[1:datasize]
    sector = decompress!(decompression_buffer, sector, method)
    !isnothing(key) && decrypt_block!(reinterpret(UInt32, sector), key + UInt32(i))
    append!(data, sector)
  end
  data
end

function read_uncompressed_block_data!(data::Vector{UInt8}, io::IO, block::MPQBlock, ns, sector_size, key::Optional{UInt32})
  final_size = Int64(block.uncompressed_file_size) % sector_size
  sector_buffer = zeros(UInt8, sector_size)
  for i in 1:ns
    size = i == ns ? final_size : sector_size
    for j in 1:size
      sector_buffer[j] = read(io, UInt8)
    end
    sector = @view sector_buffer[1:size]
    !isnothing(key) && decrypt_block!(reinterpret(UInt32, sector), key + UInt32(i))
    append!(data, sector)
  end
  data
end

function decompress!(buffer::Vector{UInt8}, bytes::AbstractVector{UInt8}, method::MPQCompressionFlags)
  length(enabled_flags(method)) == 1 || error("Only single-algorithm compression schemes are supported at the moment, got $method.")
  in(MPQ_COMPRESSION_HUFFMANN, method) && (bytes = decompress_huffman!(buffer, bytes))
  in(MPQ_COMPRESSION_ZLIB, method) && (bytes = decompress_zlib!(buffer, bytes))
  in(MPQ_COMPRESSION_PKWARE, method) && (bytes = decompress_pkware!(buffer, bytes))
  in(MPQ_COMPRESSION_BZIP2, method) && (bytes = decompress_bzip2!(buffer, bytes))
  in(MPQ_COMPRESSION_SPARSE, method) && (bytes = decompress_sparse!(buffer, bytes))
  in(MPQ_COMPRESSION_ADPCM_MONO, method) && (bytes = decompress_adpcm_mono!(buffer, bytes))
  in(MPQ_COMPRESSION_ADPCM_STEREO, method) && (bytes = decompress_adpcm_stereo!(buffer, bytes))
  in(MPQ_COMPRESSION_LZMA, method) && (bytes = decompress_lzma!(buffer, bytes))
  buffer
end

function decompress_zlib!(buffer, bytes)
  io = IOBuffer(bytes)
  stream = ZlibDecompressorStream(io)
  read!(stream, buffer)
end

function decompress_bzip2!(buffer, bytes)
  io = IOBuffer(bytes)
  stream = Bzip2DecompressorStream(io)
  read!(stream, buffer)
end
