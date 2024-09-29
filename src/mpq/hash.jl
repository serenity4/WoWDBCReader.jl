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

function hash_filename(filename::AbstractString, hash_type; slash_to_backslash = true)
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

function hash_table_slot(ht::MPQHashTable, filename::AbstractString; locale::Optional{MPQLocale} = nothing, allow_free::Bool = false)
  h = hash_filename(filename, MPQ_HASH_TABLE_INDEX)
  ha = hash_filename(filename, MPQ_HASH_NAME_A)
  hb = hash_filename(filename, MPQ_HASH_NAME_B)
  n = length(ht.entries)
  index::UInt32 = mod1(h + one(h), n)
  stop = index - one(index)
  while index ≠ stop
    entry = ht.entries[index]
    entry.block_index == 0xffffffff && return ifelse(allow_free, index, 0xffffffff)
    entry.ha == ha && entry.hb == hb && (isnothing(locale) || entry.locale == locale) && return index
    index = mod1(index + one(index), n)
  end
  0xffffffff
end
