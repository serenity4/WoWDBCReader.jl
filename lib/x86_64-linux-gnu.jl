const LCID = Cuint

const USHORT = Cushort

const BYTE = Cuchar

const LONG = Cint

const DWORD = Cuint

const DWORD_PTR = Culong

const LONG_PTR = Clong

const INT_PTR = Clong

const LONGLONG = Clonglong

const ULONGLONG = Culonglong

const HANDLE = Ptr{Cvoid}

const LPOVERLAPPED = Ptr{Cvoid}

const TCHAR = Cchar

const PLONG = Ptr{LONG}

const LPDWORD = Ptr{DWORD}

const LPBYTE = Ptr{BYTE}

const LPCTSTR = Ptr{Cchar}

const LPCSTR = Ptr{Cchar}

const LPTSTR = Ptr{Cchar}

const LPSTR = Ptr{Cchar}

# typedef DWORD ( * HASH_STRING ) ( const char * szFileName , DWORD dwHashType )
const HASH_STRING = Ptr{Cvoid}

@enum _SFileInfoClass::UInt32 begin
    SFileMpqFileName = 0
    SFileMpqStreamBitmap = 1
    SFileMpqUserDataOffset = 2
    SFileMpqUserDataHeader = 3
    SFileMpqUserData = 4
    SFileMpqHeaderOffset = 5
    SFileMpqHeaderSize = 6
    SFileMpqHeader = 7
    SFileMpqHetTableOffset = 8
    SFileMpqHetTableSize = 9
    SFileMpqHetHeader = 10
    SFileMpqHetTable = 11
    SFileMpqBetTableOffset = 12
    SFileMpqBetTableSize = 13
    SFileMpqBetHeader = 14
    SFileMpqBetTable = 15
    SFileMpqHashTableOffset = 16
    SFileMpqHashTableSize64 = 17
    SFileMpqHashTableSize = 18
    SFileMpqHashTable = 19
    SFileMpqBlockTableOffset = 20
    SFileMpqBlockTableSize64 = 21
    SFileMpqBlockTableSize = 22
    SFileMpqBlockTable = 23
    SFileMpqHiBlockTableOffset = 24
    SFileMpqHiBlockTableSize64 = 25
    SFileMpqHiBlockTable = 26
    SFileMpqSignatures = 27
    SFileMpqStrongSignatureOffset = 28
    SFileMpqStrongSignatureSize = 29
    SFileMpqStrongSignature = 30
    SFileMpqArchiveSize64 = 31
    SFileMpqArchiveSize = 32
    SFileMpqMaxFileCount = 33
    SFileMpqFileTableSize = 34
    SFileMpqSectorSize = 35
    SFileMpqNumberOfFiles = 36
    SFileMpqRawChunkSize = 37
    SFileMpqStreamFlags = 38
    SFileMpqFlags = 39
    SFileInfoPatchChain = 40
    SFileInfoFileEntry = 41
    SFileInfoHashEntry = 42
    SFileInfoHashIndex = 43
    SFileInfoNameHash1 = 44
    SFileInfoNameHash2 = 45
    SFileInfoNameHash3 = 46
    SFileInfoLocale = 47
    SFileInfoFileIndex = 48
    SFileInfoByteOffset = 49
    SFileInfoFileTime = 50
    SFileInfoFileSize = 51
    SFileInfoCompressedSize = 52
    SFileInfoFlags = 53
    SFileInfoEncryptionKey = 54
    SFileInfoEncryptionKeyRaw = 55
    SFileInfoCRC32 = 56
    SFileInfoInvalid = 4095
end

const SFileInfoClass = _SFileInfoClass

# typedef void ( WINAPI * SFILE_DOWNLOAD_CALLBACK ) ( void * pvUserData , ULONGLONG ByteOffset , DWORD dwTotalBytes )
const SFILE_DOWNLOAD_CALLBACK = Ptr{Cvoid}

# typedef void ( WINAPI * SFILE_ADDFILE_CALLBACK ) ( void * pvUserData , DWORD dwBytesWritten , DWORD dwTotalBytes , bool bFinalCall )
const SFILE_ADDFILE_CALLBACK = Ptr{Cvoid}

# typedef void ( WINAPI * SFILE_COMPACT_CALLBACK ) ( void * pvUserData , DWORD dwWorkType , ULONGLONG BytesProcessed , ULONGLONG TotalBytes )
const SFILE_COMPACT_CALLBACK = Ptr{Cvoid}

const TFileStream = Cvoid

const TMPQBits = Cvoid

struct _TMPQUserData
    dwID::DWORD
    cbUserDataSize::DWORD
    dwHeaderOffs::DWORD
    cbUserDataHeader::DWORD
end

const TMPQUserData = _TMPQUserData

struct _TMPQHeader
    data::NTuple{208, UInt8}
end

function Base.getproperty(x::Ptr{_TMPQHeader}, f::Symbol)
    f === :dwID && return Ptr{DWORD}(x + 0)
    f === :dwHeaderSize && return Ptr{DWORD}(x + 4)
    f === :dwArchiveSize && return Ptr{DWORD}(x + 8)
    f === :wFormatVersion && return Ptr{USHORT}(x + 12)
    f === :wSectorSize && return Ptr{USHORT}(x + 14)
    f === :dwHashTablePos && return Ptr{DWORD}(x + 16)
    f === :dwBlockTablePos && return Ptr{DWORD}(x + 20)
    f === :dwHashTableSize && return Ptr{DWORD}(x + 24)
    f === :dwBlockTableSize && return Ptr{DWORD}(x + 28)
    f === :HiBlockTablePos64 && return Ptr{ULONGLONG}(x + 32)
    f === :wHashTablePosHi && return Ptr{USHORT}(x + 40)
    f === :wBlockTablePosHi && return Ptr{USHORT}(x + 42)
    f === :ArchiveSize64 && return Ptr{ULONGLONG}(x + 44)
    f === :BetTablePos64 && return Ptr{ULONGLONG}(x + 52)
    f === :HetTablePos64 && return Ptr{ULONGLONG}(x + 60)
    f === :HashTableSize64 && return Ptr{ULONGLONG}(x + 68)
    f === :BlockTableSize64 && return Ptr{ULONGLONG}(x + 76)
    f === :HiBlockTableSize64 && return Ptr{ULONGLONG}(x + 84)
    f === :HetTableSize64 && return Ptr{ULONGLONG}(x + 92)
    f === :BetTableSize64 && return Ptr{ULONGLONG}(x + 100)
    f === :dwRawChunkSize && return Ptr{DWORD}(x + 108)
    f === :MD5_BlockTable && return Ptr{NTuple{16, Cuchar}}(x + 112)
    f === :MD5_HashTable && return Ptr{NTuple{16, Cuchar}}(x + 128)
    f === :MD5_HiBlockTable && return Ptr{NTuple{16, Cuchar}}(x + 144)
    f === :MD5_BetTable && return Ptr{NTuple{16, Cuchar}}(x + 160)
    f === :MD5_HetTable && return Ptr{NTuple{16, Cuchar}}(x + 176)
    f === :MD5_MpqHeader && return Ptr{NTuple{16, Cuchar}}(x + 192)
    return getfield(x, f)
