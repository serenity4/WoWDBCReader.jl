# This file was automatically generated with `generator/generate_schemas.jl`.

abstract type DBCDataType end

struct AchievementData <: DBCDataType
    ID::Int32
    Faction::Int32
    Instance_Id::Int32
    Supercedes::Int32
    Title::LString
    Description::LString
    Category::Int32
    Points::Int32
    Ui_Order::Int32
    Flags::Int32
    IconID::Int32
    Reward::LString
    Minimum_Criteria::Int32
    Shares_Criteria::Int32
end

struct Achievement_categoryData <: DBCDataType
    ID::Int32
    Parent::Int32
    Name::LString
    Ui_Order::Int32
end

struct Achievement_criteriaData <: DBCDataType
    ID::Int32
    Achievement_Id::Int32
    Type::Int32
    Asset_Id::Int32
    Quantity::Int32
    Start_Event::Int32
    Start_Asset::Int32
    Fail_Event::Int32
    Fail_Asset::Int32
    Description::LString
    Flags::Int32
    Timer_Start_Event::Int32
    Timer_Asset_Id::Int32
    Timer_Time::Int32
    Ui_Order::Int32
end

struct AreagroupData <: DBCDataType
    ID::Int32
    AreaID_1::Int32
    AreaID_2::Int32
    AreaID_3::Int32
    AreaID_4::Int32
    AreaID_5::Int32
    AreaID_6::Int32
    NextAreaID::Int32
end

struct AreapoiData <: DBCDataType
    ID::Int32
    Importance::Int32
    Icon_1::Int32
    Icon_2::Int32
    Icon_3::Int32
    Icon_4::Int32
    Icon_5::Int32
    Icon_6::Int32
    Icon_7::Int32
    Icon_8::Int32
    Icon_9::Int32
    FactionID::Int32
    X::Float32
    Y::Float32
    Z::Float32
    ContinentID::Int32
    Flags::Int32
    AreaID::Int32
    Name::LString
    Description::LString
    WorldStateID::Int32
    WorldMapLink::Int32
end

struct AreatableData <: DBCDataType
    ID::Int32
    ContinentID::Int32
    ParentAreaID::Int32
    AreaBit::Int32
    Flags::Int32
    SoundProviderPref::Int32
    SoundProviderPrefUnderwater::Int32
    AmbienceID::Int32
    ZoneMusic::Int32
    IntroSound::Int32
    ExplorationLevel::Int32
    AreaName::LString
    FactionGroupMask::Int32
    LiquidTypeID_1::Int32
    LiquidTypeID_2::Int32
    LiquidTypeID_3::Int32
    LiquidTypeID_4::Int32
    MinElevation::Float32
    Ambient_Multiplier::Float32
    Lightid::Int32
end

struct AuctionhouseData <: DBCDataType
    ID::Int32
    FactionID::Int32
    DepositRate::Int32
    ConsignmentRate::Int32
    Name::LString
end

struct BankbagslotpricesData <: DBCDataType
    ID::Int32
    Cost::Int32
end

struct BarbershopstyleData <: DBCDataType
    ID::Int32
    Type::Int32
    DisplayName::LString
    Description::LString
    Cost_Modifier::Float32
    Race::Int32
    Sex::Int32
    Data::Int32
end

struct BattlemasterlistData <: DBCDataType
    ID::Int32
    MapID_1::Int32
    MapID_2::Int32
    MapID_3::Int32
    MapID_4::Int32
    MapID_5::Int32
    MapID_6::Int32
    MapID_7::Int32
    MapID_8::Int32
    InstanceType::Int32
    GroupsAllowed::Int32
    Name::LString
    MaxGroupSize::Int32
    HolidayWorldState::Int32
    Minlevel::Int32
    Maxlevel::Int32
end

struct CharbaseinfoData <: DBCDataType
    ID::Int32
    RaceID::UInt32
    ClassID::UInt32
end

struct CharstartoutfitData <: DBCDataType
    ID::Int32
    RaceID::UInt32
    ClassID::UInt32
    SexID::UInt32
    OutfitID::UInt32
    ItemID_1::Int32
    ItemID_2::Int32
    ItemID_3::Int32
    ItemID_4::Int32
    ItemID_5::Int32
    ItemID_6::Int32
    ItemID_7::Int32
    ItemID_8::Int32
    ItemID_9::Int32
    ItemID_10::Int32
    ItemID_11::Int32
    ItemID_12::Int32
    ItemID_13::Int32
    ItemID_14::Int32
    ItemID_15::Int32
    ItemID_16::Int32
    ItemID_17::Int32
    ItemID_18::Int32
    ItemID_19::Int32
    ItemID_20::Int32
    ItemID_21::Int32
    ItemID_22::Int32
    ItemID_23::Int32
    ItemID_24::Int32
    DisplayItemID_1::Int32
    DisplayItemID_2::Int32
    DisplayItemID_3::Int32
    DisplayItemID_4::Int32
    DisplayItemID_5::Int32
    DisplayItemID_6::Int32
    DisplayItemID_7::Int32
    DisplayItemID_8::Int32
    DisplayItemID_9::Int32
    DisplayItemID_10::Int32
    DisplayItemID_11::Int32
    DisplayItemID_12::Int32
    DisplayItemID_13::Int32
    DisplayItemID_14::Int32
    DisplayItemID_15::Int32
    DisplayItemID_16::Int32
    DisplayItemID_17::Int32
    DisplayItemID_18::Int32
    DisplayItemID_19::Int32
    DisplayItemID_20::Int32
    DisplayItemID_21::Int32
    DisplayItemID_22::Int32
    DisplayItemID_23::Int32
    DisplayItemID_24::Int32
    InventoryType_1::Int32
    InventoryType_2::Int32
    InventoryType_3::Int32
    InventoryType_4::Int32
    InventoryType_5::Int32
    InventoryType_6::Int32
    InventoryType_7::Int32
    InventoryType_8::Int32
    InventoryType_9::Int32
    InventoryType_10::Int32
    InventoryType_11::Int32
    InventoryType_12::Int32
    InventoryType_13::Int32
    InventoryType_14::Int32
    InventoryType_15::Int32
    InventoryType_16::Int32
    InventoryType_17::Int32
    InventoryType_18::Int32
    InventoryType_19::Int32
    InventoryType_20::Int32
    InventoryType_21::Int32
    InventoryType_22::Int32
    InventoryType_23::Int32
    InventoryType_24::Int32
end

struct ChartitlesData <: DBCDataType
    ID::Int32
    Condition_ID::Int32
    Name::LString
    Name1::LString
    Mask_ID::Int32
end

struct ChatchannelsData <: DBCDataType
    ID::Int32
    Flags::Int32
    FactionGroup::Int32
    Name::LString
    Shortcut::LString
end

