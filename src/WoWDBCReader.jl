module WoWDBCReader

using Accessors
using BinaryParsingTools
using BitMasks
using CodecBzip2: Bzip2Compressor, Bzip2Decompressor
using CodecZlib: ZlibCompressor, ZlibDecompressor
using TranscodingStreams: TranscodingStreams
using Dictionaries

const Optional{T} = Union{T, Nothing}

include("schemas.jl")
include("dbc/read.jl")
include("dbc/write.jl")
include("mpq/locale.jl")
include("mpq/compression.jl")
include("mpq/types.jl")
include("mpq/utilities.jl")
include("mpq/hash.jl")
include("mpq/cryptography.jl")
include("mpq/read.jl")
include("mpq/write.jl")

export read_dbc,
       write_dbc,
       MPQHeader,
       MPQHashTableEntry, MPQHashTable,
       MPQFile,
       MPQArchive,
       find_file,
       listfile

end