end

function Base.getproperty(x::_TMPQHeader, f::Symbol)
    r = Ref{_TMPQHeader}(x)
    ptr = Base.unsafe_convert(Ptr{_TMPQHeader}, r)
    fptr = getproperty(ptr, f)
    GC.@preserve r unsafe_load(fptr)
end

function Base.setproperty!(x::Ptr{_TMPQHeader}, f::Symbol, v)
    unsafe_store!(getproperty(x, f), v)
end

function _TMPQHeader(dwID::DWORD, dwHeaderSize::DWORD, dwArchiveSize::DWORD, wFormatVersion::USHORT, wSectorSize::USHORT, dwHashTablePos::DWORD, dwBlockTablePos::DWORD, dwHashTableSize::DWORD, dwBlockTableSize::DWORD, HiBlockTablePos64::ULONGLONG, wHashTablePosHi::USHORT, wBlockTablePosHi::USHORT, ArchiveSize64::ULONGLONG, BetTablePos64::ULONGLONG, HetTablePos64::ULONGLONG, HashTableSize64::ULONGLONG, BlockTableSize64::ULONGLONG, HiBlockTableSize64::ULONGLONG, HetTableSize64::ULONGLONG, BetTableSize64::ULONGLONG, dwRawChunkSize::DWORD, MD5_BlockTable::NTuple{16, Cuchar}, MD5_HashTable::NTuple{16, Cuchar}, MD5_HiBlockTable::NTuple{16, Cuchar}, MD5_BetTable::NTuple{16, Cuchar}, MD5_HetTable::NTuple{16, Cuchar}, MD5_MpqHeader::NTuple{16, Cuchar})
    ref = Ref{_TMPQHeader}()
    ptr = Base.unsafe_convert(Ptr{_TMPQHeader}, ref)
    ptr.dwID = dwID
    ptr.dwHeaderSize = dwHeaderSize
    ptr.dwArchiveSize = dwArchiveSize
    ptr.wFormatVersion = wFormatVersion
    ptr.wSectorSize = wSectorSize
    ptr.dwHashTablePos = dwHashTablePos
    ptr.dwBlockTablePos = dwBlockTablePos
    ptr.dwHashTableSize = dwHashTableSize
    ptr.dwBlockTableSize = dwBlockTableSize
    ptr.HiBlockTablePos64 = HiBlockTablePos64
    ptr.wHashTablePosHi = wHashTablePosHi
    ptr.wBlockTablePosHi = wBlockTablePosHi
    ptr.ArchiveSize64 = ArchiveSize64
    ptr.BetTablePos64 = BetTablePos64
    ptr.HetTablePos64 = HetTablePos64
    ptr.HashTableSize64 = HashTableSize64
    ptr.BlockTableSize64 = BlockTableSize64
    ptr.HiBlockTableSize64 = HiBlockTableSize64
    ptr.HetTableSize64 = HetTableSize64
    ptr.BetTableSize64 = BetTableSize64
    ptr.dwRawChunkSize = dwRawChunkSize
    ptr.MD5_BlockTable = MD5_BlockTable
    ptr.MD5_HashTable = MD5_HashTable
    ptr.MD5_HiBlockTable = MD5_HiBlockTable
    ptr.MD5_BetTable = MD5_BetTable
    ptr.MD5_HetTable = MD5_HetTable
    ptr.MD5_MpqHeader = MD5_MpqHeader
    ref[]
end

const TMPQHeader = _TMPQHeader

struct _TMPQHash
    dwName1::DWORD
    dwName2::DWORD
    Locale::USHORT
    Platform::BYTE
    Reserved::BYTE
    dwBlockIndex::DWORD
end

const TMPQHash = _TMPQHash

struct _TMPQBlock
    dwFilePos::DWORD
    dwCSize::DWORD
    dwFSize::DWORD
    dwFlags::DWORD
end

const TMPQBlock = _TMPQBlock

struct _TPatchInfo
    dwLength::DWORD
    dwFlags::DWORD
    dwDataSize::DWORD
    md5::NTuple{16, BYTE}
end

const TPatchInfo = _TPatchInfo

struct _TFileEntry
    FileNameHash::ULONGLONG
    ByteOffset::ULONGLONG
    FileTime::ULONGLONG
    dwFileSize::DWORD
    dwCmpSize::DWORD
    dwFlags::DWORD
    dwCrc32::DWORD
    md5::NTuple{16, BYTE}
    szFileName::Ptr{Cchar}
end

const TFileEntry = _TFileEntry

struct _TMPQExtHeader
    dwSignature::DWORD
    dwVersion::DWORD
    dwDataSize::DWORD
end

const TMPQExtHeader = _TMPQExtHeader

struct _TMPQHetHeader
    ExtHdr::TMPQExtHeader
    dwTableSize::DWORD
    dwEntryCount::DWORD
    dwTotalCount::DWORD
    dwNameHashBitSize::DWORD
    dwIndexSizeTotal::DWORD
    dwIndexSizeExtra::DWORD
    dwIndexSize::DWORD
    dwIndexTableSize::DWORD
end

const TMPQHetHeader = _TMPQHetHeader

struct _TMPQBetHeader
    ExtHdr::TMPQExtHeader
    dwTableSize::DWORD
    dwEntryCount::DWORD
    dwUnknown08::DWORD
    dwTableEntrySize::DWORD
    dwBitIndex_FilePos::DWORD
    dwBitIndex_FileSize::DWORD
    dwBitIndex_CmpSize::DWORD
    dwBitIndex_FlagIndex::DWORD
    dwBitIndex_Unknown::DWORD
    dwBitCount_FilePos::DWORD
    dwBitCount_FileSize::DWORD
    dwBitCount_CmpSize::DWORD
    dwBitCount_FlagIndex::DWORD
    dwBitCount_Unknown::DWORD
    dwBitTotal_NameHash2::DWORD
    dwBitExtra_NameHash2::DWORD
    dwBitCount_NameHash2::DWORD
    dwNameHashArraySize::DWORD
    dwFlagCount::DWORD
end

const TMPQBetHeader = _TMPQBetHeader