struct ChrclassesData <: DBCDataType
    ID::Int32
    Field01::Int32
    DisplayPower::Int32
    PetNameToken::Int32
    Name::LString
    Name_Female::LString
    Name_Male::LString
    Filename::String
    SpellClassSet::Int32
    Flags::Int32
    CinematicSequenceID::Int32
    Required_Expansion::Int32
end

struct ChrracesData <: DBCDataType
    ID::Int32
    Flags::Int32
    FactionID::Int32
    ExplorationSoundID::Int32
    MaleDisplayId::Int32
    FemaleDisplayId::Int32
    ClientPrefix::String
    BaseLanguage::Int32
    CreatureType::Int32
    ResSicknessSpellID::Int32
    SplashSoundID::Int32
    ClientFilestring::String
    CinematicSequenceID::Int32
    Alliance::Int32
    Name::LString
    Name_Female::LString
    Name_Male::LString
    FacialHairCustomization_1::String
    FacialHairCustomization_2::String
    HairCustomization::String
    Required_Expansion::Int32
end

struct CinematiccameraData <: DBCDataType
    ID::Int32
    model::String
    soundEntry::Int32
    locationX::Float32
    locationY::Float32
    locationZ::Float32
    rotation::Float32
end

struct CinematicsequencesData <: DBCDataType
    ID::Int32
    SoundID::Int32
    Camera_1::Int32
    Camera_2::Int32
    Camera_3::Int32
    Camera_4::Int32
    Camera_5::Int32
    Camera_6::Int32
    Camera_7::Int32
    Camera_8::Int32
end

struct CreaturedisplayinfoData <: DBCDataType
    ID::Int32
    ModelID::Int32
    SoundID::Int32
    ExtendedDisplayInfoID::Int32
    CreatureModelScale::Float32
    CreatureModelAlpha::Int32
    TextureVariation_1::String
    TextureVariation_2::String
    TextureVariation_3::String
    PortraitTextureName::String
    BloodLevel::Int32
    BloodID::Int32
    NPCSoundID::Int32
    ParticleColorID::Int32
    CreatureGeosetData::Int32
    ObjectEffectPackageID::Int32
end

struct CreaturedisplayinfoextraData <: DBCDataType
    ID::Int32
    DisplayRaceID::Int32
    DisplaySexID::Int32
    SkinID::Int32
    FaceID::Int32
    HairStyleID::Int32
    HairColorID::Int32
    FacialHairID::Int32
    NPCItemDisplay1::Int32
    NPCItemDisplay2::Int32
    NPCItemDisplay3::Int32
    NPCItemDisplay4::Int32
    NPCItemDisplay5::Int32
    NPCItemDisplay6::Int32
    NPCItemDisplay7::Int32
    NPCItemDisplay8::Int32
    NPCItemDisplay9::Int32
    NPCItemDisplay10::Int32
    NPCItemDisplay11::Int32
    Flags::Int32
    BakeName::String
end

struct CreaturefamilyData <: DBCDataType
    ID::Int32
    MinScale::Float32
    MinScaleLevel::Int32
    MaxScale::Float32
    MaxScaleLevel::Int32
    SkillLine_1::Int32
    SkillLine_2::Int32
    PetFoodMask::Int32
    PetTalentType::Int32
    CategoryEnumID::Int32
    Name::LString
    IconFile::String
end

struct CreaturemodeldataData <: DBCDataType
    ID::Int32
    Flags::Int32
    ModelName::String
    SizeClass::Int32
    ModelScale::Float32
    BloodID::Int32
    FootprintTextureID::Int32
    FootprintTextureLength::Float32
    FootprintTextureWidth::Float32
    FootprintParticleScale::Float32
    FoleyMaterialID::Int32
    FootstepShakeSize::Int32
    DeathThudShakeSize::Int32
    SoundID::Int32
    CollisionWidth::Float32
    CollisionHeight::Float32
    MountHeight::Float32
    GeoBoxMinX::Float32
    GeoBoxMinY::Float32
    GeoBoxMinZ::Float32
    GeoBoxMaxX::Float32
    GeoBoxMaxY::Float32
    GeoBoxMaxZ::Float32
    WorldEffectScale::Float32
    AttachedEffectScale::Float32
    MissileCollisionRadius::Float32
    MissileCollisionPush::Float32
    MissileCollisionRaise::Float32
end

struct CreaturespelldataData <: DBCDataType
    ID::Int32
    Spells_1::Int32
    Spells_2::Int32
    Spells_3::Int32
    Spells_4::Int32
    Availability_1::Int32
    Availability_2::Int32
    Availability_3::Int32
    Availability_4::Int32
end

struct CreaturetypeData <: DBCDataType
    ID::Int32
    Name::LString
    Flags::Int32
end

struct CurrencytypesData <: DBCDataType
    ID::Int32
    ItemID::Int32
    CategoryID::Int32
    BitIndex::Int32
end

struct DestructiblemodeldataData <: DBCDataType
    ID::Int32
    State0Wmo::Int32
    State0DestructionDoodadSet::Int32
    State0ImpactEffectDoodadSet::Int32
    State0AmbientDoodadSet::Int32
    State1Wmo::Int32
    State1DestructionDoodadSet::Int32
    State1ImpactEffectDoodadSet::Int32
    State1AmbientDoodadSet::Int32
    State2Wmo::Int32
    State2DestructionDoodadSet::Int32
    State2ImpactEffectDoodadSet::Int32
    State2AmbientDoodadSet::Int32
    State3Wmo::Int32
    State3DestructionDoodadSet::Int32
    State3ImpactEffectDoodadSet::Int32
    State3AmbientDoodadSet::Int32
    Field17::Int32
    Field18::Int32
end

struct DungeonencounterData <: DBCDataType
    ID::Int32
    MapID::Int32
    Difficulty::Int32
    OrderIndex::Int32
    Bit::Int32
    Name::LString
    SpellIconID::Int32
end

struct DurabilitycostsData <: DBCDataType
    ID::Int32
    WeaponSubClassCost_1::Int32
    WeaponSubClassCost_2::Int32
    WeaponSubClassCost_3::Int32
    WeaponSubClassCost_4::Int32
    WeaponSubClassCost_5::Int32
    WeaponSubClassCost_6::Int32
    WeaponSubClassCost_7::Int32
    WeaponSubClassCost_8::Int32
    WeaponSubClassCost_9::Int32
    WeaponSubClassCost_10::Int32
    WeaponSubClassCost_11::Int32
    WeaponSubClassCost_12::Int32
    WeaponSubClassCost_13::Int32
    WeaponSubClassCost_14::Int32
    WeaponSubClassCost_15::Int32
    WeaponSubClassCost_16::Int32
    WeaponSubClassCost_17::Int32
    WeaponSubClassCost_18::Int32
    WeaponSubClassCost_19::Int32
    WeaponSubClassCost_20::Int32
    WeaponSubClassCost_21::Int32
    ArmorSubClassCost_1::Int32
    ArmorSubClassCost_2::Int32
    ArmorSubClassCost_3::Int32
    ArmorSubClassCost_4::Int32
    ArmorSubClassCost_5::Int32
    ArmorSubClassCost_6::Int32
    ArmorSubClassCost_7::Int32
    ArmorSubClassCost_8::Int32
