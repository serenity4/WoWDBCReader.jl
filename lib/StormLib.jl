module StormLib

const SEEK_SET = 0
const SEEK_CUR = 0
const SEEK_END = 0

using Libdl

const libstorm = "/home/serenity4/Documents/programming/wow-local/StormLib/libstorm.so"

include("x86_64-linux-gnu.jl")

function __init__()
  Libdl.dlopen("/home/serenity4/Documents/programming/wow-local/StormLib/libstorm.so")
end

end # module
