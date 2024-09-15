@enum MPQLocale::UInt16 begin
  MPQ_LOCALE_NEUTRAL      = 0x0000
  MPQ_LOCALE_CHINESE      = 0x0404
  MPQ_LOCALE_CZECH        = 0x0405
  MPQ_LOCALE_GERMAN       = 0x0407
  MPQ_LOCALE_ENGLISH      = 0x0409
  MPQ_LOCALE_SPANISH      = 0x040a
  MPQ_LOCALE_FRENCH       = 0x040c
  MPQ_LOCALE_ITALIAN      = 0x0410
  MPQ_LOCALE_JAPANESE     = 0x0411
  MPQ_LOCALE_KOREAN       = 0x0412
  MPQ_LOCALE_DUTCH        = 0x0413
  MPQ_LOCALE_POLISH       = 0x0415
  MPQ_LOCALE_PORTUGUESE   = 0x0416
  MPQ_LOCALE_RUSSSIAN     = 0x0419
  MPQ_LOCALE_ENGLISH_UK   = 0x0809
  MPQ_LOCALE_UNDEFINED    = 0xffff
end

const DEFAULT_MPQ_LOCALE = Ref(MPQ_LOCALE_NEUTRAL)

const MPQ_LOCALE_LIST = Dict{Symbol,MPQLocale}(
  :zhCN => MPQ_LOCALE_CHINESE,
  :zhTW => MPQ_LOCALE_CHINESE,
  :csCZ => MPQ_LOCALE_CZECH,
  :deDE => MPQ_LOCALE_GERMAN,
  :enUS => MPQ_LOCALE_ENGLISH,
  :esES => MPQ_LOCALE_SPANISH,
  :frFR => MPQ_LOCALE_FRENCH,
  :itIT => MPQ_LOCALE_ITALIAN,
  :jaJP => MPQ_LOCALE_JAPANESE,
  :koKR => MPQ_LOCALE_KOREAN,
  :nlNL => MPQ_LOCALE_DUTCH,
  :plPL => MPQ_LOCALE_POLISH,
  :ptPT => MPQ_LOCALE_PORTUGUESE,
  :ruRU => MPQ_LOCALE_RUSSSIAN,
  :enUK => MPQ_LOCALE_ENGLISH_UK,
)

"Get the current locale."
get_default_mpq_locale() = DEFAULT_MPQ_LOCALE[]

"Set the current locale with a new value, returning the one that was previously set."
function set_default_mpq_locale(new::MPQLocale)
  old = DEFAULT_MPQ_LOCALE[]
  DEFAULT_MPQ_LOCALE[] = new
  old
end

set_default_mpq_locale(new::Nothing) = set_default_mpq_locale(MPQ_LOCALE_UNDEFINED)
set_default_mpq_locale(new::Symbol) = set_default_mpq_locale(LOCALE_LIST[new])