end

struct DurabilityqualityData <: DBCDataType
    ID::Int32
    Data::Float32
end

struct EmotesData <: DBCDataType
    ID::Int32
    EmoteSlashCommand::String
    AnimID::Int32
    EmoteFlags::Int32
    EmoteSpecProc::Int32
    EmoteSpecProcParam::Int32
    EventSoundID::Int32
end

struct EmotestextData <: DBCDataType
    ID::Int32
    Name::String
    EmoteID::Int32
    EmoteText_1::Int32
    EmoteText_2::Int32
    EmoteText_3::Int32
    EmoteText_4::Int32
    EmoteText_5::Int32
    EmoteText_6::Int32
    EmoteText_7::Int32
    EmoteText_8::Int32
    EmoteText_9::Int32
    EmoteText_10::Int32
    EmoteText_11::Int32
    EmoteText_12::Int32
    EmoteText_13::Int32
    EmoteText_14::Int32
    EmoteText_15::Int32
    EmoteText_16::Int32
end

struct FactionData <: DBCDataType
    ID::Int32
    ReputationIndex::Int32
    ReputationRaceMask_1::Int32
    ReputationRaceMask_2::Int32
    ReputationRaceMask_3::Int32
    ReputationRaceMask_4::Int32
    ReputationClassMask_1::Int32
    ReputationClassMask_2::Int32
    ReputationClassMask_3::Int32
    ReputationClassMask_4::Int32
    ReputationBase_1::Int32
    ReputationBase_2::Int32
    ReputationBase_3::Int32
    ReputationBase_4::Int32
    ReputationFlags_1::Int32
    ReputationFlags_2::Int32
    ReputationFlags_3::Int32
    ReputationFlags_4::Int32
    ParentFactionID::Int32
    ParentFactionMod_1::Float32
    ParentFactionMod_2::Float32
    ParentFactionCap_1::Int32
    ParentFactionCap_2::Int32
    Name::LString
    Description::LString
end

struct FactiontemplateData <: DBCDataType
    ID::Int32
    Faction::Int32
    Flags::Int32
    FactionGroup::Int32
    FriendGroup::Int32
    EnemyGroup::Int32
    Enemies_1::Int32
    Enemies_2::Int32
    Enemies_3::Int32
    Enemies_4::Int32
    Friend_1::Int32
    Friend_2::Int32
    Friend_3::Int32
    Friend_4::Int32
end

struct GameobjectdisplayinfoData <: DBCDataType
    ID::Int32
    ModelName::String
    Sound_1::Int32
    Sound_2::Int32
    Sound_3::Int32
    Sound_4::Int32
    Sound_5::Int32
    Sound_6::Int32
    Sound_7::Int32
    Sound_8::Int32
    Sound_9::Int32
    Sound_10::Int32
    GeoBoxMinX::Float32
    GeoBoxMinY::Float32
    GeoBoxMinZ::Float32
    GeoBoxMaxX::Float32
    GeoBoxMaxY::Float32
    GeoBoxMaxZ::Float32
    ObjectEffectPackageID::Int32
end

struct GempropertiesData <: DBCDataType
    ID::Int32
    Enchant_Id::Int32
    Maxcount_Inv::Int32
    Maxcount_Item::Int32
    Type::Int32
end

struct GlyphpropertiesData <: DBCDataType
    ID::Int32
    SpellID::Int32
    GlyphSlotFlags::Int32
    SpellIconID::Int32
end

struct GlyphslotData <: DBCDataType
    ID::Int32
    Type::Int32
    Tooltip::Int32
end

struct GtbarbershopcostbaseData <: DBCDataType
    ID::Int32
    Data::Float32
end

struct GtchancetomeleecritData <: DBCDataType
    ID::Int32
    Data::Float32
end

struct GtchancetomeleecritbaseData <: DBCDataType
    ID::Int32
    Data::Float32
end

struct GtchancetospellcritData <: DBCDataType
    ID::Int32
    Data::Float32
end

struct GtchancetospellcritbaseData <: DBCDataType
    ID::Int32
    Data::Float32
end

struct GtcombatratingsData <: DBCDataType
    ID::Int32
    Data::Float32
end

struct GtnpcmanacostscalerData <: DBCDataType
    ID::Int32
    Data::Float32
end

struct GtoctclasscombatratingscalarData <: DBCDataType
    ID::Int32
    Data::Float32
end

struct GtoctregenhpData <: DBCDataType
    ID::Int32
    Data::Float32
end

struct GtregenhppersptData <: DBCDataType
    ID::Int32
    Data::Float32
end

struct GtregenmppersptData <: DBCDataType
    ID::Int32
    Data::Float32
end

struct HolidaysData <: DBCDataType
    ID::Int32
    Duration_1::Int32
    Duration_2::Int32
    Duration_3::Int32
    Duration_4::Int32
    Duration_5::Int32
    Duration_6::Int32
    Duration_7::Int32
    Duration_8::Int32
    Duration_9::Int32
    Duration_10::Int32
    Date_1::Int32
    Date_2::Int32
    Date_3::Int32
    Date_4::Int32
    Date_5::Int32
    Date_6::Int32
    Date_7::Int32
    Date_8::Int32
    Date_9::Int32
    Date_10::Int32
    Date_11::Int32
    Date_12::Int32
    Date_13::Int32
    Date_14::Int32
    Date_15::Int32
    Date_16::Int32
    Date_17::Int32
    Date_18::Int32
    Date_19::Int32
    Date_20::Int32
    Date_21::Int32
    Date_22::Int32
    Date_23::Int32
    Date_24::Int32
    Date_25::Int32
    Date_26::Int32
    Region::Int32
    Looping::Int32
    CalendarFlags_1::Int32
    CalendarFlags_2::Int32
    CalendarFlags_3::Int32
    CalendarFlags_4::Int32
    CalendarFlags_5::Int32
    CalendarFlags_6::Int32
    CalendarFlags_7::Int32
    CalendarFlags_8::Int32
    CalendarFlags_9::Int32
    CalendarFlags_10::Int32
    HolidayNameID::Int32
    HolidayDescriptionID::Int32
    TextureFilename::String
    Priority::Int32
    CalendarFilterType::Int32
    Flags::Int32
end

struct ItemData <: DBCDataType
    ID::Int32
    ClassID::Int32
    SubclassID::Int32
    Sound_Override_Subclassid::Int32
    Material::Int32
    DisplayInfoID::Int32
    InventoryType::Int32
    SheatheType::Int32
end

struct ItembagfamilyData <: DBCDataType
    ID::Int32
    Name::LString
end