struct _TMPQHetTable
    pBetIndexes::Ptr{TMPQBits}
    pNameHashes::LPBYTE
    AndMask64::ULONGLONG
    OrMask64::ULONGLONG
    dwEntryCount::DWORD
    dwTotalCount::DWORD
    dwNameHashBitSize::DWORD
    dwIndexSizeTotal::DWORD
    dwIndexSizeExtra::DWORD
    dwIndexSize::DWORD
end

const TMPQHetTable = _TMPQHetTable

struct _TMPQBetTable
    pNameHashes::Ptr{TMPQBits}
    pFileTable::Ptr{TMPQBits}
    pFileFlags::LPDWORD
    dwTableEntrySize::DWORD
    dwBitIndex_FilePos::DWORD
    dwBitIndex_FileSize::DWORD
    dwBitIndex_CmpSize::DWORD
    dwBitIndex_FlagIndex::DWORD
    dwBitIndex_Unknown::DWORD
    dwBitCount_FilePos::DWORD
    dwBitCount_FileSize::DWORD
    dwBitCount_CmpSize::DWORD
    dwBitCount_FlagIndex::DWORD
    dwBitCount_Unknown::DWORD
    dwBitTotal_NameHash2::DWORD
    dwBitExtra_NameHash2::DWORD
    dwBitCount_NameHash2::DWORD
    dwEntryCount::DWORD
    dwFlagCount::DWORD
end

const TMPQBetTable = _TMPQBetTable

struct _TMPQNamePrefix
    nLength::Csize_t
    szPatchPrefix::NTuple{1, Cchar}
end

const TMPQNamePrefix = _TMPQNamePrefix

struct _TMPQNameCache
    FirstNameOffset::DWORD
    FreeSpaceOffset::DWORD
    TotalCacheSize::DWORD
    SearchOffset::DWORD
end

const TMPQNameCache = _TMPQNameCache

struct _TMPQArchive
    pStream::Ptr{TFileStream}
    UserDataPos::ULONGLONG
    MpqPos::ULONGLONG
    FileSize::ULONGLONG
    FileOffsetMask::ULONGLONG
    haPatch::Ptr{_TMPQArchive}
    haBase::Ptr{_TMPQArchive}
    pPatchPrefix::Ptr{TMPQNamePrefix}
    pUserData::Ptr{TMPQUserData}
    pHeader::Ptr{TMPQHeader}
    pHashTable::Ptr{TMPQHash}
    pHetTable::Ptr{TMPQHetTable}
    pFileTable::Ptr{TFileEntry}
    pfnHashString::HASH_STRING
    UserData::TMPQUserData
    HeaderData::NTuple{52, DWORD}
    dwHETBlockSize::DWORD
    dwBETBlockSize::DWORD
    dwMaxFileCount::DWORD
    dwFileTableSize::DWORD
    dwReservedFiles::DWORD
    dwSectorSize::DWORD
    dwFileFlags1::DWORD
    dwFileFlags2::DWORD
    dwFileFlags3::DWORD
    dwAttrFlags::DWORD
    dwValidFileFlags::DWORD
    dwRealHashTableSize::DWORD
    dwFlags::DWORD
    dwSubType::DWORD
    pfnAddFileCB::SFILE_ADDFILE_CALLBACK
    pvAddFileUserData::Ptr{Cvoid}
    pfnCompactCB::SFILE_COMPACT_CALLBACK
    CompactBytesProcessed::ULONGLONG
    CompactTotalBytes::ULONGLONG
    pvCompactUserData::Ptr{Cvoid}
end

const TMPQArchive = _TMPQArchive

struct _TMPQFile
    pStream::Ptr{TFileStream}
    ha::Ptr{TMPQArchive}
    pHashEntry::Ptr{TMPQHash}
    pFileEntry::Ptr{TFileEntry}
    RawFilePos::ULONGLONG
    MpqFilePos::ULONGLONG
    dwHashIndex::DWORD
    dwFileKey::DWORD
    dwFilePos::DWORD
    dwMagic::DWORD
    hfPatch::Ptr{_TMPQFile}
    pPatchInfo::Ptr{TPatchInfo}
    SectorOffsets::LPDWORD
    SectorChksums::LPDWORD
    pbFileData::LPBYTE
    cbFileData::DWORD
    dwCompression0::DWORD
    dwSectorCount::DWORD
    dwPatchedFileSize::DWORD
    dwDataSize::DWORD
    pbFileSector::LPBYTE
    dwSectorOffs::DWORD
    dwSectorSize::DWORD
    hctx::Ptr{Cvoid}
    dwCrc32::DWORD
    dwAddFileError::DWORD
    bLoadedSectorCRCs::Cchar
    bCheckSectorCRCs::Cchar
    bIsWriteHandle::Cchar
end

const TMPQFile = _TMPQFile

struct _SFILE_FIND_DATA
    cFileName::NTuple{1024, Cchar}
    szPlainName::Ptr{Cchar}
    dwHashIndex::DWORD
    dwBlockIndex::DWORD
    dwFileSize::DWORD
    dwFileFlags::DWORD
    dwCompSize::DWORD
    dwFileTimeLo::DWORD
    dwFileTimeHi::DWORD
    lcLocale::LCID
end

const SFILE_FIND_DATA = _SFILE_FIND_DATA

const PSFILE_FIND_DATA = Ptr{_SFILE_FIND_DATA}

struct _SFILE_CREATE_MPQ
    cbSize::DWORD
    dwMpqVersion::DWORD
    pvUserData::Ptr{Cvoid}
    cbUserData::DWORD
    dwStreamFlags::DWORD
    dwFileFlags1::DWORD
    dwFileFlags2::DWORD
    dwFileFlags3::DWORD
    dwAttrFlags::DWORD
    dwSectorSize::DWORD
    dwRawChunkSize::DWORD
    dwMaxFileCount::DWORD
end

const SFILE_CREATE_MPQ = _SFILE_CREATE_MPQ

const PSFILE_CREATE_MPQ = Ptr{_SFILE_CREATE_MPQ}

struct _SFILE_MARKERS
    dwSize::DWORD
    dwSignature::DWORD
    szHashTableKey::Ptr{Cchar}
    szBlockTableKey::Ptr{Cchar}
end

const SFILE_MARKERS = _SFILE_MARKERS

const PSFILE_MARKERS = Ptr{_SFILE_MARKERS}

function GetMPQBits(pBits, nBitPosition, nBitLength, pvBuffer, nResultByteSize)
    @ccall libstorm.GetMPQBits(pBits::Ptr{TMPQBits}, nBitPosition::Cuint, nBitLength::Cuint, pvBuffer::Ptr{Cvoid}, nResultByteSize::Cint)::Cvoid
end

struct TStreamBitmap
    StreamSize::ULONGLONG
    BitmapSize::DWORD
    BlockCount::DWORD
    BlockSize::DWORD
    IsComplete::DWORD
end

