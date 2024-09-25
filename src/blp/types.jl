const BLP_MAGIC_NUMBER = tag4"BLP2"

@enum BLPCompression::UInt8 begin
  BLP_COMPRESSION_BLP = 1
  BLP_COMPRESSION_DXTC = 2
  BLP_COMPRESSION_NONE = 3
end

@enum BLPPixelFormat::UInt8 begin
  BLP_PIXEL_FORMAT_DXT1 = 0
  BLP_PIXEL_FORMAT_DXT3 = 1
  BLP_PIXEL_FORMAT_ARGB8888 = 2
  BLP_PIXEL_FORMAT_ARGB1555 = 3
  BLP_PIXEL_FORMAT_ARGB4444 = 4
  BLP_PIXEL_FORMAT_RGB565 = 5
  BLP_PIXEL_FORMAT_A8 = 6
  BLP_PIXEL_FORMAT_DXT5 = 7
  BLP_PIXEL_FORMAT_UNSPECIFIED = 8
  BLP_PIXEL_FORMAT_ARGB2565 = 9
  BLP_PIXEL_FORMAT_UNKNOWN = 10
  BLP_PIXEL_FORMAT_BC5 = 11 # DXGI_FORMAT_BC5_UNORM
end

struct BLPFile
  image::Matrix{RGBA{N0f8}}
  mipmaps::Vector{Matrix{RGBA{N0f8}}}
end

"RGB type on 16 bits in the format R5G6B5."
struct RGB16 <: AbstractRGB{N0f8}
  data::UInt16
end

function Base.getproperty(rgb::RGB16, name::Symbol)
  name === :r && return reinterpret(N0f8, UInt8((rgb.data << 0)  >> 11) << 3)
  name === :g && return reinterpret(N0f8, UInt8((rgb.data << 5)  >> 10) << 2)
  name === :b && return reinterpret(N0f8, UInt8((rgb.data << 11) >> 11) << 3)
  getfield(rgb, name)
end

Base.read(io::IO, ::Type{RGB16}) = RGB16(read(io, UInt16))
Base.write(io::IO, rgb::RGB16) = write(io, rgb.data)

RGB16(r::N0f8, g::N0f8, b::N0f8) = RGB16(foldl((data, (c, n, size)) -> data |= UInt16(c.i >> (8 - size)) << n, zip((r, g, b), (11, 5, 0), (5, 6, 5)); init = 0x0000))
RGB16(r, g, b) = RGB16(N0f8.((r, g, b))...)
RGB16(color::Colorant) = RGB16(color.r, color.g, color.b)

struct BLPData
  image::Matrix{RGBA{N0f8}}
end