struct ItemdisplayinfoData <: DBCDataType
    ID::Int32
    ModelName_1::String
    ModelName_2::String
    ModelTexture_1::String
    ModelTexture_2::String
    InventoryIcon_1::String
    InventoryIcon_2::String
    GeosetGroup_1::Int32
    GeosetGroup_2::Int32
    GeosetGroup_3::Int32
    Flags::Int32
    SpellVisualID::Int32
    GroupSoundIndex::Int32
    HelmetGeosetVis_1::Int32
    HelmetGeosetVis_2::Int32
    Texture_1::String
    Texture_2::String
    Texture_3::String
    Texture_4::String
    Texture_5::String
    Texture_6::String
    Texture_7::String
    Texture_8::String
    ItemVisual::Int32
    ParticleColorID::Int32
end

struct ItemextendedcostData <: DBCDataType
    ID::Int32
    HonorPoints::Int32
    ArenaPoints::Int32
    ArenaBracket::Int32
    ItemID_1::Int32
    ItemID_2::Int32
    ItemID_3::Int32
    ItemID_4::Int32
    ItemID_5::Int32
    ItemCount_1::Int32
    ItemCount_2::Int32
    ItemCount_3::Int32
    ItemCount_4::Int32
    ItemCount_5::Int32
    RequiredArenaRating::Int32
    ItemPurchaseGroup::Int32
end

struct ItemlimitcategoryData <: DBCDataType
    ID::Int32
    Name::LString
    Quantity::Int32
    Flags::Int32
end

struct ItemrandompropertiesData <: DBCDataType
    ID::Int32
    Name::String
    Enchantment_1::Int32
    Enchantment_2::Int32
    Enchantment_3::Int32
    Enchantment_4::Int32
    Enchantment_5::Int32
    _Name::LString
end

struct ItemrandomsuffixData <: DBCDataType
    ID::Int32
    Name::LString
    InternalName::String
    Enchantment_1::Int32
    Enchantment_2::Int32
    Enchantment_3::Int32
    Enchantment_4::Int32
    Enchantment_5::Int32
    AllocationPct_1::Int32
    AllocationPct_2::Int32
    AllocationPct_3::Int32
    AllocationPct_4::Int32
    AllocationPct_5::Int32
end

struct ItemsetData <: DBCDataType
    ID::Int32
    Name::LString
    ItemID_1::Int32
    ItemID_2::Int32
    ItemID_3::Int32
    ItemID_4::Int32
    ItemID_5::Int32
    ItemID_6::Int32
    ItemID_7::Int32
    ItemID_8::Int32
    ItemID_9::Int32
    ItemID_10::Int32
    ItemID_11::Int32
    ItemID_12::Int32
    ItemID_13::Int32
    ItemID_14::Int32
    ItemID_15::Int32
    ItemID_16::Int32
    ItemID_17::Int32
    SetSpellID_1::Int32
    SetSpellID_2::Int32
    SetSpellID_3::Int32
    SetSpellID_4::Int32
    SetSpellID_5::Int32
    SetSpellID_6::Int32
    SetSpellID_7::Int32
    SetSpellID_8::Int32
    SetThreshold_1::Int32
    SetThreshold_2::Int32
    SetThreshold_3::Int32
    SetThreshold_4::Int32
    SetThreshold_5::Int32
    SetThreshold_6::Int32
    SetThreshold_7::Int32
    SetThreshold_8::Int32
    RequiredSkill::Int32
    RequiredSkillRank::Int32
end

struct LfgdungeonsData <: DBCDataType
    ID::Int32
    Name::LString
    MinLevel::Int32
    MaxLevel::Int32
    Target_Level::Int32
    Target_Level_Min::Int32
    Target_Level_Max::Int32
    MapID::Int32
    Difficulty::Int32
    Flags::Int32
    TypeID::Int32
    Faction::Int32
    TextureFilename::String
    ExpansionLevel::Int32
    Order_Index::Int32
    Group_Id::Int32
    Description::LString
end

struct LightData <: DBCDataType
    ID::Int32
    ContinentID::Int32
    X::Float32
    Y::Float32
    Z::Float32
    FalloffStart::Float32
    FalloffEnd::Float32
    LightParamsID_1::Int32
    LightParamsID_2::Int32
    LightParamsID_3::Int32
    LightParamsID_4::Int32
    LightParamsID_5::Int32
    LightParamsID_6::Int32
    LightParamsID_7::Int32
    LightParamsID_8::Int32
end

struct LiquidtypeData <: DBCDataType
    ID::Int32
    Name::String
    Flags::Int32
    Type::Int32
    SoundID::Int32
    SpellID::Int32
    MaxDarkenDepth::Float32
    FogDarkenintensity::Float32
    AmbDarkenintensity::Float32
    DirDarkenintensity::Float32
    LightID::Int32
    ParticleScale::Float32
    ParticleMovement::Int32
    ParticleTexSlots::Int32
    MaterialID::Int32
    Texture_1::String
    Texture_2::String
    Texture_3::String
    Texture_4::String
    Texture_5::String
    Texture_6::String
    Color_1::Int32
    Color_2::Int32
    Float_1::Float32
    Float_2::Float32
    Float_3::Float32
    Float_4::Float32
    Float_5::Float32
    Float_6::Float32
    Float_7::Float32
    Float_8::Float32
    Float_9::Float32
    Float_10::Float32
    Float_11::Float32
    Float_12::Float32
    Float_13::Float32
    Float_14::Float32
    Float_15::Float32
    Float_16::Float32
    Float_17::Float32
    Float_18::Float32
    Int_1::Int32
    Int_2::Int32
    Int_3::Int32
    Int_4::Int32
end

struct LockData <: DBCDataType
    ID::Int32
    Type_1::Int32
    Type_2::Int32
    Type_3::Int32
    Type_4::Int32
    Type_5::Int32
    Type_6::Int32
    Type_7::Int32
    Type_8::Int32
    Index_1::Int32
    Index_2::Int32
    Index_3::Int32
    Index_4::Int32
    Index_5::Int32
    Index_6::Int32
    Index_7::Int32
    Index_8::Int32
    Skill_1::Int32
    Skill_2::Int32
    Skill_3::Int32
    Skill_4::Int32
    Skill_5::Int32
    Skill_6::Int32
    Skill_7::Int32
    Skill_8::Int32
    Action_1::Int32
    Action_2::Int32
    Action_3::Int32
    Action_4::Int32
    Action_5::Int32
    Action_6::Int32
    Action_7::Int32
    Action_8::Int32
end

struct MailtemplateData <: DBCDataType
    ID::Int32
    Subject::LString
    Body::LString
end

struct MapData <: DBCDataType
    ID::Int32
    Directory::String
    InstanceType::Int32
    Flags::Int32
    PVP::Int32
    MapName::LString
    AreaTableID::Int32
    MapDescription0::LString
    MapDescription1::LString
    LoadingScreenID::Int32
    MinimapIconScale::Float32
    CorpseMapID::Int32
    CorpseX::Float32
    CorpseY::Float32
    TimeOfDayOverride::Int32
    ExpansionID::Int32
    RaidOffset::Int32
    MaxPlayers::Int32