function FileStream_CreateFile(szFileName, dwStreamFlags)
    @ccall libstorm.FileStream_CreateFile(szFileName::Ptr{TCHAR}, dwStreamFlags::DWORD)::Ptr{TFileStream}
end

function FileStream_OpenFile(szFileName, dwStreamFlags)
    @ccall libstorm.FileStream_OpenFile(szFileName::Ptr{TCHAR}, dwStreamFlags::DWORD)::Ptr{TFileStream}
end

function FileStream_GetFileName(pStream)
    @ccall libstorm.FileStream_GetFileName(pStream::Ptr{TFileStream})::Ptr{TCHAR}
end

function FileStream_Prefix(szFileName, pdwProvider)
    @ccall libstorm.FileStream_Prefix(szFileName::Ptr{TCHAR}, pdwProvider::Ptr{DWORD})::Csize_t
end

function FileStream_SetCallback(pStream, pfnCallback, pvUserData)
    @ccall libstorm.FileStream_SetCallback(pStream::Ptr{TFileStream}, pfnCallback::SFILE_DOWNLOAD_CALLBACK, pvUserData::Ptr{Cvoid})::Cchar
end

function FileStream_GetBitmap(pStream, pvBitmap, cbBitmap, pcbLengthNeeded)
    @ccall libstorm.FileStream_GetBitmap(pStream::Ptr{TFileStream}, pvBitmap::Ptr{Cvoid}, cbBitmap::DWORD, pcbLengthNeeded::Ptr{DWORD})::Cchar
end

function FileStream_Read(pStream, pByteOffset, pvBuffer, dwBytesToRead)
    @ccall libstorm.FileStream_Read(pStream::Ptr{TFileStream}, pByteOffset::Ptr{ULONGLONG}, pvBuffer::Ptr{Cvoid}, dwBytesToRead::DWORD)::Cchar
end

function FileStream_Write(pStream, pByteOffset, pvBuffer, dwBytesToWrite)
    @ccall libstorm.FileStream_Write(pStream::Ptr{TFileStream}, pByteOffset::Ptr{ULONGLONG}, pvBuffer::Ptr{Cvoid}, dwBytesToWrite::DWORD)::Cchar
end

function FileStream_SetSize(pStream, NewFileSize)
    @ccall libstorm.FileStream_SetSize(pStream::Ptr{TFileStream}, NewFileSize::ULONGLONG)::Cchar
end

function FileStream_GetSize(pStream, pFileSize)
    @ccall libstorm.FileStream_GetSize(pStream::Ptr{TFileStream}, pFileSize::Ptr{ULONGLONG})::Cchar
end

function FileStream_GetPos(pStream, pByteOffset)
    @ccall libstorm.FileStream_GetPos(pStream::Ptr{TFileStream}, pByteOffset::Ptr{ULONGLONG})::Cchar
end

function FileStream_GetTime(pStream, pFT)
    @ccall libstorm.FileStream_GetTime(pStream::Ptr{TFileStream}, pFT::Ptr{ULONGLONG})::Cchar
end

function FileStream_GetFlags(pStream, pdwStreamFlags)
    @ccall libstorm.FileStream_GetFlags(pStream::Ptr{TFileStream}, pdwStreamFlags::LPDWORD)::Cchar
end

function FileStream_Replace(pStream, pNewStream)
    @ccall libstorm.FileStream_Replace(pStream::Ptr{TFileStream}, pNewStream::Ptr{TFileStream})::Cchar
end

function FileStream_Close(pStream)
    @ccall libstorm.FileStream_Close(pStream::Ptr{TFileStream})::Cvoid
end

# typedef LCID ( WINAPI * SFILESETLOCALE ) ( LCID )
const SFILESETLOCALE = Ptr{Cvoid}

# typedef bool ( WINAPI * SFILEOPENARCHIVE ) ( const char * , DWORD , DWORD , HANDLE * )
const SFILEOPENARCHIVE = Ptr{Cvoid}

# typedef bool ( WINAPI * SFILECLOSEARCHIVE ) ( HANDLE )
const SFILECLOSEARCHIVE = Ptr{Cvoid}

# typedef bool ( WINAPI * SFILEOPENFILEEX ) ( HANDLE , const char * , DWORD , HANDLE * )
const SFILEOPENFILEEX = Ptr{Cvoid}

# typedef bool ( WINAPI * SFILECLOSEFILE ) ( HANDLE )
const SFILECLOSEFILE = Ptr{Cvoid}

# typedef DWORD ( WINAPI * SFILEGETFILESIZE ) ( HANDLE , LPDWORD )
const SFILEGETFILESIZE = Ptr{Cvoid}

# typedef DWORD ( WINAPI * SFILESETFILEPOINTER ) ( HANDLE , LONG , LONG * , DWORD )
const SFILESETFILEPOINTER = Ptr{Cvoid}

# typedef bool ( WINAPI * SFILEREADFILE ) ( HANDLE , void * , DWORD , LPDWORD , LPOVERLAPPED )
const SFILEREADFILE = Ptr{Cvoid}

function SFileSetArchiveMarkers(pMarkers)
    @ccall libstorm.SFileSetArchiveMarkers(pMarkers::PSFILE_MARKERS)::Cchar
end

# no prototype is found for this function at StormLib.h:1019:15, please use with caution
function SFileGetLocale()
    @ccall libstorm.SFileGetLocale()::LCID
end

function SFileSetLocale(lcFileLocale)
    @ccall libstorm.SFileSetLocale(lcFileLocale::LCID)::LCID
end

function SFileOpenArchive(szMpqName, dwPriority, dwFlags, phMpq)
    @ccall libstorm.SFileOpenArchive(szMpqName::Ptr{TCHAR}, dwPriority::DWORD, dwFlags::DWORD, phMpq::Ptr{HANDLE})::Cchar
end

function SFileCreateArchive(szMpqName, dwCreateFlags, dwMaxFileCount, phMpq)
    @ccall libstorm.SFileCreateArchive(szMpqName::Ptr{TCHAR}, dwCreateFlags::DWORD, dwMaxFileCount::DWORD, phMpq::Ptr{HANDLE})::Cchar
end

function SFileCreateArchive2(szMpqName, pCreateInfo, phMpq)
    @ccall libstorm.SFileCreateArchive2(szMpqName::Ptr{TCHAR}, pCreateInfo::PSFILE_CREATE_MPQ, phMpq::Ptr{HANDLE})::Cchar
end

function SFileSetDownloadCallback(hMpq, DownloadCB, pvUserData)
    @ccall libstorm.SFileSetDownloadCallback(hMpq::HANDLE, DownloadCB::SFILE_DOWNLOAD_CALLBACK, pvUserData::Ptr{Cvoid})::Cchar
end

