function initialize_seed_buffer()
  result = zeros(UInt32, 1280)
  seed::UInt32 = 0x00100001
  for i in 1:256
    for j in 1:5
      index = i + (j - 1) * 256
      seed = next_seed(seed)
      a = (seed & 0xffff) << 16
      seed = next_seed(seed)
      b = seed & 0xffff
      result[index] = a | b
    end
  end
  result
end

function next_seed(seed::UInt32)
  seed *= UInt32(125)
  seed += UInt32(3)
  seed % 0x002aaaab
end

const SEED_BUFFER = initialize_seed_buffer()

const MPQ_HASH_TABLE_INDEX = 0x000
const MPQ_HASH_NAME_A = 0x100
const MPQ_HASH_NAME_B = 0x200
const MPQ_HASH_FILE_KEY = 0x300

function hash_filename(filename::AbstractString, hash_type; slash_to_backslash = false)
  seed_1::UInt32 = 0x7fed7fed
  seed_2::UInt32 = 0xeeeeeeee
  for char in filename
    char = uppercase(char)
    slash_to_backslash && char == '/' && (char = '\\')
    byte = UInt8(char)
    seed_1 = SEED_BUFFER[hash_type + byte + 1] ⊻ (seed_1 + seed_2)
    seed_2 = byte + seed_1 + seed_2 + (seed_2 << 5) + UInt32(3)
  end
  seed_1
end

function hash_table_slot(filename::AbstractString, table, table_length)
  h = hash_filename(filename, MPQ_HASH_TABLE_INDEX)
  ha = hash_filename(filename, MPQ_HASH_NAME_A)
  hb = hash_filename(filename, MPQ_HASH_NAME_B)
  index::UInt32 = mod1(h, table_length)
  original = index - one(index)
  while index ≠ original
    entry = table[index]
    entry === nothing && break
    entry.ha == ha && entry.hb == hb && return index
    index = mod1(index + one(index), table_length)
  end
  0xffffffff
end
