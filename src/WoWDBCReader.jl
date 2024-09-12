module WoWDBCReader

using BinaryParsingTools

const Optional{T} = Union{T, Nothing}

include("schemas.jl")
include("client_database.jl")
include("mpq/types.jl")
include("mpq/hash.jl")
include("mpq/read.jl")
include("mpq/write.jl")

export read_dbc,
       read_mpq,
       MPQHeader,
       MPQArchive

end