function SFileFlushArchive(hMpq)
    @ccall libstorm.SFileFlushArchive(hMpq::HANDLE)::Cchar
end

function SFileCloseArchive(hMpq)
    @ccall libstorm.SFileCloseArchive(hMpq::HANDLE)::Cchar
end

function SFileAddListFile(hMpq, szListFile)
    @ccall libstorm.SFileAddListFile(hMpq::HANDLE, szListFile::Ptr{TCHAR})::DWORD
end

function SFileAddListFileEntries(hMpq, listFileEntries, dwEntryCount)
    @ccall libstorm.SFileAddListFileEntries(hMpq::HANDLE, listFileEntries::Ptr{Ptr{Cchar}}, dwEntryCount::DWORD)::DWORD
end

function SFileSetCompactCallback(hMpq, CompactCB, pvUserData)
    @ccall libstorm.SFileSetCompactCallback(hMpq::HANDLE, CompactCB::SFILE_COMPACT_CALLBACK, pvUserData::Ptr{Cvoid})::Cchar
end

function SFileCompactArchive(hMpq, szListFile, bReserved)
    @ccall libstorm.SFileCompactArchive(hMpq::HANDLE, szListFile::Ptr{TCHAR}, bReserved::Cchar)::Cchar
end

function SFileGetMaxFileCount(hMpq)
    @ccall libstorm.SFileGetMaxFileCount(hMpq::HANDLE)::DWORD
end

function SFileSetMaxFileCount(hMpq, dwMaxFileCount)
    @ccall libstorm.SFileSetMaxFileCount(hMpq::HANDLE, dwMaxFileCount::DWORD)::Cchar
end

function SFileGetAttributes(hMpq)
    @ccall libstorm.SFileGetAttributes(hMpq::HANDLE)::DWORD
end

function SFileSetAttributes(hMpq, dwFlags)
    @ccall libstorm.SFileSetAttributes(hMpq::HANDLE, dwFlags::DWORD)::Cchar
end

function SFileUpdateFileAttributes(hMpq, szFileName)
    @ccall libstorm.SFileUpdateFileAttributes(hMpq::HANDLE, szFileName::Ptr{Cchar})::Cchar
end

function SFileOpenPatchArchive(hMpq, szPatchMpqName, szPatchPathPrefix, dwFlags)
    @ccall libstorm.SFileOpenPatchArchive(hMpq::HANDLE, szPatchMpqName::Ptr{TCHAR}, szPatchPathPrefix::Ptr{Cchar}, dwFlags::DWORD)::Cchar
end

function SFileIsPatchedArchive(hMpq)
    @ccall libstorm.SFileIsPatchedArchive(hMpq::HANDLE)::Cchar
end

function SFileHasFile(hMpq, szFileName)
    @ccall libstorm.SFileHasFile(hMpq::HANDLE, szFileName::Ptr{Cchar})::Cchar
end

function SFileOpenFileEx(hMpq, szFileName, dwSearchScope, phFile)
    @ccall libstorm.SFileOpenFileEx(hMpq::HANDLE, szFileName::Ptr{Cchar}, dwSearchScope::DWORD, phFile::Ptr{HANDLE})::Cchar
end

function SFileGetFileSize(hFile, pdwFileSizeHigh)
    @ccall libstorm.SFileGetFileSize(hFile::HANDLE, pdwFileSizeHigh::LPDWORD)::DWORD
end

function SFileSetFilePointer(hFile, lFilePos, plFilePosHigh, dwMoveMethod)
    @ccall libstorm.SFileSetFilePointer(hFile::HANDLE, lFilePos::LONG, plFilePosHigh::Ptr{LONG}, dwMoveMethod::DWORD)::DWORD
end

function SFileReadFile(hFile, lpBuffer, dwToRead, pdwRead, lpOverlapped)
    @ccall libstorm.SFileReadFile(hFile::HANDLE, lpBuffer::Ptr{Cvoid}, dwToRead::DWORD, pdwRead::LPDWORD, lpOverlapped::LPOVERLAPPED)::Cchar
end

function SFileCloseFile(hFile)
    @ccall libstorm.SFileCloseFile(hFile::HANDLE)::Cchar
end

function SFileGetFileInfo(hMpqOrFile, InfoClass, pvFileInfo, cbFileInfo, pcbLengthNeeded)
    @ccall libstorm.SFileGetFileInfo(hMpqOrFile::HANDLE, InfoClass::SFileInfoClass, pvFileInfo::Ptr{Cvoid}, cbFileInfo::DWORD, pcbLengthNeeded::LPDWORD)::Cchar
end

function SFileGetFileName(hFile, szFileName)
    @ccall libstorm.SFileGetFileName(hFile::HANDLE, szFileName::Ptr{Cchar})::Cchar
end

function SFileFreeFileInfo(pvFileInfo, InfoClass)
    @ccall libstorm.SFileFreeFileInfo(pvFileInfo::Ptr{Cvoid}, InfoClass::SFileInfoClass)::Cchar
end

function SFileExtractFile(hMpq, szToExtract, szExtracted, dwSearchScope)
    @ccall libstorm.SFileExtractFile(hMpq::HANDLE, szToExtract::Ptr{Cchar}, szExtracted::Ptr{TCHAR}, dwSearchScope::DWORD)::Cchar
end

function SFileGetFileChecksums(hMpq, szFileName, pdwCrc32, pMD5)
    @ccall libstorm.SFileGetFileChecksums(hMpq::HANDLE, szFileName::Ptr{Cchar}, pdwCrc32::LPDWORD, pMD5::Ptr{Cchar})::Cchar
end

function SFileVerifyFile(hMpq, szFileName, dwFlags)
    @ccall libstorm.SFileVerifyFile(hMpq::HANDLE, szFileName::Ptr{Cchar}, dwFlags::DWORD)::DWORD
end

function SFileVerifyRawData(hMpq, dwWhatToVerify, szFileName)
    @ccall libstorm.SFileVerifyRawData(hMpq::HANDLE, dwWhatToVerify::DWORD, szFileName::Ptr{Cchar})::DWORD
end

function SFileSignArchive(hMpq, dwSignatureType)
    @ccall libstorm.SFileSignArchive(hMpq::HANDLE, dwSignatureType::DWORD)::Cchar
end

function SFileVerifyArchive(hMpq)
    @ccall libstorm.SFileVerifyArchive(hMpq::HANDLE)::DWORD
end

function SFileFindFirstFile(hMpq, szMask, lpFindFileData, szListFile)
    @ccall libstorm.SFileFindFirstFile(hMpq::HANDLE, szMask::Ptr{Cchar}, lpFindFileData::Ptr{SFILE_FIND_DATA}, szListFile::Ptr{TCHAR})::HANDLE
end

