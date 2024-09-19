@enum Class::UInt32 begin
  CLASS_GENERIC = 0
  CLASS_HOLIDAYS_EVENTS = 1
  CLASS_MAGE = 3
  CLASS_WARRIOR = 4
  CLASS_WARLOCK = 5
  CLASS_PRIEST = 6
  CLASS_DRUID = 7
  CLASS_ROGUE = 8
  CLASS_HUNTER = 9
  CLASS_PALADIN = 10
  CLASS_SHAMAN = 11
  CLASS_SPELLS = 12
  CLASS_POTION = 13
  CLASS_DEATH_KNIGHT = 15
  CLASS_PET = 17
end

struct ClassInfo
  value::Class
  name::Symbol
  color::SimpleColor
end

const CLASS_NAMES = Dict(
  CLASS_GENERIC => "Generic",
  CLASS_HOLIDAYS_EVENTS => "Holidays/events",
  CLASS_MAGE => "Mage",
  CLASS_WARRIOR => "Warrior",
  CLASS_WARLOCK => "Warlock",
  CLASS_PRIEST => "Priest",
  CLASS_DRUID => "Druid",
  CLASS_ROGUE => "Rogue",
  CLASS_HUNTER => "Hunter",
  CLASS_PALADIN => "Paladin",
  CLASS_SHAMAN => "Shaman",
  CLASS_SPELLS => "Spell",
  CLASS_POTION => "Potion",
  CLASS_DEATH_KNIGHT => "Death Knight",
  CLASS_PET => "Pet",
)

const CLASS_COLORS = Dict(
  CLASS_MAGE => SimpleColor(0x3fc7eb),
  CLASS_WARRIOR => SimpleColor(0xc69b6d),
  CLASS_WARLOCK => SimpleColor(0x8788ee),
  CLASS_PRIEST => SimpleColor(0xffffff),
  CLASS_DRUID => SimpleColor(0xff7c0a),
  CLASS_ROGUE => SimpleColor(0xfff468),
  CLASS_HUNTER => SimpleColor(0xaad372),
  CLASS_PALADIN => SimpleColor(0xf48cba),
  CLASS_SHAMAN => SimpleColor(0x0070dd),
  CLASS_DEATH_KNIGHT => SimpleColor(0xc41e3a),
)

classname(class::Class) = get(CLASS_NAMES, class, nothing)
isplayableclass(class::Class) = !in(class, (CLASS_GENERIC, CLASS_HOLIDAYS_EVENTS, CLASS_SPELLS, CLASS_POTION, CLASS_PET))

Base.print(io::IO, class::Class) = show(io, class)
Base.show(io::IO, ::MIME"text/plain", class::Class) = show(io, class)
function Base.show(io::IO, class::Class)
  name = classname(class)
  !isplayableclass(class) && return print(io, name)
  get(io, :compact, false) && return print(io, name)
  color = get(CLASS_COLORS, class, nothing)
  isnothing(color) && return print(io, name)
  face = Face(; foreground = color)
  print(IOContext(io, :color => true), styled"{$face:$name}")
end