end

struct MapdifficultyData <: DBCDataType
    ID::Int32
    MapID::Int32
    Difficulty::Int32
    Message::LString
    RaidDuration::Int32
    MaxPlayers::Int32
    Difficultystring::String
end

struct MovieData <: DBCDataType
    ID::Int32
    Filename::String
    Volume::Int32
end

struct OverridespelldataData <: DBCDataType
    ID::Int32
    Spells_1::Int32
    Spells_2::Int32
    Spells_3::Int32
    Spells_4::Int32
    Spells_5::Int32
    Spells_6::Int32
    Spells_7::Int32
    Spells_8::Int32
    Spells_9::Int32
    Spells_10::Int32
    Flags::Int32
end

struct PowerdisplayData <: DBCDataType
    ID::Int32
    ActualType::Int32
    GlobalstringBaseTag::String
    Red::UInt32
    Green::UInt32
    Blue::UInt32
end

struct PvpdifficultyData <: DBCDataType
    ID::Int32
    MapID::Int32
    RangeIndex::Int32
    MinLevel::Int32
    MaxLevel::Int32
    Difficulty::Int32
end

struct QuestfactionrewardData <: DBCDataType
    ID::Int32
    Difficulty_1::Int32
    Difficulty_2::Int32
    Difficulty_3::Int32
    Difficulty_4::Int32
    Difficulty_5::Int32
    Difficulty_6::Int32
    Difficulty_7::Int32
    Difficulty_8::Int32
    Difficulty_9::Int32
    Difficulty_10::Int32
end

struct QuestsortData <: DBCDataType
    ID::Int32
    SortName::LString
end

struct QuestxpData <: DBCDataType
    ID::Int32
    Difficulty_1::Int32
    Difficulty_2::Int32
    Difficulty_3::Int32
    Difficulty_4::Int32
    Difficulty_5::Int32
    Difficulty_6::Int32
    Difficulty_7::Int32
    Difficulty_8::Int32
    Difficulty_9::Int32
    Difficulty_10::Int32
end

struct RandproppointsData <: DBCDataType
    ID::Int32
    Epic_1::Int32
    Epic_2::Int32
    Epic_3::Int32
    Epic_4::Int32
    Epic_5::Int32
    Superior_1::Int32
    Superior_2::Int32
    Superior_3::Int32
    Superior_4::Int32
    Superior_5::Int32
    Good_1::Int32
    Good_2::Int32
    Good_3::Int32
    Good_4::Int32
    Good_5::Int32
end

struct ScalingstatdistributionData <: DBCDataType
    ID::Int32
    StatID_1::Int32
    StatID_2::Int32
    StatID_3::Int32
    StatID_4::Int32
    StatID_5::Int32
    StatID_6::Int32
    StatID_7::Int32
    StatID_8::Int32
    StatID_9::Int32
    StatID_10::Int32
    Bonus_1::Int32
    Bonus_2::Int32
    Bonus_3::Int32
    Bonus_4::Int32
    Bonus_5::Int32
    Bonus_6::Int32
    Bonus_7::Int32
    Bonus_8::Int32
    Bonus_9::Int32
    Bonus_10::Int32
    Maxlevel::Int32
end

struct ScalingstatvaluesData <: DBCDataType
    ID::Int32
    Charlevel::Int32
    ShoulderBudget::Int32
    TrinketBudget::Int32
    WeaponBudget1H::Int32
    RangedBudget::Int32
    ClothShoulderArmor::Int32
    LeatherShoulderArmor::Int32
    MailShoulderArmor::Int32
    PlateShoulderArmor::Int32
    WeaponDPS1H::Int32
    WeaponDPS2H::Int32
    SpellcasterDPS1H::Int32
    SpellcasterDPS2H::Int32
    RangedDPS::Int32
    WandDPS::Int32
    SpellPower::Int32
    PrimaryBudget::Int32
    TertiaryBudget::Int32
    ClothCloakArmor::Int32
    ClothChestArmor::Int32
    LeatherChestArmor::Int32
    MailChestArmor::Int32
    PlateChestArmor::Int32
end

struct SkilllineData <: DBCDataType
    ID::Int32
    CategoryID::Int32
    SkillCostsID::Int32
    DisplayName::LString
    Description::LString
    SpellIconID::Int32
    AlternateVerb::LString
    CanLink::Int32
end

struct SkilllineabilityData <: DBCDataType
    ID::Int32
    SkillLine::Int32
    Spell::Int32
    RaceMask::Int32
    ClassMask::Int32
    MinSkillLineRank::Int32
    SupercededBySpell::Int32
    AcquireMethod::Int32
    TrivialSkillLineRankHigh::Int32
    TrivialSkillLineRankLow::Int32
    CharacterPoints_1::Int32
    CharacterPoints_2::Int32
    TradeSkillCategoryID::Int32
end

struct SkillraceclassinfoData <: DBCDataType
    ID::Int32
    SkillID::Int32
    RaceMask::Int32
    ClassMask::Int32
    Flags::Int32
    MinLevel::Int32
    SkillTierID::Int32
    SkillCostIndex::Int32
end

struct SkilltiersData <: DBCDataType
    ID::Int32
    Cost_1::Int32
    Cost_2::Int32
    Cost_3::Int32
    Cost_4::Int32
    Cost_5::Int32
    Cost_6::Int32
    Cost_7::Int32
    Cost_8::Int32
    Cost_9::Int32
    Cost_10::Int32
    Cost_11::Int32
    Cost_12::Int32
    Cost_13::Int32
    Cost_14::Int32
    Cost_15::Int32
    Cost_16::Int32
    Value_1::Int32
    Value_2::Int32
    Value_3::Int32
    Value_4::Int32
    Value_5::Int32
    Value_6::Int32
    Value_7::Int32
    Value_8::Int32
    Value_9::Int32
    Value_10::Int32
    Value_11::Int32
    Value_12::Int32
    Value_13::Int32
    Value_14::Int32
    Value_15::Int32
    Value_16::Int32
end

struct SoundentriesData <: DBCDataType
    ID::Int32
    SoundType::Int32
    Name::String
    File_1::String
    File_2::String
    File_3::String
    File_4::String
    File_5::String
    File_6::String
    File_7::String
    File_8::String
    File_9::String
    File_10::String
    Freq_1::Int32
    Freq_2::Int32
    Freq_3::Int32
    Freq_4::Int32
    Freq_5::Int32
    Freq_6::Int32
    Freq_7::Int32
    Freq_8::Int32
    Freq_9::Int32
    Freq_10::Int32
    DirectoryBase::String
    Volumefloat::Float32
    Flags::Int32
    MinDistance::Float32
    DistanceCutoff::Float32
    EAXDef::Int32
    SoundEntriesAdvancedID::Int32
end