function SFileFindNextFile(hFind, lpFindFileData)
    @ccall libstorm.SFileFindNextFile(hFind::HANDLE, lpFindFileData::Ptr{SFILE_FIND_DATA})::Cchar
end

function SFileFindClose(hFind)
    @ccall libstorm.SFileFindClose(hFind::HANDLE)::Cchar
end

function SListFileFindFirstFile(hMpq, szListFile, szMask, lpFindFileData)
    @ccall libstorm.SListFileFindFirstFile(hMpq::HANDLE, szListFile::Ptr{TCHAR}, szMask::Ptr{Cchar}, lpFindFileData::Ptr{SFILE_FIND_DATA})::HANDLE
end

function SListFileFindNextFile(hFind, lpFindFileData)
    @ccall libstorm.SListFileFindNextFile(hFind::HANDLE, lpFindFileData::Ptr{SFILE_FIND_DATA})::Cchar
end

function SListFileFindClose(hFind)
    @ccall libstorm.SListFileFindClose(hFind::HANDLE)::Cchar
end

function SFileEnumLocales(hMpq, szFileName, PtrFileLocales, PtrMaxLocales, dwSearchScope)
    @ccall libstorm.SFileEnumLocales(hMpq::HANDLE, szFileName::Ptr{Cchar}, PtrFileLocales::Ptr{LCID}, PtrMaxLocales::LPDWORD, dwSearchScope::DWORD)::DWORD
end

function SFileCreateFile(hMpq, szArchivedName, FileTime, dwFileSize, lcFileLocale, dwFlags, phFile)
    @ccall libstorm.SFileCreateFile(hMpq::HANDLE, szArchivedName::Ptr{Cchar}, FileTime::ULONGLONG, dwFileSize::DWORD, lcFileLocale::LCID, dwFlags::DWORD, phFile::Ptr{HANDLE})::Cchar
end

function SFileWriteFile(hFile, pvData, dwSize, dwCompression)
    @ccall libstorm.SFileWriteFile(hFile::HANDLE, pvData::Ptr{Cvoid}, dwSize::DWORD, dwCompression::DWORD)::Cchar
end

function SFileFinishFile(hFile)
    @ccall libstorm.SFileFinishFile(hFile::HANDLE)::Cchar
end

function SFileAddFileEx(hMpq, szFileName, szArchivedName, dwFlags, dwCompression, dwCompressionNext)
    @ccall libstorm.SFileAddFileEx(hMpq::HANDLE, szFileName::Ptr{TCHAR}, szArchivedName::Ptr{Cchar}, dwFlags::DWORD, dwCompression::DWORD, dwCompressionNext::DWORD)::Cchar
end

function SFileAddFile(hMpq, szFileName, szArchivedName, dwFlags)
    @ccall libstorm.SFileAddFile(hMpq::HANDLE, szFileName::Ptr{TCHAR}, szArchivedName::Ptr{Cchar}, dwFlags::DWORD)::Cchar
end

function SFileAddWave(hMpq, szFileName, szArchivedName, dwFlags, dwQuality)
    @ccall libstorm.SFileAddWave(hMpq::HANDLE, szFileName::Ptr{TCHAR}, szArchivedName::Ptr{Cchar}, dwFlags::DWORD, dwQuality::DWORD)::Cchar
end

function SFileRemoveFile(hMpq, szFileName, dwSearchScope)
    @ccall libstorm.SFileRemoveFile(hMpq::HANDLE, szFileName::Ptr{Cchar}, dwSearchScope::DWORD)::Cchar
end

function SFileRenameFile(hMpq, szOldFileName, szNewFileName)
    @ccall libstorm.SFileRenameFile(hMpq::HANDLE, szOldFileName::Ptr{Cchar}, szNewFileName::Ptr{Cchar})::Cchar
end

function SFileSetFileLocale(hFile, lcNewLocale)
    @ccall libstorm.SFileSetFileLocale(hFile::HANDLE, lcNewLocale::LCID)::Cchar
end

function SFileSetDataCompression(DataCompression)
    @ccall libstorm.SFileSetDataCompression(DataCompression::DWORD)::Cchar
end

function SFileSetAddFileCallback(hMpq, AddFileCB, pvUserData)
    @ccall libstorm.SFileSetAddFileCallback(hMpq::HANDLE, AddFileCB::SFILE_ADDFILE_CALLBACK, pvUserData::Ptr{Cvoid})::Cchar
end

function SCompImplode(pvOutBuffer, pcbOutBuffer, pvInBuffer, cbInBuffer)
    @ccall libstorm.SCompImplode(pvOutBuffer::Ptr{Cvoid}, pcbOutBuffer::Ptr{Cint}, pvInBuffer::Ptr{Cvoid}, cbInBuffer::Cint)::Cint
end

function SCompExplode(pvOutBuffer, pcbOutBuffer, pvInBuffer, cbInBuffer)
    @ccall libstorm.SCompExplode(pvOutBuffer::Ptr{Cvoid}, pcbOutBuffer::Ptr{Cint}, pvInBuffer::Ptr{Cvoid}, cbInBuffer::Cint)::Cint
end

function SCompCompress(pvOutBuffer, pcbOutBuffer, pvInBuffer, cbInBuffer, uCompressionMask, nCmpType, nCmpLevel)
    @ccall libstorm.SCompCompress(pvOutBuffer::Ptr{Cvoid}, pcbOutBuffer::Ptr{Cint}, pvInBuffer::Ptr{Cvoid}, cbInBuffer::Cint, uCompressionMask::Cuint, nCmpType::Cint, nCmpLevel::Cint)::Cint
end

function SCompDecompress(pvOutBuffer, pcbOutBuffer, pvInBuffer, cbInBuffer)
    @ccall libstorm.SCompDecompress(pvOutBuffer::Ptr{Cvoid}, pcbOutBuffer::Ptr{Cint}, pvInBuffer::Ptr{Cvoid}, cbInBuffer::Cint)::Cint
end

function SCompDecompress2(pvOutBuffer, pcbOutBuffer, pvInBuffer, cbInBuffer)
    @ccall libstorm.SCompDecompress2(pvOutBuffer::Ptr{Cvoid}, pcbOutBuffer::Ptr{Cint}, pvInBuffer::Ptr{Cvoid}, cbInBuffer::Cint)::Cint
end

function SetLastError(dwErrCode)
    @ccall libstorm.SetLastError(dwErrCode::DWORD)::Cvoid
end

# no prototype is found for this function at StormLib.h:1140:7, please use with caution
function GetLastError()
    @ccall libstorm.GetLastError()::DWORD
end

const bool = Cchar

const _true = 1

const _false = 0

const MAX_PATH = 1024

const FILE_BEGIN = SEEK_SET

const FILE_CURRENT = SEEK_CUR

