module WoWDBCReader

using BinaryParsingTools
using BitMasks
using CodecZlib: ZlibCompressorStream, ZlibDecompressorStream
using CodecBzip2: Bzip2CompressorStream, Bzip2DecompressorStream

const Optional{T} = Union{T, Nothing}

include("schemas.jl")
include("client_database.jl")
include("mpq/types.jl")
include("mpq/hash.jl")
include("mpq/cryptography.jl")
include("mpq/read.jl")
include("mpq/blocks.jl")
include("mpq/write.jl")
include("mpq/utilities.jl")

export read_dbc,
       read_mpq,
       MPQHeader,
       MPQHashTableEntry, MPQHashTable,
       MPQArchive,
       find_block,
       find_file,
       listfile

end
