const MPQ_KEY_HASH_TABLE = 0xc3af3770  # hash_filename("(hash table)", MPQ_HASH_FILE_KEY)
const MPQ_KEY_BLOCK_TABLE = 0xec83b3a3  # hash_filename("(block table)", MPQ_HASH_FILE_KEY)

const MPQ_HASH_KEY2_MIX = 0x00000400

function decrypt_block!(data::Vector{UInt32}, key::UInt32)
  key_1::UInt32 = key
  key_2::UInt32 = 0xeeeeeeee
  for i in eachindex(data)
    key_2 += SEED_BUFFER[1 + MPQ_HASH_KEY2_MIX + (key_1 & 0x000000ff)]
    value = data[i] ⊻ (key_1 + key_2)
    data[i] = value
    key_1 = ((~key_1 << 21) + 0x11111111) | (key_1 >> 11)
    key_2 = value + key_2 + (key_2 << 5) + UInt32(3)
  end
  data
end