const FILE_END = SEEK_END

const ERROR_SUCCESS = 0

const ERROR_BAD_FORMAT = 1000

const ERROR_NO_MORE_FILES = 1001

const ERROR_HANDLE_EOF = 1002

const ERROR_CAN_NOT_COMPLETE = 1003

const ERROR_FILE_CORRUPT = 1004

const ERROR_BUFFER_OVERFLOW = 1005

const STORMLIB_VERSION = 0x091a

const STORMLIB_VERSION_STRING = "9.26"

const ID_MPQ = 0x1a51504d

const ID_MPQ_USERDATA = 0x1b51504d

const ID_MPK = 0x1a4b504d

const ID_MPK_VERSION_2000 = 0x30303032

const ERROR_AVI_FILE = 10000

const ERROR_UNKNOWN_FILE_KEY = 10001

const ERROR_CHECKSUM_ERROR = 10002

const ERROR_INTERNAL_FILE = 10003

const ERROR_BASE_FILE_MISSING = 10004

const ERROR_MARKED_FOR_DELETE = 10005

const ERROR_FILE_INCOMPLETE = 10006

const ERROR_UNKNOWN_FILE_NAMES = 10007

const ERROR_CANT_FIND_PATCH_PREFIX = 10008

const ERROR_FAKE_MPQ_HEADER = 10009

const HASH_TABLE_SIZE_MIN = 0x00000004

const HASH_TABLE_SIZE_DEFAULT = 0x00001000

const HASH_TABLE_SIZE_MAX = 0x00080000

const HASH_ENTRY_DELETED = 0xfffffffe

const HASH_ENTRY_FREE = 0xffffffff

const HET_ENTRY_DELETED = 0x80

const HET_ENTRY_FREE = 0x00

const SFILE_OPEN_HARD_DISK_FILE = 2

const SFILE_OPEN_CDROM_FILE = 3

const SFILE_OPEN_FROM_MPQ = 0x00000000

const SFILE_OPEN_CHECK_EXISTS = 0xfffffffc

const SFILE_OPEN_BASE_FILE = 0xfffffffd

const SFILE_OPEN_ANY_LOCALE = 0xfffffffe

const SFILE_OPEN_LOCAL_FILE = 0xffffffff

const MPQ_FLAG_READ_ONLY = 0x00000001

const MPQ_FLAG_CHANGED = 0x00000002

const MPQ_FLAG_MALFORMED = 0x00000004

const MPQ_FLAG_HASH_TABLE_CUT = 0x00000008

const MPQ_FLAG_BLOCK_TABLE_CUT = 0x00000010

const MPQ_FLAG_CHECK_SECTOR_CRC = 0x00000020

const MPQ_FLAG_SAVING_TABLES = 0x00000040

const MPQ_FLAG_PATCH = 0x00000080

const MPQ_FLAG_STARCRAFT_BETA = 0x00000100

const MPQ_FLAG_STARCRAFT = 0x00000200

const MPQ_FLAG_WAR3_MAP = 0x00000400

const MPQ_FLAG_LISTFILE_NONE = 0x00000800

const MPQ_FLAG_LISTFILE_NEW = 0x00001000

const MPQ_FLAG_LISTFILE_FORCE = 0x00002000

const MPQ_FLAG_ATTRIBUTES_NONE = 0x00004000

const MPQ_FLAG_ATTRIBUTES_NEW = 0x00008000

const MPQ_FLAG_SIGNATURE_NONE = 0x00010000

const MPQ_FLAG_SIGNATURE_NEW = 0x00020000

const MPQ_SUBTYPE_MPQ = 0x00000000

const MPQ_SUBTYPE_SQP = 0x00000001

const MPQ_SUBTYPE_MPK = 0x00000002

const SFILE_INVALID_SIZE = 0xffffffff

const SFILE_INVALID_POS = 0xffffffff

const SFILE_INVALID_ATTRIBUTES = 0xffffffff

const MPQ_FILE_IMPLODE = 0x00000100

const MPQ_FILE_COMPRESS = 0x00000200

const MPQ_FILE_ENCRYPTED = 0x00010000

const MPQ_FILE_KEY_V2 = 0x00020000

const MPQ_FILE_PATCH_FILE = 0x00100000

const MPQ_FILE_SINGLE_UNIT = 0x01000000

const MPQ_FILE_DELETE_MARKER = 0x02000000

const MPQ_FILE_SECTOR_CRC = 0x04000000

const MPQ_FILE_SIGNATURE = 0x10000000

const MPQ_FILE_EXISTS = 0x80000000

const MPQ_FILE_REPLACEEXISTING = 0x80000000

const MPQ_FILE_COMPRESS_MASK = 0x0000ff00

const MPQ_FILE_DEFAULT_INTERNAL = 0xffffffff

const MPQ_FILE_FIX_KEY = 0x00020000

const MPQ_FILE_VALID_FLAGS = ((((((((MPQ_FILE_IMPLODE | MPQ_FILE_COMPRESS) | MPQ_FILE_ENCRYPTED) | MPQ_FILE_KEY_V2) | MPQ_FILE_PATCH_FILE) | MPQ_FILE_SINGLE_UNIT) | MPQ_FILE_DELETE_MARKER) | MPQ_FILE_SECTOR_CRC) | MPQ_FILE_SIGNATURE) | MPQ_FILE_EXISTS

const MPQ_FILE_VALID_FLAGS_W3X = ((((((MPQ_FILE_IMPLODE | MPQ_FILE_COMPRESS) | MPQ_FILE_ENCRYPTED) | MPQ_FILE_KEY_V2) | MPQ_FILE_DELETE_MARKER) | MPQ_FILE_SECTOR_CRC) | MPQ_FILE_SIGNATURE) | MPQ_FILE_EXISTS

const MPQ_FILE_VALID_FLAGS_SCX = (((MPQ_FILE_IMPLODE | MPQ_FILE_COMPRESS) | MPQ_FILE_ENCRYPTED) | MPQ_FILE_KEY_V2) | MPQ_FILE_EXISTS

const MPQ_PATCH_INFO_VALID = 0x80000000

const BLOCK_INDEX_MASK = 0x0fffffff

const MPQ_COMPRESSION_HUFFMANN = 0x01

const MPQ_COMPRESSION_ZLIB = 0x02

const MPQ_COMPRESSION_PKWARE = 0x08

const MPQ_COMPRESSION_BZIP2 = 0x10

const MPQ_COMPRESSION_SPARSE = 0x20

const MPQ_COMPRESSION_ADPCM_MONO = 0x40

const MPQ_COMPRESSION_ADPCM_STEREO = 0x80

const MPQ_COMPRESSION_LZMA = 0x12

const MPQ_COMPRESSION_NEXT_SAME = 0xffffffff