struct SpellData <: DBCDataType
    ID::Int32
    Category::UInt32
    DispelType::UInt32
    Mechanic::UInt32
    Attributes::UInt32
    AttributesEx::UInt32
    AttributesEx2::UInt32
    AttributesEx3::UInt32
    AttributesEx4::UInt32
    AttributesEx5::UInt32
    AttributesEx6::UInt32
    AttributesEx7::UInt32
    ShapeshiftMask::UInt32
    unk_320_2::Int32
    ShapeshiftExclude::UInt32
    unk_320_3::Int32
    Targets::UInt32
    TargetCreatureType::UInt32
    RequiresSpellFocus::UInt32
    FacingCasterFlags::UInt32
    CasterAuraState::UInt32
    TargetAuraState::UInt32
    ExcludeCasterAuraState::UInt32
    ExcludeTargetAuraState::UInt32
    CasterAuraSpell::UInt32
    TargetAuraSpell::UInt32
    ExcludeCasterAuraSpell::UInt32
    ExcludeTargetAuraSpell::UInt32
    CastingTimeIndex::UInt32
    RecoveryTime::UInt32
    CategoryRecoveryTime::UInt32
    InterruptFlags::UInt32
    AuraInterruptFlags::UInt32
    ChannelInterruptFlags::UInt32
    ProcTypeMask::UInt32
    ProcChance::UInt32
    ProcCharges::UInt32
    MaxLevel::UInt32
    BaseLevel::UInt32
    SpellLevel::UInt32
    DurationIndex::UInt32
    PowerType::Int32
    ManaCost::UInt32
    ManaCostPerLevel::UInt32
    ManaPerSecond::UInt32
    ManaPerSecondPerLevel::UInt32
    RangeIndex::UInt32
    Speed::Float32
    ModalNextSpell::UInt32
    CumulativeAura::UInt32
    Totem_1::UInt32
    Totem_2::UInt32
    Reagent_1::Int32
    Reagent_2::Int32
    Reagent_3::Int32
    Reagent_4::Int32
    Reagent_5::Int32
    Reagent_6::Int32
    Reagent_7::Int32
    Reagent_8::Int32
    ReagentCount_1::Int32
    ReagentCount_2::Int32
    ReagentCount_3::Int32
    ReagentCount_4::Int32
    ReagentCount_5::Int32
    ReagentCount_6::Int32
    ReagentCount_7::Int32
    ReagentCount_8::Int32
    EquippedItemClass::Int32
    EquippedItemSubclass::Int32
    EquippedItemInvTypes::Int32
    Effect_1::UInt32
    Effect_2::UInt32
    Effect_3::UInt32
    EffectDieSides_1::Int32
    EffectDieSides_2::Int32
    EffectDieSides_3::Int32
    EffectRealPointsPerLevel_1::Float32
    EffectRealPointsPerLevel_2::Float32
    EffectRealPointsPerLevel_3::Float32
    EffectBasePoints_1::Int32
    EffectBasePoints_2::Int32
    EffectBasePoints_3::Int32
    EffectMechanic_1::UInt32
    EffectMechanic_2::UInt32
    EffectMechanic_3::UInt32
    ImplicitTargetA_1::UInt32
    ImplicitTargetA_2::UInt32
    ImplicitTargetA_3::UInt32
    ImplicitTargetB_1::UInt32
    ImplicitTargetB_2::UInt32
    ImplicitTargetB_3::UInt32
    EffectRadiusIndex_1::UInt32
    EffectRadiusIndex_2::UInt32
    EffectRadiusIndex_3::UInt32
    EffectAura_1::UInt32
    EffectAura_2::UInt32
    EffectAura_3::UInt32
    EffectAuraPeriod_1::UInt32
    EffectAuraPeriod_2::UInt32
    EffectAuraPeriod_3::UInt32
    EffectMultipleValue_1::Float32
    EffectMultipleValue_2::Float32
    EffectMultipleValue_3::Float32
    EffectChainTargets_1::UInt32
    EffectChainTargets_2::UInt32
    EffectChainTargets_3::UInt32
    EffectItemType_1::UInt32
    EffectItemType_2::UInt32
    EffectItemType_3::UInt32
    EffectMiscValue_1::Int32
    EffectMiscValue_2::Int32
    EffectMiscValue_3::Int32
    EffectMiscValueB_1::Int32
    EffectMiscValueB_2::Int32
    EffectMiscValueB_3::Int32
    EffectTriggerSpell_1::UInt32
    EffectTriggerSpell_2::UInt32
    EffectTriggerSpell_3::UInt32
    EffectPointsPerCombo_1::Float32
    EffectPointsPerCombo_2::Float32
    EffectPointsPerCombo_3::Float32
    EffectSpellClassMaskA_1::UInt32
    EffectSpellClassMaskA_2::UInt32
    EffectSpellClassMaskA_3::UInt32
    EffectSpellClassMaskB_1::UInt32
    EffectSpellClassMaskB_2::UInt32
    EffectSpellClassMaskB_3::UInt32
    EffectSpellClassMaskC_1::UInt32
    EffectSpellClassMaskC_2::UInt32
    EffectSpellClassMaskC_3::UInt32
    SpellVisualID_1::UInt32
    SpellVisualID_2::UInt32
    SpellIconID::UInt32
    ActiveIconID::UInt32
    SpellPriority::UInt32
    Name::LString
    NameSubtext::LString
    Description::LString
    AuraDescription::LString
    ManaCostPct::UInt32
    StartRecoveryCategory::UInt32
    StartRecoveryTime::UInt32
    MaxTargetLevel::UInt32
    SpellClassSet::UInt32
    SpellClassMask_1::UInt32
    SpellClassMask_2::UInt32
    SpellClassMask_3::UInt32
    MaxTargets::UInt32
    DefenseType::UInt32
    PreventionType::UInt32
    StanceBarOrder::UInt32
    EffectChainAmplitude_1::Float32
    EffectChainAmplitude_2::Float32
    EffectChainAmplitude_3::Float32
    MinFactionID::UInt32
    MinReputation::UInt32
    RequiredAuraVision::UInt32
    RequiredTotemCategoryID_1::UInt32
    RequiredTotemCategoryID_2::UInt32
    RequiredAreasID::Int32
    SchoolMask::UInt32
    RuneCostID::UInt32
    SpellMissileID::UInt32
    PowerDisplayID::Int32
    EffectBonusMultiplier_1::Float32
    EffectBonusMultiplier_2::Float32
    EffectBonusMultiplier_3::Float32
    SpellDescriptionVariableID::UInt32
    SpellDifficultyID::UInt32
end

struct SpellcasttimesData <: DBCDataType
    ID::Int32
    Base::Int32
    PerLevel::Int32
    Minimum::Int32
end

struct SpellcategoryData <: DBCDataType
    ID::Int32
    Flags::Int32
end

struct SpelldifficultyData <: DBCDataType
    ID::Int32
    DifficultySpellID_1::Int32
    DifficultySpellID_2::Int32
    DifficultySpellID_3::Int32
    DifficultySpellID_4::UInt32
