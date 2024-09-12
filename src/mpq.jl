include("../lib/StormLib.jl")

function create_archive(archive_name::AbstractString, max_file_count)
  handle = Ref{StormLib.TMPQArchive}()
  GC.@preserve handle begin
    ptr = Base.unsafe_convert(Ptr{StormLib.TMPQArchive}, handle)
    success = StormLib.SFileCreateArchive(archive_name, StormLib.MPQ_CREATE_ARCHIVE_V2, max_file_count, Ptr{Cvoid}(ptr))
  end
  @show StormLib.GetLastError()
  if success ≠ 0
    err = StormLib.GetLastError()
    error("StormLib: error code $err")
  end
  handle[]
end