const MPQ_WAVE_QUALITY_HIGH = 0

const MPQ_WAVE_QUALITY_MEDIUM = 1

const MPQ_WAVE_QUALITY_LOW = 2

const HET_TABLE_SIGNATURE = 0x1a544548

const BET_TABLE_SIGNATURE = 0x1a544542

const MPQ_KEY_HASH_TABLE = 0xc3af3770

const MPQ_KEY_BLOCK_TABLE = 0xec83b3a3

const LISTFILE_NAME = "(listfile)"

const SIGNATURE_NAME = "(signature)"

const ATTRIBUTES_NAME = "(attributes)"

const PATCH_METADATA_NAME = "(patch_metadata)"

const MPQ_FORMAT_VERSION_1 = 0

const MPQ_FORMAT_VERSION_2 = 1

const MPQ_FORMAT_VERSION_3 = 2

const MPQ_FORMAT_VERSION_4 = 3

const MPQ_ATTRIBUTE_CRC32 = 0x00000001

const MPQ_ATTRIBUTE_FILETIME = 0x00000002

const MPQ_ATTRIBUTE_MD5 = 0x00000004

const MPQ_ATTRIBUTE_PATCH_BIT = 0x00000008

const MPQ_ATTRIBUTE_ALL = 0x0000000f

const MPQ_ATTRIBUTES_V1 = 100

const BASE_PROVIDER_FILE = 0x00000000

const BASE_PROVIDER_MAP = 0x00000001

const BASE_PROVIDER_HTTP = 0x00000002

const BASE_PROVIDER_MASK = 0x0000000f

const STREAM_PROVIDER_FLAT = 0x00000000

const STREAM_PROVIDER_PARTIAL = 0x00000010

const STREAM_PROVIDER_MPQE = 0x00000020

const STREAM_PROVIDER_BLOCK4 = 0x00000030

const STREAM_PROVIDER_MASK = 0x000000f0

const STREAM_FLAG_READ_ONLY = 0x00000100

const STREAM_FLAG_WRITE_SHARE = 0x00000200

const STREAM_FLAG_USE_BITMAP = 0x00000400

const STREAM_OPTIONS_MASK = 0x0000ff00

const STREAM_PROVIDERS_MASK = 0x000000ff

const STREAM_FLAGS_MASK = 0x0000ffff

const MPQ_OPEN_NO_LISTFILE = 0x00010000

const MPQ_OPEN_NO_ATTRIBUTES = 0x00020000

const MPQ_OPEN_NO_HEADER_SEARCH = 0x00040000

const MPQ_OPEN_FORCE_MPQ_V1 = 0x00080000

const MPQ_OPEN_CHECK_SECTOR_CRC = 0x00100000

const MPQ_OPEN_PATCH = 0x00200000

const MPQ_OPEN_FORCE_LISTFILE = 0x00400000

const MPQ_OPEN_READ_ONLY = STREAM_FLAG_READ_ONLY

const MPQ_CREATE_LISTFILE = 0x00100000

const MPQ_CREATE_ATTRIBUTES = 0x00200000

const MPQ_CREATE_SIGNATURE = 0x00400000

const MPQ_CREATE_ARCHIVE_V1 = 0x00000000

const MPQ_CREATE_ARCHIVE_V2 = 0x01000000

const MPQ_CREATE_ARCHIVE_V3 = 0x02000000

const MPQ_CREATE_ARCHIVE_V4 = 0x03000000

const MPQ_CREATE_ARCHIVE_VMASK = 0x0f000000

const FLAGS_TO_FORMAT_SHIFT = 24

const SFILE_VERIFY_SECTOR_CRC = 0x00000001

const SFILE_VERIFY_FILE_CRC = 0x00000002

const SFILE_VERIFY_FILE_MD5 = 0x00000004

const SFILE_VERIFY_RAW_MD5 = 0x00000008

const SFILE_VERIFY_ALL = 0x0000000f

const VERIFY_OPEN_ERROR = 0x0001

const VERIFY_READ_ERROR = 0x0002

const VERIFY_FILE_HAS_SECTOR_CRC = 0x0004

const VERIFY_FILE_SECTOR_CRC_ERROR = 0x0008

const VERIFY_FILE_HAS_CHECKSUM = 0x0010

const VERIFY_FILE_CHECKSUM_ERROR = 0x0020

const VERIFY_FILE_HAS_MD5 = 0x0040

const VERIFY_FILE_MD5_ERROR = 0x0080

const VERIFY_FILE_HAS_RAW_MD5 = 0x0100

const VERIFY_FILE_RAW_MD5_ERROR = 0x0200

const VERIFY_FILE_ERROR_MASK = ((((VERIFY_OPEN_ERROR | VERIFY_READ_ERROR) | VERIFY_FILE_SECTOR_CRC_ERROR) | VERIFY_FILE_CHECKSUM_ERROR) | VERIFY_FILE_MD5_ERROR) | VERIFY_FILE_RAW_MD5_ERROR

const SFILE_VERIFY_MPQ_HEADER = 0x0001

const SFILE_VERIFY_HET_TABLE = 0x0002

const SFILE_VERIFY_BET_TABLE = 0x0003

const SFILE_VERIFY_HASH_TABLE = 0x0004

const SFILE_VERIFY_BLOCK_TABLE = 0x0005

const SFILE_VERIFY_HIBLOCK_TABLE = 0x0006

const SFILE_VERIFY_FILE = 0x0007

const SIGNATURE_TYPE_NONE = 0x0000

const SIGNATURE_TYPE_WEAK = 0x0001

const SIGNATURE_TYPE_STRONG = 0x0002

const ERROR_NO_SIGNATURE = 0

const ERROR_VERIFY_FAILED = 1

const ERROR_WEAK_SIGNATURE_OK = 2

const ERROR_WEAK_SIGNATURE_ERROR = 3

const ERROR_STRONG_SIGNATURE_OK = 4

const ERROR_STRONG_SIGNATURE_ERROR = 5

const MD5_DIGEST_SIZE = 0x10

const SHA1_DIGEST_SIZE = 0x14

const LANG_NEUTRAL = 0x00

const CCB_CHECKING_FILES = 1

const CCB_CHECKING_HASH_TABLE = 2

const CCB_COPYING_NON_MPQ_DATA = 3

const CCB_COMPACTING_FILES = 4

const CCB_CLOSING_ARCHIVE = 5

const MPQ_HEADER_SIZE_V1 = 0x20

const MPQ_HEADER_SIZE_V2 = 0x2c

const MPQ_HEADER_SIZE_V3 = 0x44

const MPQ_HEADER_SIZE_V4 = 0xd0

const MPQ_HEADER_DWORDS = MPQ_HEADER_SIZE_V4 ÷ 0x04