end

struct SpelldurationData <: DBCDataType
    ID::Int32
    Duration::Int32
    DurationPerLevel::Int32
    MaxDuration::Int32
end

struct SpellfocusobjectData <: DBCDataType
    ID::Int32
    Name::LString
end

struct SpellitemenchantmentData <: DBCDataType
    ID::Int32
    Charges::Int32
    Effect_1::Int32
    Effect_2::Int32
    Effect_3::Int32
    EffectPointsMin_1::Int32
    EffectPointsMin_2::Int32
    EffectPointsMin_3::Int32
    EffectPointsMax_1::Int32
    EffectPointsMax_2::Int32
    EffectPointsMax_3::Int32
    EffectArg_1::Int32
    EffectArg_2::Int32
    EffectArg_3::Int32
    Name::LString
    ItemVisual::Int32
    Flags::Int32
    Src_ItemID::Int32
    Condition_Id::Int32
    RequiredSkillID::Int32
    RequiredSkillRank::Int32
    MinLevel::Int32
end

struct SpellitemenchantmentconditionData <: DBCDataType
    ID::Int32
    Lt_OperandType_1::UInt32
    Lt_OperandType_2::UInt32
    Lt_OperandType_3::UInt32
    Lt_OperandType_4::UInt32
    Lt_OperandType_5::UInt32
    Lt_Operand_1::Int32
    Lt_Operand_2::Int32
    Lt_Operand_3::Int32
    Lt_Operand_4::Int32
    Lt_Operand_5::Int32
    Operator_1::UInt32
    Operator_2::UInt32
    Operator_3::UInt32
    Operator_4::UInt32
    Operator_5::UInt32
    Rt_OperandType_1::UInt32
    Rt_OperandType_2::UInt32
    Rt_OperandType_3::UInt32
    Rt_OperandType_4::UInt32
    Rt_OperandType_5::UInt32
    Rt_Operand_1::Int32
    Rt_Operand_2::Int32
    Rt_Operand_3::Int32
    Rt_Operand_4::Int32
    Rt_Operand_5::Int32
    Logic_1::UInt32
    Logic_2::UInt32
    Logic_3::UInt32
    Logic_4::UInt32
    Logic_5::UInt32
end

struct SpellradiusData <: DBCDataType
    ID::Int32
    Radius::Float32
    RadiusPerLevel::Float32
    RadiusMax::Float32
end

struct SpellrangeData <: DBCDataType
    ID::Int32
    RangeMin_1::Float32
    RangeMin_2::Float32
    RangeMax_1::Float32
    RangeMax_2::Float32
    Flags::Int32
    DisplayName::LString
    DisplayNameShort::LString
end

struct SpellrunecostData <: DBCDataType
    ID::Int32
    Blood::Int32
    Unholy::Int32
    Frost::Int32
    RunicPower::Int32
end

struct SpellshapeshiftformData <: DBCDataType
    ID::Int32
    BonusActionBar::Int32
    Name::LString
    Flags::Int32
    CreatureType::Int32
    AttackIconID::Int32
    CombatRoundTime::Int32
    CreatureDisplayID_1::Int32
    CreatureDisplayID_2::Int32
    CreatureDisplayID_3::Int32
    CreatureDisplayID_4::Int32
    PresetSpellID_1::Int32
    PresetSpellID_2::Int32
    PresetSpellID_3::Int32
    PresetSpellID_4::Int32
    PresetSpellID_5::Int32
    PresetSpellID_6::Int32
    PresetSpellID_7::Int32
    PresetSpellID_8::Int32
end

struct StableslotpricesData <: DBCDataType
    ID::Int32
    Cost::Int32
end

struct SummonpropertiesData <: DBCDataType
    ID::Int32
    Control::Int32
    Faction::Int32
    Title::Int32
    Slot::Int32
    Flags::Int32
end

struct TalentData <: DBCDataType
    ID::Int32
    TabID::Int32
    TierID::Int32
    ColumnIndex::Int32
    SpellRank_1::Int32
    SpellRank_2::Int32
    SpellRank_3::Int32
    SpellRank_4::Int32
    SpellRank_5::Int32
    SpellRank_6::Int32
    SpellRank_7::Int32
    SpellRank_8::Int32
    SpellRank_9::Int32
    PrereqTalent_1::Int32
    PrereqTalent_2::Int32
    PrereqTalent_3::Int32
    PrereqRank_1::Int32
    PrereqRank_2::Int32
    PrereqRank_3::Int32
    Flags::Int32
    RequiredSpellID::Int32
    CategoryMask_1::Int32
    CategoryMask_2::Int32
end

struct TalenttabData <: DBCDataType
    ID::Int32
    Name::LString
    SpellIconID::Int32
    RaceMask::Int32
    ClassMask::Int32
    PetTalentMask::Int32
    OrderIndex::Int32
    BackgroundFile::String
end

struct TaxinodesData <: DBCDataType
    ID::Int32
    ContinentID::Int32
    X::Float32
    Y::Float32
    Z::Float32
    Name::LString
    MountCreatureID_1::Int32
    MountCreatureID_2::Int32
end

struct TaxipathData <: DBCDataType
    ID::Int32
    FromTaxiNode::Int32
    ToTaxiNode::Int32
    Cost::Int32
end

struct TaxipathnodeData <: DBCDataType
    ID::Int32
    PathID::Int32
    NodeIndex::Int32
    ContinentID::Int32
    LocX::Float32
    LocY::Float32
    LocZ::Float32
    Flags::Int32
    Delay::Int32
    ArrivalEventID::Int32
    DepartureEventID::Int32
end

struct TeamcontributionpointsData <: DBCDataType
    ID::Int32
    Data::Float32
end

struct TotemcategoryData <: DBCDataType
    ID::Int32
    Name::LString
    TotemCategoryType::Int32
    TotemCategoryMask::Int32
end

struct TransportanimationData <: DBCDataType
    ID::Int32
    TransportID::Int32
    TimeIndex::Int32
    PosX::Float32
    PosY::Float32
    PosZ::Float32
    SequenceID::Int32
end

struct TransportrotationData <: DBCDataType
    ID::Int32
    GameObjectsID::Int32
    TimeIndex::Int32
    RotX::Float32
    RotY::Float32
    RotZ::Float32
    RotW::Float32
end

