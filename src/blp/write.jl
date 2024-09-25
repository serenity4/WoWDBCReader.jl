"Serialize an image into a BLP format, with DXT5 compression and no mipmaps."
function Base.write(io::IO, data::BLPData)
  write(io, BLP_MAGIC_NUMBER)
  type = UInt32(1)
  write(io, type)
  compression = BLP_COMPRESSION_DXTC
  alpha_depth = 0x08
  pixel_format = BLP_PIXEL_FORMAT_DXT5
  write(io, compression, alpha_depth, pixel_format)
  mip_flags = 0x00
  write(io, mip_flags)
  width, height = size(data.image) .% UInt32
  write(io, width, height)
  # Mip-map offsets.
  write(io, UInt32(1172))
  for _ in 1:15 write(io, UInt32(0)) end
  # Mip-map sizes.
  for _ in 1:16 write(io, UInt32(0)) end
  for _ in 1:256 write(io, UInt32(0)) end # palette
  write_blp_image(io, data.image)
end

function write_blp_image(io, image)
  nx, ny = size(image)
  sx, sy = cld(nx, 4), cld(ny, 4)
  for y in 1:sy
    for x in 1:sx
      block = @view image[1 + 4(x - 1):4x, 1 + 4(y - 1):4y]
      a, b = compute_endpoints(block)
      a_rgb = RGB(a.r, a.g, a.b)
      b_rgb = RGB(b.r, b.g, b.b)
      rgb_bits = 0x00000000
      for bx in 1:4
        for by in 1:4
          rgb_bit_offset = 2 * (bx + 4(by - 1) - 1)
          pixel = block[bx, by]
          pixel_rgb = RGB(pixel.r, pixel.g, pixel.b)
          _, i = findmin(w -> norm(pixel_rgb - mix(a_rgb, b_rgb, w)), (0.0, 1.0, 1/3, 2/3))
          rgb_bits |= ((i - 1) % UInt32) << rgb_bit_offset
        end
      end
      alpha_bits = 0x0000000000000000
      distance = sum(pixel -> minimum(w -> norm(pixel.alpha - mix(a.alpha, b.alpha, w)), (0.0, 1.0, 1/7, 2/7, 3/7, 4/7, 5/7, 6/7)), block)
      distance_2 = sum(pixel -> minimum(w -> norm(pixel.alpha - (w == 10.0 ? 0.0 : w == 11.0 ? 1.0 : mix(a.alpha, b.alpha, w))), (0.0, 1.0, 1/5, 2/5, 3/5, 4/5, 10.0, 11.0)), block)
      default_mode = distance < distance_2
      for bx in 1:4
        for by in 1:4
          pixel = block[bx, by]
          alpha_bit_offset = 3 * (bx + 4(by - 1) - 1)
          if default_mode
            _, i = findmin(w -> norm(pixel.alpha - mix(a.alpha, b.alpha, w)), (0.0, 1.0, 1/7, 2/7, 3/7, 4/7, 5/7, 6/7))
          else
            _, i = findmin(w -> norm(pixel.alpha - (w == 10.0 ? 0.0 : w == 11.0 ? 1.0 : mix(a.alpha, b.alpha, w))), (0.0, 1.0, 1/5, 2/5, 3/5, 4/5, 10.0, 11.0))
          end
          alpha_bits |= ((i - 1) % UInt64) << alpha_bit_offset
        end
      end
      alpha_endpoints = default_mode ?
       ifelse(a.alpha > b.alpha, (a.alpha, b.alpha), (b.alpha, a.alpha)) :
       ifelse(a.alpha > b.alpha, (b.alpha, a.alpha), (a.alpha, b.alpha))
      alpha_block = |(
        UInt64(0),
        reinterpret(UInt8, N0f8(alpha_endpoints[1])),
        reinterpret(UInt8, N0f8(alpha_endpoints[2])) << 8,
        alpha_bits << 16,
      )
      write(io, alpha_block)
      write(io, RGB16(a), RGB16(b), rgb_bits)
    end
  end
end


function compute_endpoints(block::AbstractMatrix{RGBA{N0f8}})
  data = reshape(block, (1, 16))
  # Inspired from https://www.sjbrown.co.uk/posts/dxt-compression-techniques/
  table = getproperty.(data, :alpha)
  pca = fit(PCA, table; maxoutdim = 1)
  components = predict(pca, table)::Matrix{Float64}
  alpha_approx = reconstruct(pca, [minimum(components) maximum(components)])::Matrix{Float64}
  alpha_a = clamp(alpha_approx[1, 1], 0, 1)
  alpha_b = clamp(alpha_approx[1, 2], 0, 1)

  table = [getproperty.(data, :r); getproperty.(data, :g); getproperty.(data, :b)]
  pca = fit(PCA, table; maxoutdim = 1)
  components = predict(pca, table)::Matrix{Float64}
  rgb_approx = reconstruct(pca, [minimum(components) maximum(components)])::Matrix{Float64}

  a = RGBA(ntuple(i -> clamp(rgb_approx[i, 1], 0, 1), 3)..., alpha_a)
  b = RGBA(ntuple(i -> clamp(rgb_approx[i, 2], 0, 1), 3)..., alpha_b)
  a, b
end
