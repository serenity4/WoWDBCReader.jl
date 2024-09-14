@enum DBCLocale::UInt32 begin
  DBC_LOCALE_EN_US = 0
  DBC_LOCALE_KO_KR = 1
  DBC_LOCALE_FR_FR = 2
  DBC_LOCALE_DE_DE = 3
  DBC_LOCALE_EN_CN = 4
  DBC_LOCALE_EN_TW = 5
  DBC_LOCALE_ES_ES = 6
  DBC_LOCALE_ES_MX = 7
  DBC_LOCALE_RU_RU = 8
  DBC_LOCALE_PT_PT = 10
  DBC_LOCALE_IT_IT = 11
  DBC_LOCALE_UNKNOWN = 12
end

const DBC_LOCALE_EN_GB = DBC_LOCALE_EN_US
const DBC_LOCALE_ZH_CN = DBC_LOCALE_EN_CN
const DBC_LOCALE_ZH_TW = DBC_LOCALE_EN_TW
const DBC_LOCALE_PT_BR = DBC_LOCALE_PT_PT

struct LString
  enUS::String
  enGB::String
  koKR::String
  frFR::String
  deDE::String
  enCN::String
  zhCN::String
  enTW::String
  zhTW::String
  esES::String
  esMX::String
  ruRU::String
  ptPT::String
  ptBR::String
  itIT::String
  unknown::String
  mask::UInt32
end

Base.show(io::IO, lstr::LString) = print(io, 'l', sprint(show, lstr.enUS))
