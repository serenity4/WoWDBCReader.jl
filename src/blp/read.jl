function BinaryParsingTools.swap_endianness(io::IO, ::Type{BLPFile})
  peek(io, Tag4) == reverse(BLP_MAGIC_NUMBER)
end

BLPFile(path::AbstractString) = open(io -> read_binary(io, BLPFile), path, "r")
BLPFile(bytes::AbstractVector) = read_binary(IOBuffer(bytes), BLPFile)

function Base.read(io::BinaryIO, ::Type{BLPFile})
  magic = read(io, Tag4)
  magic === BLP_MAGIC_NUMBER || error("Magic number does not match that of a BLP file: got '$magic' instead of '$BLP_MAGIC_NUMBER'")
  type = read(io, UInt32)
  type == 1 || error("BLP file type expected to be 1, but is $type")
  compression = read(io, BLPCompression)
  alpha_depth = read(io, UInt8)
  any(==(alpha_depth), (0, 1, 4, 8)) || error("Unsupported alpha depth value: $alpha_depth")
  pixel_format = read(io, BLPPixelFormat)
  mip_flags = read(io, UInt8)
  has_mips = Bool(mip_flags & 0x0f)
  width = read(io, UInt32)
  height = read(io, UInt32)
  ispow2(width) || error("Image width must be a power of two.")
  ispow2(height) || error("Image height must be a power of two.")
  mipmap_offsets = [read(io, UInt32) for _ in 1:16]
  mipmap_lengths = [read(io, UInt32) for _ in 1:16]
  palette = compression === BLP_COMPRESSION_BLP ? [reinterpret(ABGR{N0f8}, read(io, UInt32)) for _ in 1:256] : nothing
  images = read_blp_images(io, width, height, compression, alpha_depth, pixel_format, has_mips, mipmap_offsets, mipmap_lengths, palette)
  BLPFile(popfirst!(images), images)
end

function read_blp_images(io, width, height, compression, alpha_depth, pixel_format, has_mips::Bool, mipmap_offsets, mipmap_lengths, palette)
  mip_range = 0:(has_mips ? minimum(Int ∘ log2, (width, height)) : 0)
  images = Matrix{RGBA{N0f8}}[]
  for (level, offset, size) in zip(mip_range, mipmap_offsets, mipmap_lengths)
    nx, ny = width >> level, height >> level
    n = nx * ny
    !iszero(offset) && seek(io, offset)
    image = zeros(RGBA{N0f8}, nx, ny)
    push!(images, image)
    linear = transpose(image)
    if compression === BLP_COMPRESSION_BLP
      palette::Vector{ABGR{N0f8}}
      for i in 1:n
        index = read(io, UInt8)
        pixel = palette[index + 1]
        image[i] = RGBA(pixel.r, pixel.g, pixel.b, pixel.alpha)
      end
      if alpha_depth > 0
        n_per_alpha = 8 ÷ alpha_depth
        na = nx * ny >> (n_per_alpha - 1)
        for i in 1:na
          alpha = read(io, UInt8)
          for k in 1:n_per_alpha
            pixel = image[i]
            image[i] = @set pixel.alpha = reinterpret(N0f8, (alpha << (8 - k * alpha_depth)) >> 8 - alpha_depth)
          end
        end
      end
    else
      error("Unsupported compression format $compression")
    end
  end
  images
end
