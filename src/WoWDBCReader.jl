module WoWDBCReader

using BinaryParsingTools
using BitMasks
using CodecZlib: ZlibCompressorStream, ZlibDecompressorStream
using CodecBzip2: Bzip2CompressorStream, Bzip2DecompressorStream
using Dictionaries

const Optional{T} = Union{T, Nothing}

include("schemas.jl")
include("dbc/read.jl")
include("dbc/write.jl")
include("mpq/types.jl")
include("mpq/hash.jl")
include("mpq/cryptography.jl")
include("mpq/read.jl")
include("mpq/blocks.jl")
include("mpq/write.jl")
include("mpq/utilities.jl")

export read_dbc,
       write_dbc,
       MPQHeader,
       MPQHashTableEntry, MPQHashTable,
       MPQFile,
       MPQArchive,
       find_file,
       listfile

end
