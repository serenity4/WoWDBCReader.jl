@bitmask exported = true MPQCompressionFlags::UInt8 begin
  "Huffmann compression (used on WAVE files only)."
  MPQ_COMPRESSION_HUFFMANN = 0x01
  "ZLIB compression."
  MPQ_COMPRESSION_ZLIB = 0x02
  "PKWARE DCL compression."
  MPQ_COMPRESSION_PKWARE = 0x08
  "BZIP2 compression (added in Warcraft III)."
  MPQ_COMPRESSION_BZIP2 = 0x10
  "Sparse compression (added in Starcraft 2)."
  MPQ_COMPRESSION_SPARSE = 0x20
  "IMA ADPCM compression (mono)."
  MPQ_COMPRESSION_ADPCM_MONO = 0x40
  "IMA ADPCM compression (stereo)."
  MPQ_COMPRESSION_ADPCM_STEREO = 0x80
  "LZMA compression. Added in Starcraft 2. This value is NOT a combination of flags."
  MPQ_COMPRESSION_LZMA = 0x12
end

const DEFAULT_COMPRESSION_METHOD = MPQ_COMPRESSION_ZLIB

const DEFAULT_BUFFER_SIZE = 16 * 2^10 # 16 kB

struct MPQDecompressor
  zlib::ZlibDecompressor
  bzip2::Bzip2Decompressor
  buffer_1::TranscodingStreams.Buffer
  buffer_2::TranscodingStreams.Buffer
end

function MPQDecompressor(size = DEFAULT_BUFFER_SIZE)
  buffer_1 = TranscodingStreams.Buffer(size)
  buffer_2 = TranscodingStreams.Buffer(size)
  zlib = ZlibDecompressor()
  bzip2 = Bzip2Decompressor()
  TranscodingStreams.initialize(zlib)
  TranscodingStreams.initialize(bzip2)
  MPQDecompressor(zlib, bzip2, buffer_1, buffer_2)
end

function decompress!(buffer, io::IO, dcmp::MPQDecompressor, codec)
  state = TranscodingStreams.State(dcmp.buffer_1, dcmp.buffer_2)
  stream = TranscodingStreams.TranscodingStream(codec, io, state; initialized = true)
  read!(stream, buffer)
end

decompressor() = get!(MPQDecompressor, task_local_storage(), :WoWDBCReader_MPQDecompressor)::MPQDecompressor

decompress_huffman!(buffer, io, dcmp = decompressor()) = decompress!(buffer, io, dcmp, dcmp.huffman)
decompress_zlib!(buffer, io, dcmp = decompressor()) = decompress!(buffer, io, dcmp, dcmp.zlib)
decompress_pkware!(buffer, io, dcmp = decompressor()) = decompress!(buffer, io, dcmp, dcmp.pkware)
decompress_bzip2!(buffer, io, dcmp = decompressor()) = decompress!(buffer, io, dcmp, dcmp.bzip2)
decompress_sparse!(buffer, io, dcmp = decompressor()) = decompress!(buffer, io, dcmp, dcmp.sparse)
decompress_adpcm_mono!(buffer, io, dcmp = decompressor()) = decompress!(buffer, io, dcmp, dcmp.adpc_mono)
decompress_adpcm_stereo!(buffer, io, dcmp = decompressor()) = decompress!(buffer, io, dcmp, dcmp.adpc_stereo)
decompress_lzma!(buffer, io, dcmp = decompressor()) = decompress!(buffer, io, dcmp, dcmp.lzma)