struct VehicleData <: DBCDataType
    ID::Int32
    Flags::Int32
    TurnSpeed::Float32
    PitchSpeed::Float32
    PitchMin::Float32
    PitchMax::Float32
    SeatID_1::Int32
    SeatID_2::Int32
    SeatID_3::Int32
    SeatID_4::Int32
    SeatID_5::Int32
    SeatID_6::Int32
    SeatID_7::Int32
    SeatID_8::Int32
    MouseLookOffsetPitch::Float32
    CameraFadeDistScalarMin::Float32
    CameraFadeDistScalarMax::Float32
    CameraPitchOffset::Float32
    FacingLimitRight::Float32
    FacingLimitLeft::Float32
    MsslTrgtTurnLingering::Float32
    MsslTrgtPitchLingering::Float32
    MsslTrgtMouseLingering::Float32
    MsslTrgtEndOpacity::Float32
    MsslTrgtArcSpeed::Float32
    MsslTrgtArcRepeat::Float32
    MsslTrgtArcWidth::Float32
    MsslTrgtImpactRadius_1::Float32
    MsslTrgtImpactRadius_2::Float32
    MsslTrgtArcTexture::String
    MsslTrgtImpactTexture::String
    MsslTrgtImpactModel_1::String
    MsslTrgtImpactModel_2::String
    CameraYawOffset::Float32
    UilocomotionType::Int32
    MsslTrgtImpactTexRadius::Float32
    VehicleUIIndicatorID::Int32
    PowerDisplayID_1::Int32
    PowerDisplayID_2::Int32
    PowerDisplayID_3::Int32
end

struct VehicleseatData <: DBCDataType
    ID::Int32
    Flags::Int32
    AttachmentID::Int32
    AttachmentOffsetX::Float32
    AttachmentOffsetY::Float32
    AttachmentOffsetZ::Float32
    EnterPreDelay::Float32
    EnterSpeed::Float32
    EnterGravity::Float32
    EnterMinDuration::Float32
    EnterMaxDuration::Float32
    EnterMinArcHeight::Float32
    EnterMaxArcHeight::Float32
    EnterAnimStart::Int32
    EnterAnimLoop::Int32
    RideAnimStart::Int32
    RideAnimLoop::Int32
    RideUpperAnimStart::Int32
    RideUpperAnimLoop::Int32
    ExitPreDelay::Float32
    ExitSpeed::Float32
    ExitGravity::Float32
    ExitMinDuration::Float32
    ExitMaxDuration::Float32
    ExitMinArcHeight::Float32
    ExitMaxArcHeight::Float32
    ExitAnimStart::Int32
    ExitAnimLoop::Int32
    ExitAnimEnd::Int32
    PassengerYaw::Float32
    PassengerPitch::Float32
    PassengerRoll::Float32
    PassengerAttachmentID::Int32
    VehicleEnterAnim::Int32
    VehicleExitAnim::Int32
    VehicleRideAnimLoop::Int32
    VehicleEnterAnimBone::Int32
    VehicleExitAnimBone::Int32
    VehicleRideAnimLoopBone::Int32
    VehicleEnterAnimDelay::Float32
    VehicleExitAnimDelay::Float32
    VehicleAbilityDisplay::Int32
    EnterUISoundID::Int32
    ExitUISoundID::Int32
    UiSkin::Int32
    FlagsB::Int32
    CameraEnteringDelay::Float32
    CameraEnteringDuration::Float32
    CameraExitingDelay::Float32
    CameraExitingDuration::Float32
    CameraOffsetX::Float32
    CameraOffsetY::Float32
    CameraOffsetZ::Float32
    CameraPosChaseRate::Float32
    CameraFacingChaseRate::Float32
    CameraEnteringZoom::Float32
    CameraSeatZoomMin::Float32
    CameraSeatZoomMax::Float32
end

struct WmoareatableData <: DBCDataType
    ID::Int32
    WMOID::Int32
    NameSetID::Int32
    WMOGroupID::Int32
    SoundProviderPref::Int32
    SoundProviderPrefUnderwater::Int32
    AmbienceID::Int32
    ZoneMusic::Int32
    IntroSound::Int32
    Flags::Int32
    AreaTableID::Int32
    AreaName::LString
end

struct WorldmapareaData <: DBCDataType
    ID::Int32
    MapID::Int32
    AreaID::Int32
    AreaName::String
    LocLeft::Float32
    LocRight::Float32
    LocTop::Float32
    LocBottom::Float32
    DisplayMapID::Int32
    DefaultDungeonFloor::Int32
    ParentWorldMapID::Int32
end

struct WorldmapoverlayData <: DBCDataType
    ID::Int32
    MapAreaID::Int32
    AreaID_1::Int32
    AreaID_2::Int32
    AreaID_3::Int32
    AreaID_4::Int32
    MapPointX::Int32
    MapPointY::Int32
    TextureName::String
    TextureWidth::Int32
    TextureHeight::Int32
    OffsetX::Int32
    OffsetY::Int32
    HitRectTop::Int32
    HitRectLeft::Int32
    HitRectBottom::Int32
    HitRectRight::Int32
end


export AchievementData, Achievement_categoryData, Achievement_criteriaData, AreagroupData, AreapoiData, AreatableData, AuctionhouseData, BankbagslotpricesData, BarbershopstyleData, BattlemasterlistData, CharbaseinfoData, CharstartoutfitData, ChartitlesData, ChatchannelsData, ChrclassesData, ChrracesData, CinematiccameraData, CinematicsequencesData, CreaturedisplayinfoData, CreaturedisplayinfoextraData, CreaturefamilyData, CreaturemodeldataData, CreaturespelldataData, CreaturetypeData, CurrencytypesData, DestructiblemodeldataData, DungeonencounterData, DurabilitycostsData, DurabilityqualityData, EmotesData, EmotestextData, FactionData, FactiontemplateData, GameobjectdisplayinfoData, GempropertiesData, GlyphpropertiesData, GlyphslotData, GtbarbershopcostbaseData, GtchancetomeleecritData, GtchancetomeleecritbaseData, GtchancetospellcritData, GtchancetospellcritbaseData, GtcombatratingsData, GtnpcmanacostscalerData, GtoctclasscombatratingscalarData, GtoctregenhpData, GtregenhppersptData, GtregenmppersptData, HolidaysData, ItemData, ItembagfamilyData, ItemdisplayinfoData, ItemextendedcostData, ItemlimitcategoryData, ItemrandompropertiesData, ItemrandomsuffixData, ItemsetData, LfgdungeonsData, LightData, LiquidtypeData, LockData, MailtemplateData, MapData, MapdifficultyData, MovieData, OverridespelldataData, PowerdisplayData, PvpdifficultyData, QuestfactionrewardData, QuestsortData, QuestxpData, RandproppointsData, ScalingstatdistributionData, ScalingstatvaluesData, SkilllineData, SkilllineabilityData, SkillraceclassinfoData, SkilltiersData, SoundentriesData, SpellData, SpellcasttimesData, SpellcategoryData, SpelldifficultyData, SpelldurationData, SpellfocusobjectData, SpellitemenchantmentData, SpellitemenchantmentconditionData, SpellradiusData, SpellrangeData, SpellrunecostData, SpellshapeshiftformData, StableslotpricesData, SummonpropertiesData, TalentData, TalenttabData, TaxinodesData, TaxipathData, TaxipathnodeData, TeamcontributionpointsData, TotemcategoryData, TransportanimationData, TransportrotationData, VehicleData, VehicleseatData, WmoareatableData, WorldmapareaData, WorldmapoverlayData