function decompress!(buffer::Vector{UInt8}, io::IO, method::MPQCompressionFlags)
  length(enabled_flags(method)) == 1 || error("Only single-algorithm compression schemes are supported at the moment, got $method.")
  in(MPQ_COMPRESSION_HUFFMANN, method) && decompress_huffman!(buffer, io)
  in(MPQ_COMPRESSION_ZLIB, method) && decompress_zlib!(buffer, io)
  in(MPQ_COMPRESSION_PKWARE, method) && decompress_pkware!(buffer, io)
  in(MPQ_COMPRESSION_BZIP2, method) && decompress_bzip2!(buffer, io)
  in(MPQ_COMPRESSION_SPARSE, method) && decompress_sparse!(buffer, io)
  in(MPQ_COMPRESSION_ADPCM_MONO, method) && decompress_adpcm_mono!(buffer, io)
  in(MPQ_COMPRESSION_ADPCM_STEREO, method) && decompress_adpcm_stereo!(buffer, io)
  in(MPQ_COMPRESSION_LZMA, method) && decompress_lzma!(buffer, io)
  buffer
end

struct MPQCompressor
  zlib::ZlibCompressor
  bzip2::Bzip2Compressor
  buffer_1::TranscodingStreams.Buffer
  buffer_2::TranscodingStreams.Buffer
end

function MPQCompressor(size = DEFAULT_BUFFER_SIZE)
  buffer_1 = TranscodingStreams.Buffer(size)
  buffer_2 = TranscodingStreams.Buffer(size)
  zlib = ZlibCompressor()
  bzip2 = Bzip2Compressor()
  TranscodingStreams.initialize(zlib)
  TranscodingStreams.initialize(bzip2)
  MPQCompressor(zlib, bzip2, buffer_1, buffer_2)
end

function compress!(buffer, io::IO, cmp::MPQCompressor, codec)
  state = TranscodingStreams.State(cmp.buffer_1, cmp.buffer_2)
  stream = TranscodingStreams.TranscodingStream(codec, io, state; initialized = true)
  for i in eachindex(buffer)
    eof(stream) && return @view buffer[begin:(i - 1)]
    buffer[i] = read(stream, UInt8)
  end
  buffer
end

compressor() = get!(MPQCompressor, task_local_storage(), :WoWDBCReader_MPQCompressor)::MPQCompressor

compress_huffman!(buffer, io, cmp = compressor()) = compress!(buffer, io, cmp, cmp.huffman)
compress_zlib!(buffer, io, cmp = compressor()) = compress!(buffer, io, cmp, cmp.zlib)
compress_pkware!(buffer, io, cmp = compressor()) = compress!(buffer, io, cmp, cmp.pkware)
compress_bzip2!(buffer, io, cmp = compressor()) = compress!(buffer, io, cmp, cmp.bzip2)
compress_sparse!(buffer, io, cmp = compressor()) = compress!(buffer, io, cmp, cmp.sparse)
compress_adpcm_mono!(buffer, io, cmp = compressor()) = compress!(buffer, io, cmp, cmp.adpc_mono)
compress_adpcm_stereo!(buffer, io, cmp = compressor()) = compress!(buffer, io, cmp, cmp.adpc_stereo)
compress_lzma!(buffer, io, cmp = compressor()) = compress!(buffer, io, cmp, cmp.lzma)

function compress!(buffer, io::IO, method::MPQCompressionFlags)
  length(enabled_flags(method)) == 1 || error("Only single-algorithm compression schemes are supported at the moment, got $method.")

  in(MPQ_COMPRESSION_LZMA, method) && (written = compress_lzma!(buffer, io))
  in(MPQ_COMPRESSION_ADPCM_STEREO, method) && (written = compress_adpcm_stereo!(buffer, io))
  in(MPQ_COMPRESSION_ADPCM_MONO, method) && (written = compress_adpcm_mono!(buffer, io))
  in(MPQ_COMPRESSION_SPARSE, method) && (written = compress_sparse!(buffer, io))
  in(MPQ_COMPRESSION_BZIP2, method) && (written = compress_bzip2!(buffer, io))
  in(MPQ_COMPRESSION_PKWARE, method) && (written = compress_pkware!(buffer, io))
  in(MPQ_COMPRESSION_ZLIB, method) && (written = compress_zlib!(buffer, io))
  in(MPQ_COMPRESSION_HUFFMANN, method) && (written = compress_huffman!(buffer, io))
  written
end
