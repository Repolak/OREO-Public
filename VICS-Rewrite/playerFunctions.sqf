_missionName = missionName;
missionPrefix = (_missionName + "_");

// When player connects, add addactions if vem enabled
// Note: not in a function
//waitUntil {scriptDone vicsConfigComplete};
//waituntil {!isnil "bis_fnc_init"};

// Now run addaction if vem is enabled
/*
if (vemEnabled isEqualTo true) then {
  call vem_intel_addActions;
};
*/


vics_ply_setLoadout = {
  params ["_loadoutName"];
  _prospect = [[],[],[],["tfl_new_RG_fs_uniform",[]],["Crye_AVS_CB_1",[]],["TFL_avs_pack_cb",[]],"","tfl_m_frame_blackclear",["ACE_Vector","","","",[],[],""],["ItemMap","ItemGPS","TFAR_anprc152","ItemCompass","ACE_Altimeter",""]];
  _junior = [[],[],[],["tfl_new_MC_fs_uniform",[]],["Crye_AVS_CB_1",[]],["TFL_avs_pack_cb",[]],"","tfl_m_frame_blackclear",["ACE_Vector","","","",[],[],""],["ItemMap","ItemGPS","TFAR_anprc152","ItemCompass","ACE_Altimeter",""]];
  _senior = [[],[],[],["tfl_new_CBMC_fs_uniform",[]],["Crye_AVS_CB_1",[]],["TFL_avs_pack_cb",[]],"","tfl_m_frame_blackclear",["ACE_Vector","","","",[],[],""],["ItemMap","ItemGPS","TFAR_anprc152","ItemCompass","ACE_Altimeter",""]];
  _greenTeam = [[],[],[],["tfl_new_RGMC_fs_uniform",[]],["Crye_AVS_CB_1",[]],["TFL_avs_pack_cb",[]],"","tfl_m_frame_blackclear",["ACE_Vector","","","",[],[],""],["ItemMap","ItemGPS","TFAR_anprc152","ItemCompass","ACE_Altimeter",""]];

  _repoLoadout = [["rhs_weap_mk18_KAC_bk","","rhsusf_acc_anpeq15_bk_top","rhsusf_acc_su230",["Tier1_30Rnd_556x45_Mk318Mod0_EMag",30],[],"rhsusf_acc_rvg_blk"],[],[],["tfl_new_M81_fs_uniform_g",[["ACE_MapTools",1],["ACE_tourniquet",4],["ACE_fieldDressing",10],["ACE_CableTie",2],["ACE_splint",4],["ACE_EarPlugs",1],["ACE_epinephrine",2],["ACE_morphine",2],["ACE_adenosine",2],["kat_larynx",2],["kat_Pulseoximeter",2],["kat_chestSeal",2],["ACE_WaterBottle",2],["kat_aatKit",1],["ACE_Flashlight_XL50",1],["ACE_MRE_BeefStew",1],["Tier1_30Rnd_556x45_Mk318Mod0_EMag",1,30]]],["Crye_AVS_RG_Comms_3_NC_NoBelt",[["ACE_fieldDressing",10],["ACE_M84",2,1],["SmokeShell",2,1],["HandGrenade",2,1],["Tier1_30Rnd_556x45_Mk318Mod0_EMag",5,30]]],["VSM_OGA_OD_carryall",[["ACE_fieldDressing",10],["ACE_salineIV",2],["ACE_salineIV_500",2],["ACE_salineIV_250",2],["kat_accuvac",1],["kat_AED",1],["Tier1_SOCOM556_Black",1],["Louetta_G24_1",1],["Maritime_Cover_ComtacIII18322_manta",1],["SmokeShell",2,1],["SmokeShellRed",2,1],["SmokeShellPurple",2,1]]],"tfl_beanie_hat_green_peltors","shemagh_od",["ACE_Vector","","","",[],[],""],["ItemMap","ItemGPS","TFAR_anprc152","ItemCompass","ACE_Altimeter",""]];

  _cartwrightLoadout = [["rhs_weap_mk18_KAC_bk","","Tier1_Mk18_LA5_M603V","rhsusf_acc_su230",["Tier1_30Rnd_556x45_Mk318Mod0_EMag",30],[],""],[],[],["tfl_new_M81_fs_uniform",[["ACE_MapTools",1],["ACE_tourniquet",6],["ACE_fieldDressing",10],["ACE_CableTie",2],["ACE_splint",4],["ACE_EarPlugs",1],["ACE_epinephrine",2],["ACE_morphine",2],["ACE_adenosine",2],["kat_larynx",2],["kat_Pulseoximeter",2],["kat_chestSeal",2],["ACE_WaterBottle",2],["kat_aatKit",1],["ACE_Flashlight_XL50",1],["ACE_MRE_BeefStew",1]]],["Crye_AVS_RG_4",[["ACE_fieldDressing",10],["ACE_M84",2,1],["SmokeShell",2,1],["HandGrenade",2,1],["Tier1_30Rnd_556x45_Mk318Mod0_EMag",4,30]]],["fatpack_od",[["ACE_fieldDressing",10],["ACE_salineIV",2],["ACE_surgicalKit",1],["ACE_salineIV_500",2],["ACE_salineIV_250",2],["kat_accuvac",1],["kat_AED",1],["Tier1_SOCOM556_2_Black",1],["SmokeShell",2,1],["SmokeShellRed",2,1],["SmokeShellPurple",2,1],["Tier1_30Rnd_556x45_Mk318Mod0_EMag",2,30]]],"Maritime_Cover_ComtacIII6","tfl_m_frame_blackshaded",["ACE_Vector","","","",[],[],""],["ItemMap","ItemGPS","TFAR_anprc152","ItemCompass","ACE_Altimeter","Louetta_G24_1"]];

  _flapLoadout = [["rhs_weap_mk18_KAC_bk","","Tier1_Mk18_LA5_M603V","rhsusf_acc_su230",["Tier1_30Rnd_556x45_Mk318Mod0_EMag",30],[],""],[],[],["tfl_new_M81_fs_uniform",[["ACE_MapTools",1],["ACE_tourniquet",6],["ACE_fieldDressing",10],["ACE_CableTie",2],["ACE_splint",4],["ACE_EarPlugs",1],["ACE_epinephrine",2],["ACE_morphine",2],["ACE_adenosine",2],["kat_larynx",2],["kat_Pulseoximeter",2],["kat_chestSeal",2],["ACE_WaterBottle",2],["kat_aatKit",1],["ACE_Flashlight_XL50",1],["ACE_MRE_BeefStew",1]]],["Crye_AVS_RG_4",[["ACE_fieldDressing",10],["ACE_M84",2,1],["SmokeShell",2,1],["HandGrenade",2,1],["Tier1_30Rnd_556x45_Mk318Mod0_EMag",4,30]]],["fatpack_od",[["ACE_fieldDressing",20],["ACE_salineIV",3],["ACE_surgicalKit",1],["ACE_salineIV_500",3],["ACE_salineIV_250",3],["kat_accuvac",1],["kat_AED",1],["Tier1_SOCOM556_2_Black",1],["ACE_tourniquet",2],["ACE_morphine",2],["ACE_epinephrine",2],["kat_Pulseoximeter",4],["ACE_adenosine",2],["kat_aatKit",2],["ACE_quikclot",10],["kat_chestSeal",2],["KAT_Empty_bloodIV_500",1],["KAT_Empty_bloodIV_250",2],["kat_larynx",5],["SmokeShell",2,1],["SmokeShellRed",2,1],["SmokeShellPurple",2,1],["Tier1_30Rnd_556x45_Mk318Mod0_EMag",2,30]]],"Maritime_Cover_ComtacIII6","tfl_m_frame_blackshaded",["ACE_Vector","","","",[],[],""],["ItemMap","ItemGPS","TFAR_anprc152","ItemCompass","ACE_Altimeter","Louetta_G24_1"]];

  _leviLoadout = [["Tier1_HK416D145_MW13_CTR","","Tier1_MW_LA5_M600V_alt_Black","rhsusf_acc_su230",["Tier1_30Rnd_556x45_Mk318Mod0_EMag",30],[],""],[],[],["tfl_new_M81_fs_uniform",[["ACE_MapTools",1],["ACE_tourniquet",6],["ACE_fieldDressing",10],["ACE_CableTie",2],["ACE_splint",4],["ACE_EarPlugs",1],["ACE_epinephrine",2],["ACE_morphine",2],["ACE_adenosine",2],["kat_larynx",2],["kat_Pulseoximeter",2],["kat_chestSeal",2],["ACE_WaterBottle",2],["kat_aatKit",1],["ACE_Flashlight_XL50",1],["ACE_MRE_BeefStew",1],["Tier1_30Rnd_556x45_Mk318Mod0_EMag",1,30]]],["Crye_AVS_RG_4",[["ACE_fieldDressing",10],["ACE_M84",2,1],["SmokeShell",2,1],["HandGrenade",2,1],["Tier1_30Rnd_556x45_Mk318Mod0_EMag",5,30]]],["fatpack_od",[["ACE_fieldDressing",10],["ACE_salineIV",2],["ACE_surgicalKit",1],["ACE_salineIV_500",2],["ACE_salineIV_250",2],["kat_accuvac",1],["kat_AED",1],["Tier1_SOCOM556_2_Black",1],["SmokeShell",2,1],["SmokeShellRed",2,1],["SmokeShellPurple",2,1]]],"Maritime_Cover_ComtacIII6","tfl_m_frame_blackshaded",["ACE_Vector","","","",[],[],""],["ItemMap","ItemGPS","TFAR_anprc152","ItemCompass","ACE_Altimeter","Louetta_G24_1"]];

  _carterLoadout = [["Tier1_M110k5_ACS_65mm_grip3","Tier1_KAC_762_QDC_Black","Tier1_URX4_LA5_Side","Tier1_Razor_Gen3_110_Geissele_Docter",["Tier1_20Rnd_65x48_Creedmoor_SR25_Mag",20],[],"Tier1_Harris_Bipod_DD_MLOK_Black"],[],["rhsusf_weap_glock17g4","","","",["Tier1_15Rnd_9x19_JHP",15],[],""],["tfl_new_M81_fs_uniform_g",[["ACE_tourniquet",4],["ACE_fieldDressing",10],["ACE_CableTie",4],["ACE_splint",4],["ACE_EarPlugs",2],["ACE_epinephrine",3],["ACE_morphine",3],["ACE_adenosine",3],["kat_Pulseoximeter",4],["kat_chestSeal",2],["ACE_WaterBottle",1],["kat_aatKit",1],["ACE_Flashlight_XL50",1],["kat_larynx",4],["ACE_Clacker",1],["ACE_MRE_BeefStew",1],["ACE_DefusalKit",1],["ACE_MapTools",1],["ACE_IR_Strobe_Item",2],["ACE_RangeCard",1],["Tier1_20Rnd_9x19_JHP",1,20],["Tier1_20Rnd_65x48_Creedmoor_SR25_Mag",1,20]]],["Crye_AVSMK11_RG_TeamLeader_1",[["ACE_fieldDressing",15],["kat_aatKit",2],["kat_chestSeal",4],["kat_larynx",6],["kat_Pulseoximeter",2],["ACE_salineIV",1],["ACE_salineIV_250",1],["ACE_salineIV_500",1],["kat_stethoscope",1],["ACE_M84",2,1],["SmokeShell",2,1],["HandGrenade",2,1],["Tier1_20Rnd_65x48_Creedmoor_SR25_Mag",3,20]]],["VSM_OGA_OD_carryall",[["ACE_fieldDressing",15],["ACE_salineIV",2],["ACE_salineIV_500",2],["ACE_salineIV_250",2],["kat_accuvac",1],["kat_AED",1],["Maritime_Cover_ComtacIII6",1],["ACE_surgicalKit",1],["ACE_tourniquet",6],["ACE_MRE_BeefStew",1],["ACE_WaterBottle",1],["rhsusf_acc_su230a_c",1],["Louetta_G24_1",1],["SmokeShell",2,1],["SmokeShellRed",2,1],["SmokeShellPurple",1,1],["Tier1_20Rnd_65x48_Creedmoor_SR25_Mag",5,20],[["Nikon_DSLR_HUD","","","",[],[],""],1]]],"tfa_booniehat_rngrn","tfl_m_frame_tanshaded",["Laserdesignator","","","",[],[],""],["ItemMap","ItemGPS","TFAR_anprc152","ItemCompass","ACE_Altimeter",""]];

  _whitlockLoadout = [["rhs_weap_m16a4","","rhsusf_acc_anpeq15side_bk","rhsusf_acc_su230",["Tier1_30Rnd_556x45_Mk318Mod0_EMag",30],[],"rhsusf_acc_harris_bipod"],[],["rhsusf_weap_glock17g4","","","",["rhsusf_mag_17Rnd_9x19_JHP",17],[],""],["tfl_new_M81_fs_uniform",[["ACE_MapTools",1],["ACE_tourniquet",4],["ACE_fieldDressing",10],["ACE_CableTie",2],["ACE_splint",4],["ACE_EarPlugs",1],["ACE_epinephrine",2],["ACE_morphine",2],["ACE_adenosine",2],["kat_larynx",2],["kat_Pulseoximeter",2],["kat_chestSeal",2],["ACE_WaterBottle",2],["kat_aatKit",1],["ACE_Flashlight_XL50",1],["ACE_MRE_BeefStew",1],["rhsusf_mag_17Rnd_9x19_JHP",1,17]]],["Crye_AVS_RG_TeamLeader_1",[["ACE_fieldDressing",10],["ACE_M84",2,1],["SmokeShell",2,1],["HandGrenade",2,1]]],["VSM_OGA_OD_carryall",[["ACE_fieldDressing",10],["ACE_salineIV",2],["ACE_salineIV_500",2],["ACE_salineIV_250",2],["kat_accuvac",1],["kat_AED",1],["Tier1_SOCOM556_Black",1],["tfa_booniehat_m81",1],["SmokeShell",2,1],["SmokeShellRed",2,1],["SmokeShellPurple",2,1],[["Nikon_DSLR_HUD","","","",[],[],""],1]]],"Maritime_Cover_ComtacIII6","tfl_m_frame_blackclear",["Laserdesignator","","","",[],[],""],["ItemMap","ItemGPS","TFAR_anprc152","ItemCompass","ACE_Altimeter","Louetta_G24_1"]];

  _playerLoadouts = [_riflemenLoadout,_arLoadout,_breacherLoadout,_dmLoadout,_grenLoadout,_medicLoadout,_sectionLeadLoadout,_LATLoadout,_repoLoadout,_cartwrightLoadout,_flapLoadout,_leviLoadout,_carterLoadout,_whitlockLoadout];
  switch (_loadoutName) do {
    case "Base": {_loadout = _baseLoadout};
    case "prospect": {_loadout = _prospect};
    case "junior": {_loadout = _junior};
    case "senior": {_loadout = _senior};
    case "greenTeam": {_loadout = _greenTeam};
  };
  player setUnitLoadout _loadout;
};

vics_ply_persist = {
 _loadoutName = (missionPrefix + "ply_loadout");
 _unitLoadout = getUnitLoadout [player,false];
 _unitPos = getPosATL Player;
 _unitDir = getDir Player;
 _unitStance = stance Player;
 _unitEarplugs = [player] call ace_hearing_fnc_hasEarPlugsIn;
 _thirst = player getVariable "acex_field_rations_thirst";
 _hunger = player getVariable "acex_field_rations_hunger";
 //_playerInjuries = [player] call ace_medical_fnc_serializeState;
 _playerData = [_unitPos,_unitDir,_unitStance,_unitEarplugs,_thirst,_hunger,_unitLoadout,[]];
 //diag_log format ["Injuries Saved: %1",_playerInjuries];
 //systemChat str _playerInjuries;
 profileNameSpace setVariable [(missionPrefix + "ply_Data"),_playerData];
 _credits = [player] call HALs_money_fnc_getFunds;
 profileNameSpace setVariable ["opCredits",_credits];
 //call vics_ply_saveStatistics;
 saveProfileNameSpace;
 true;
};

vics_ply_load = {
  [] call vics_ply_loadOpCredits;
  _playerData = profileNameSpace getVariable (missionPrefix + "ply_Data");
  if (isNil "_playerData") exitWith {};
  _unitLoadout = _playerData select 6;
  player setUnitLoadout [(_playerData select 6),false];
  player SetPosATL (_playerData select 0);
  player SetDir (_playerData select 1);
  switch (_playerData select 2) do
  {
    case "STAND": {player playActionNow "PlayerStand"};
    case "CROUCH": {player playActionNow "PlayerCrouch"};
    case "PRONE": {player playActionNow "PlayerProne"};
    default {player playActionNow "PlayerStand"};
  };
  _playerEarplugs = (_playerData select 3);
  if (isNil "_playerEarplugs") then {
  } else {
    if (_playerEarplugs isEqualTo true) then {
      player addItem "ACE_EarPlugs";
      [player] call ace_hearing_fnc_putInEarplugs;
    };
  };
  _playerThirst = _playerData select 4;
  _playerHunger = _playerData select 5;
  player setVariable ["acex_field_rations_thirst",_playerThirst];
  player setVariable ["acex_field_rations_hunger",_playerHunger];
  _playerInjuries = _playerData select 7;
//  if !(isNil "_playerInjuries") then {
    //[player, _playerInjuries] call ace_medical_fnc_deserializeState;
  //};
  //diag_log format ["Injuries Loaded: %1",_playerInjuries];
};

vics_ply_playerExit = {
  [] spawn {
    _playerPersist = [] call vics_ply_persist;
    waitUntil {_playerPersist isEqualTo true};
    "end1" call BIS_fnc_endMission;
  };
};

vics_ply_getOpCredits = {
  _money = [player] call HALs_money_fnc_getFunds;
};

vics_ply_loadOpCredits = {
  _creditsSaved = profileNameSpace getVariable "opCredits";
  if (isNil "_creditsSaved") then {
    _creditsSaved = 10;
  };
  _creditsSaved;
  _money = [player] call HALs_money_fnc_getFunds;
  _creditsNew = (_money - _money) + _creditsSaved;
  [player, _creditsNew] call HALs_money_fnc_addFunds;
};

vics_ply_resetCredits = {
  _creditsNew = (_money - _money);
  [player, _creditsNew] call HALs_money_fnc_addFunds;
  profileNameSpace setVariable ["opCredits",nil];
};

vics_ply_saveCredits = {
  _money = [player] call HALs_money_fnc_getFunds;
  profileNameSpace setVariable ["opCredits",_money];
};

vics_ply_compressBackpack = {
  if ((count backpackItems player) isEqualTo 0) then {
    _backpack = backpack player;
    if !(_backpack isEqualTo "") then {
      player setVariable ["compressedBackpack",_backpack];
      removeBackpack player;
    } else {
      systemChat "No backpack equipped";
    };
  } else {
    systemChat "Backpack not empty";
  };
};

vics_ply_decompressBackpack = {
  _backpack = Backpack player;
  if (_backpack isEqualTo "") then {
    _compressedBackpack = player getVariable "compressedBackpack";
    if (!isNil "_compressedBackpack") then {
      player addBackpack _compressedBackpack;
      player setVariable ["compressedBackpack",nil];
    } else {
      systemChat "No compressed backpack";
    };
  } else {
    systemChat "Already have a backpack on";
  };
};

vics_fnc_mask = {
  [] spawn {
    player playMove "Acts_listeningToRadio_In";
    uiSleep 0.85;
    _goggles = (goggles player);
    //hint format ["%1",_goggles];
    if (_goggles isEqualTo "shemaghface_od") then {
      removeGoggles player;
      player addGoggles "shemagh_looseod";
    };
    if (_goggles isEqualTo "shemagh_looseod") then {
      removeGoggles player;
      player addGoggles "shemaghface_od";
    };
    if (_goggles isEqualTo "shemaghface_tan") then {
      removeGoggles player;
      player addGoggles "shemagh_loosetan";
    };
    if (_goggles isEqualTo "shemagh_loosetan") then {
      removeGoggles player;
      player addGoggles "shemaghface_tan";
    };
    player playMove "Acts_listeningToRadio_Out";
  };
};

vics_fnc_goggles = {
  [] spawn {
    player playMove "Acts_listeningToRadio_In";
    uiSleep 0.85;
    _helmet = headgear player;
    if (_helmet isEqualTo "milgp_h_opscore_01_goggles_CB") then {
      plyGoggles = goggles player;
      player unassignItem (plyGoggles);
      removeHeadgear player;
      player addHeadgear "milgp_h_opscore_01_CB";
      player addGoggles "rhsusf_oakley_goggles_clr";
    };
    if (_helmet isEqualTo "milgp_h_opscore_01_CB") then {
      removeGoggles player;
      removeHeadgear player;
      player addHeadgear "milgp_h_opscore_01_goggles_CB";
      player assignItem (plyGoggles);
    };
    player playMove "Acts_listeningToRadio_Out";
  };
};

vics_fnc_wrap = {
  [] spawn {
    player playMove "Acts_listeningToRadio_In";
    uiSleep 0.85;
    _gogglesCheck = goggles player;
    if (_gogglesCheck isEqualTo "") then {
      player assignItem (plyGoggles);
    } else {
    plyGoggles = goggles player;
    player unassignItem (plyGoggles);
    };
    player playMove "Acts_listeningToRadio_Out";
  };
};

vics_ply_openPhone = {
  closeDialog 0;
  createDialog "RCAS";
};

vics_ply_addItem = {
  params ["_target","_item"];
  if (_target canAdd "_item") then {
    player removeItem "_item";
    _target addItem "_item";
  } else {
    systemChat "No room to give item";
  };
};

vics_ply_modCheck = {
  if (vicsAntiCheat isEqualTo true) then {
    _playerMods = getLoadedModsInfo;
    _clientID = clientOwner;
    if !((admin _clientID) isEqualTo 2) then {
      _notAllowedMods = [];
      {
        _mod = _x;
        if (_mod in modsArrayPublic) then {

        } else {
          _notAllowedMods pushBack _mod;
        };
      }forEach _playerMods;
      _notAllowedMods;
      if ((count _notAllowedMods) > 0) then {
        ["User has mods that arent allowed by the antiCheat.","VICS_AntiCheat",true] call vics_sys_debug;
        player enableSimulation false;
        player setUnitLoadout [[],[],[],["U_C_Scientist",[]],[],[],"H_ShemagOpen_khk","G_Blindfold_01_white_F",[],["","","","","",""]];
      };
    };
  };
};

vics_ply_rollSleeves = {
  [] spawn {
    player playMove "Acts_listeningToRadio_In";
    uiSleep 0.85;
    _uniformCheck = uniform player;
    _playerLoadout = getUnitLoadout [player,false];
    _cleanLoadout = [_playerLoadout] call vics_ply_cleanLoadout;
    _switch = false;
    if (_uniformCheck isEqualTo "Alpha_Crye_MC_Camo") then {
      //player addUniform "Alpha_Crye_MC_RS_Camo";
      _uniformArray = _cleanLoadout select 3;
      _uniformArray set [0,"Alpha_Crye_MC_RS_Camo"];
      _cleanLoadout set [3,_uniformArray];
      _switch = true;
    };
    if (_uniformCheck isEqualTo "Alpha_Crye_MC_RS_Camo") then {
      //player addUniform "Alpha_Crye_MC_Camo";
      _uniformArray = _cleanLoadout select 3;
      _uniformArray set [0,"Alpha_Crye_MC_Camo"];
      _cleanLoadout set [3,_uniformArray];
      _switch = true;
    };

    if (_switch) then {
      player setUnitLoadout _cleanLoadout;
    };
    player playMove "Acts_listeningToRadio_Out";
  };
};

vics_ply_cleanLoadout = {
  params ["_loadout"];
  _uniform = ((_loadout select 3) select 1);
{
    _type = (_x select 0) call BIS_fnc_itemType;
    if (((_type select 1) isEqualTo "Bullet") && {(_x select 1) >= 2 && {(_x select 2) != (getNumber(configFile >> "cfgMagazines" >> (_x select 0) >> "count"))}}) then
    {
        ((_loadout select 3) select 1) set [_forEachIndex, [(_x select 0),1,(_x select 2)]];
        for "_i" from 1 to (_x select 1)-1 do
        {
            ((_loadout select 3) select 1) pushBack [(_x select 0),1,(_x select 2)];
        };
    };
} forEach _uniform; //check uniform

_vest = ((_loadout select 4) select 1);
{
    _type = (_x select 0) call BIS_fnc_itemType;
    if (((_type select 1) isEqualTo "Bullet") && {(_x select 1) >= 2 && {(_x select 2) != (getNumber(configFile >> "cfgMagazines" >> (_x select 0) >> "count"))}}) then
    {
        ((_loadout select 4) select 1) set [_forEachIndex, [(_x select 0),1,(_x select 2)]];
        for "_i" from 1 to (_x select 1)-1 do
        {
            ((_loadout select 4) select 1) pushBack [(_x select 0),1,(_x select 2)];
        };
    };
} forEach _vest; //check vest

_backpack = ((_loadout select 5) select 1);
{
    _type = (_x select 0) call BIS_fnc_itemType;
    if (((_type select 1) isEqualTo "Bullet") && {(_x select 1) >= 2 && {(_x select 2) != (getNumber(configFile >> "cfgMagazines" >> (_x select 0) >> "count"))}}) then
    {
        ((_loadout select 5) select 1) set [_forEachIndex, [(_x select 0),1,(_x select 2)]];
        for "_i" from 1 to (_x select 1)-1 do
        {
            ((_loadout select 5) select 1) pushBack [(_x select 0),1,(_x select 2)];
        };
    };
} forEach _backpack; //check backpack

_loadout
};

vics_ply_respawn = {
  _loadout = player getVariable "respawnLoadout";
  [_loadout] call vics_ply_setLoadout;
  //statsDeath = statsDeath + 1;
};

vics_ply_creditEarn = {
  _incomeRate = player getVariable ["incomeRate",1];
  _playerMorale = profileNameSpace getVariable [(missionPrefix + "playerMorale"),[50,50,50,50,50,50,50]];
  _playerMoraleLevel = _playerMorale select 0;
  _moraleMultiplier = 1;
  if (_playerMoraleLevel > 50) then {
    _moraleMultiplier = 2;
  };
  _income = (0.17 * _incomeRate * _moraleMultiplier);
  _incomeRounded = [_income, 2] call BIS_fnc_cutDecimals;
  if (_incomeRounded < 0.17) then {
    _incomeRounded = 0.17;
  };
  //systemChat format ["Income: %1",_incomeRounded];
  [player, _incomeRounded] call HALs_money_fnc_addFunds;
  _credits = [player] call HALs_money_fnc_getFunds;
  profileNameSpace setVariable ["opCredits",_credits];
};


vics_ply_headLampMap = {
  addMissionEventHandler ["Map", {
	params ["_mapIsOpened", "_mapIsForced"];
  if (_mapIsOpened) then {
    if ((player getVariable ["SAN_Headlamp_TurnedOn",false]) isEqualTo false) then {
      [ACE_player, ""] call ace_map_fnc_switchFlashlight;
    } else {
      [ACE_player, "ACE_Flashlight_MX991"] call ace_map_fnc_switchFlashlight;
    };
  };
}];
};

vics_ply_transferCredits = {
  params [["_target",objNull],"_amount"];
  _creditsPlayer = [player] call HALs_money_fnc_getFunds;
  if !(_target isEqualTo objNull) then {
    if ((typename _amount) isEqualTo "SCALAR") then {
      if (alive _target) then {
        if (_amount > 0) then {
          if (_creditsPlayer > _amount) then {
            if (_amount < 1000) then {
              _amountRounded = [_amount,2] call BIS_fnc_cutDecimals;
              _amountToRemove = (_amountRounded * -1);
              [player, _amountToRemove] call HALs_money_fnc_addFunds;
              [_target, _amountRounded] call HALs_money_fnc_addFunds;
              call vics_ply_saveCredits;
              [] remoteExec ["vics_ply_saveCredits",_target];
              call vics_menu_refresh;
              systemChat format ["You Transferred %1 credits.",_amountRounded];
              systemChat format ["Remaining credits: %1",(_creditsPlayer + _amountToRemove)];
            } else {
              systemChat "You can transfer a max of 1000 credits per transaction";
            };
          } else {
            systemChat "You do not have enough credits";
          };
        } else {
          systemChat "You must transfer a positive amount of credits";
        };
      } else {
        systemChat "This person is dead.";
      };
    } else {
      systemChat "Set the amount you want to transfer";
    };
  } else {
    systemChat "Select someone to transfer to";
  };
};

///
//Statistics
///



vics_ply_loadStatistics = {
  /*
  statsShotCount = profileNameSpace getVariable "statsShotCount";
  if (isNil "statsShotCount") then {
    statsShotCount = 0;
  };

  statsReloadedCount = profileNameSpace getVariable "statsReloadedCount";
  if (isNil "statsReloadedCount") then {
    statsReloadedCount = 0;
  };

  statsContOpen = profileNameSpace getVariable "statsContOpen";
  if (isNil "statsContOpen") then {
    statsContOpen = 0;
  };

  statsHitCount = profileNameSpace getVariable "statsHitCount";
  if (isNil "statsHitCount") then {
    statsHitCount = 0;
  };

  statsGetIn = profileNameSpace getVariable "statsGetIn";
  if (isNil "statsGetIn") then {
    statsGetIn = 0;
  };

  statsItemTaken = profileNameSpace getVariable "statsItemTaken";
  if (isNil "statsItemTaken") then {
    statsItemTaken = 0;
  };

  statsDeath = profileNameSpace getVariable "statsDeath";
  if (isNil "statsDeath") then {
    statsDeath = 0;
  };
  */
};

vics_ply_saveStatistics = {
  /*
  profileNameSpace setVariable ["statsShotCount",statsShotCount];
  profileNameSpace setVariable ["statsReloadedCount",statsReloadedCount];
  profileNameSpace setVariable ["statsContOpen",statsContOpen];
  profileNameSpace setVariable ["statsHitCount",statsHitCount];
  profileNameSpace setVariable ["statsGetIn",statsGetIn];
  profileNameSpace setVariable ["statsItemTaken",statsItemTaken];
  profileNameSpace setVariable ["statsDeath",statsDeath];
  */
};


vics_sys_deployTent = {
  _tentStored = profileNameSpace getVariable (missionPrefix + "tentStored");
  if (isNil "_tentStored") then {
    _playerDir = getDir player;
    _playerPos = player getPos [1.5,_playerDir];
    _playerUID = getPlayerUID player;
    _nearObjects = _playerPos nearObjects ["All", 2];
    systemChat str _nearObjects;
    if ((count _nearObjects) isEqualTo 1) then {
      [_playerPos,_playerDir,_playerUID,player] remoteExec ["vics_sys_tentCreate",2];
      _tentStored = ["",[],[_playerPos,_playerDir]];
      profileNameSpace setVariable [(missionPrefix + "tentStored"),_tentStored];
    } else {
      hint "Too close to objects.";
    };
  } else {
    hint "Tent already deployed somewhere.";
  };
};

vics_ply_createFobPoint = {
  [] spawn {
    _playerPos = getPos player;
    _fobHelper = createVehicle ["Sign_Sphere100cm_F",_playerPos,[],0,"CAN_COLLIDE"];
    helperPlaced = false;
    helperCancelled = false;
    _action = player addAction ["Place COP",{helperPlaced = true}];
    _cancel = player addAction ["Cancel construction",{helperCancelled = true}];
    while {helperPlaced isEqualTo false} do {
      if (helperCancelled) exitWith {};
      _screenPos = screenToWorld [0.5,0.5];
      _fobHelper setPos _screenPos;
      uiSleep 0.05;
    };

    if (helperCancelled) then {

    } else {
      [_playerPos,(getPos _fobHelper),clientOwner] remoteExec ["vics_bld_setFobPoint",2];
    };
    player removeAction _action;
    player removeAction _cancel;
    deleteVehicle _fobHelper;
  };
};

vics_ply_createPBPoint = {
  [] spawn {
    _playerPos = getPos player;
    _fobHelper = createVehicle ["Sign_Sphere100cm_F",_playerPos,[],0,"CAN_COLLIDE"];
    helperPlaced = false;
    helperCancelled = false;
    _action = player addAction ["Place PB",{helperPlaced = true}];
    _cancel = player addAction ["Cancel construction",{helperCancelled = true}];
    while {helperPlaced isEqualTo false} do {
      if (helperCancelled) exitWith {};
      _screenPos = screenToWorld [0.5,0.5];
      _fobHelper setPos _screenPos;
      uiSleep 0.05;
    };

    if (helperCancelled) then {

    } else {
      [_playerPos,(getPos _fobHelper),clientOwner] remoteExec ["vics_bld_setPBPoint",2];
    };
    player removeAction _action;
    player removeAction _cancel;
    deleteVehicle _fobHelper;
  };
};

vics_ply_addCOPOption = {
  _copEstablish = ["copEstablish", "Establish COP","",{[] call vics_ply_createFobPoint},{true}] call ace_interact_menu_fnc_createAction;
  [player,1,["ACE_SelfActions", "vicsMenu"],_copEstablish] call ace_interact_menu_fnc_addActionToObject;
};

vics_ply_addPBOption = {
  _pbEstablish = ["pbEstablish", "Establish PB","",{[] call vics_ply_createPBPoint},{true}] call ace_interact_menu_fnc_createAction;
  [player,1,["ACE_SelfActions", "vicsMenu"],_pbEstablish] call ace_interact_menu_fnc_addActionToObject;
};

vics_ply_addSuppliesOption = {
  _suppliesMainMenu = ["suppliesMainMenu", "Supplies Ordering Menu","",{nil},{true}] call ace_interact_menu_fnc_createAction;
  [player,1,["ACE_SelfActions", "vicsMenu"],_suppliesMainMenu] call ace_interact_menu_fnc_addActionToObject;
  _suppliesCrate1 = ["suppliesCrate1", "Supplies Crate #1 - 5","",{["supplySpawn","supplies1"] remoteExec ["vics_sup_supplyfufill",2]},{true}] call ace_interact_menu_fnc_createAction;
  [player,1,["ACE_SelfActions", "vicsMenu", "suppliesMainMenu"],_suppliesCrate1] call ace_interact_menu_fnc_addActionToObject;
};









/*
vics_ply_deployTent = {
  [] spawn {
    _tentStored = profileNameSpace getVariable (missionPrefix + "tentStored");
    if (isNil "_tentStored") then {
      _playerDir = getDir player;
      _playerPos = player getPos [1.5,_playerDir];
      _playerUID = getPlayerUID player;
      _nearObjects = _playerPos nearObjects ["All", 2];
      systemChat str _nearObjects;
      if ((count _nearObjects) isEqualTo 1) then {
        [_playerPos,_playerDir,_playerUID,player] remoteExec ["vics_sys_tentCreate",2];
        //_tentArray = player getVariable "tentObject";
        //_tentObject = _tentArray select 1;
        uiSleep 0.5;
        _nearestObjects = _playerPos nearObjects ["All",30];
        _tentObject = nil;
        {
          _var = _x getVariable [(missionPrefix + "tentOwner"),""];
          if (_var isEqualTo _playerUID) exitWith {_tentObject = _x};
        }forEach _nearestObjects;
        _tentObject;
        systemChat str _nearestObjects;
        systemChat str _tentObject;
        _tentInteraction = ["backpackInteraction", "Store/Retrieve Backpack","",{call vics_ply_tentInteract},{true}] call ace_interact_menu_fnc_createAction;
        [_tentObject,0,["ACE_MainActions"],_tentInteraction] call ace_interact_menu_fnc_addActionToObject;
        _tentPack = ["tentPack", "Pack Tent","",{call vics_ply_packTent},{true}] call ace_interact_menu_fnc_createAction;
        [_tentObject,0,["ACE_MainActions"],_tentPack] call ace_interact_menu_fnc_addActionToObject;
        _tentData = [_playerPos,_playerDir,_playerUID];
        [_tentData] remoteExec ["vics_sys_tentUpdate",2];
        _tentStored = [false,"",[],[_playerPos,_playerDir],[_tentObject]];
        profileNameSpace setVariable [(missionPrefix + "tentStored"),_tentStored];
      } else {
        hint "Too close to objects.";
      };
    } else {
      hint "Tent already deployed somewhere.";
    };
  };
};

vics_ply_loadTent = {
  _tentStored = profileNameSpace getVariable (missionPrefix + "tentStored");
  if (isNil "_tentStored") then {
  } else {
  _tentRetrivedStatus = _tentStored select 0;
  _tentBackpack = _tentStored select 1;
  _tentItems = _tentStored select 2;
  _playerPos = _tentStored select 3 select 0;
  _playerDir = _tentStored select 3 select 1;
  _playerUID = getPlayerUID player;
  _nearestObjects = _playerPos nearObjects ["Land_TentDome_F",30];
  _tentObject = nil;
  {
    _var = _x getVariable [(missionPrefix + "tentOwner"),""];
    if (_var isEqualTo _playerUID) exitWith {_tentObject = _x};
  }forEach _nearestObjects;
  _tentObject;
  _tentInteraction = ["backpackInteraction", "Store/Retrieve Backpack","",{call vics_ply_tentInteract},{true}] call ace_interact_menu_fnc_createAction;
  [_tentObject,0,["ACE_MainActions"],_tentInteraction] call ace_interact_menu_fnc_addActionToObject;
  _tentPack = ["tentPack", "Pack Tent","",{call vics_ply_packTent},{true}] call ace_interact_menu_fnc_createAction;
  [_tentObject,0,["ACE_MainActions"],_tentPack] call ace_interact_menu_fnc_addActionToObject;
  _tentStored = [_tentRetrivedStatus,_tentBackpack,_tentItems,[_playerPos,_playerDir],[_tentObject]];
  profileNameSpace setVariable [(missionPrefix + "tentStored"),_tentStored];
  };
};

vics_ply_tentInteract = {
  _tentStored = profileNameSpace getVariable (missionPrefix + "tentStored");
  if (isNil "_tentStored") then {
    _tentStored = [false,"",[],[[0,0,0],0]];
  };
  _tentStored;
  _storeToggle = _tentStored select 0;
  _tentItems = _tentStored select 2;
  _tentPos = _tentStored select 3 select 0;
  if ((player distance2d _tentPos) < 3) then {
    if ((count _tentItems) isEqualTo 0) then {
      [] call vics_ply_storeInTent;
    } else {
      [] call vics_ply_retriveFromTent;
    };
  } else {
    hint "This is not your tent";
  };
};

vics_ply_storeInTent = {
  _tentStored = profileNameSpace getVariable (missionPrefix + "tentStored");
  _tentBackpack = _tentStored select 1;
  _tentItems = _tentStored select 2;
  _playerPos = _tentStored select 3 select 0;
  _playerDir = _tentStored select 3 select 1;
  _tentObjectInfo = _tentStored select 4;
  _unitBackpack = Backpack player;
  if (_unitBackpack isEqualTo "") then {
    hint "You do not have a backpack.";
  } else {
    _tentBackpack = backpack player;
    _tentItems = backpackItems player;
    removeBackpack player;
  };
  _tentStored = [true,_unitBackpack,_tentItems,[_playerPos,_playerDir],_tentObjectInfo];
  profileNameSpace setVariable [(missionPrefix + "tentStored"),_tentStored];
};

vics_ply_retriveFromTent = {
  _tentStored = profileNameSpace getVariable (missionPrefix + "tentStored");
  _tentBackpack = _tentStored select 1;
  _tentItems = _tentStored select 2;
  _playerPos = _tentStored select 3 select 0;
  _playerDir = _tentStored select 3 select 1;
  _tentObjectInfo = _tentStored select 4;
  _unitBackpack = Backpack player;
  if (_unitBackpack isEqualTo "") then {
    player addBackpack _tentBackpack;
    {
      player addItemToBackpack _x;
    }forEach _tentItems;
  } else {
    hint "You already have a backpack on.";
  };
  _tentStored = [false,"",[],[_playerPos,_playerDir],_tentObjectInfo];
  profileNameSpace setVariable [(missionPrefix + "tentStored"),_tentStored];
};

vics_ply_packTent = {
  _tentStored = profileNameSpace getVariable (missionPrefix + "tentStored");
  _tentBackpack = _tentStored select 1;
  _tentItems = _tentStored select 2;
  _playerPos = _tentStored select 3 select 0;
  _playerDir = _tentStored select 3 select 1;
  _tentObject = _tentStored select 4 select 0;
  deleteVehicle _tentObject;
  _tentData = [_playerPos,_playerDir];
  [_tentData] remoteExec ["vics_sys_tentUpdate",2,true];
  profileNameSpace setVariable [(missionPrefix + "tentStored"),nil];
};


*/

vics_ply_redeployMenu = {
  [] spawn {
    //Is the player within 5km of redeploy point. If so do not offer the option to redeploy
    if !(isnil "redeployPointAlpha") then {
      if !(((getPos player) distance (getPos redeployPointAlpha)) < 5000) then {
        _redeployAction = player addAction ["Redeploy to secure point.",{[(getPosATL redeployPointAlpha),_this select 2] call vics_ply_redeploy}];
        uiSleep 60;
        player removeAction _redeployAction;
      } else {

      };
    };
  };
};


vics_ply_redeploy = {
  params ["_position","_actionIndex"];
  player setPosATL _position;
  player removeAction _actionIndex;
};

vics_ply_addKeyEH = {
  addUserActionEventHandler ["User15","Activate",{[] spawn vics_ply_controlCivs}];
  addUserActionEventHandler ["User16","Activate",{[] spawn vics_ply_openMenu}];
};

vics_ply_openMenu = {
  [] call vics_menu_open;
};

vics_ply_controlCivs = {

  _controlCivBool = player getVariable ["controlCivBool",true];
  if (_controlCivBool) then {
    player setVariable ["controlCivBool",false];
    //Tell civ to get down
    //systemChat str (random 1000000);
    _nearUnits = player nearObjects 15;
    {
      if (((side _x) isEqualTo civilian) && ((isPlayer _x) isEqualTo false)) then {
        if ((random 100) > 0) then {
          if (_x isKindOf "AllVehicles") then {
            _driver = driver _x;
            if (isNull _driver) then {
              _crew = crew _x;
              {
                if ((random 100) > 0) then {
                  doGetOut _x;
                  [_x] allowGetIn false;
                  uiSleep 0.15;
                  [_x, true] remoteExec ["ace_captives_fnc_setSurrendered",_x];
                };
              }forEach _crew;
            } else {
              doGetOut _driver;
              uiSleep 0.15;
              [_driver, true] remoteExec ["ace_captives_fnc_setSurrendered",_x];
              [_driver] allowGetIn false;
            };
          } else {
            [_x, true] remoteExec ["ace_captives_fnc_setSurrendered",_x];
            [_x] allowGetIn false;
          };
        };
      };
    }forEach _nearUnits;
    uiSleep 3;
    player setVariable ["controlCivBool",true];
  } else {
    systemChat "Can't do that yet.";
  };
};

vics_ply_saveLoadout = {

};

vics_ply_getLoadout = {

};

vics_ply_switchUniform = {
  params ["_newUniform"];
  _loadout = getUnitLoadout [player, false];
  _uniArray = _loadout select 3;
  _uni = _uniArray select 0;
if (isNil "_uni") then {
_uni = "";
};
systemChat str _uni;
  _uniArray set [0,_newUniform];
  player setUnitLoadout [_loadout, false];
};

vics_ply_searchObject = {
  params ["_object","_caller"];

};

vics_ply_solarBattery = {
  _mags = magazines player;
  if !("Laserbatteries" in _mags) then {
    player addMagazine "Laserbatteries";
  };
};

vics_ply_moraleCalculate = {
  //[Morale, Comfort, Load, Wet, Tired, Fire, Cold]
  _playerMorale = profileNameSpace getVariable [(missionPrefix + "playerMorale"),[50,50,50,50,50,50,50]];
  _playerMoraleLevel = _playerMorale select 0;
  _comfortLevel = _playerMorale select 1;
  _loadLevel = _playerMorale select 2;
  _wetLevel = _playerMorale select 3;
  _tiredLevel = _playerMorale select 4;
  _nearFireLevel = _playerMorale select 5;
  _coldLevel = _playerMorale select 6;
  //Headgear
  _playerHeadgear = headgear player;
  _headgearComfy = false;
  _vestComfy = false;
  _uniComfy = false;
  _backpackComfy = false;
  _faceComfy = false;
  if (_playerHeadgear in comfyHeadgear) then {
    _comfortLevel = _comfortLevel + 12;
    _headgearComfy = true;
  } else {
    if (_playerHeadgear in uncomfyHeadgear) then {
      _comfortLevel = _comfortLevel - 10;
      _headgearComfy = false;
    } else {
      _comfortLevel = _comfortLevel - 1;
      _headgearComfy = false;
    };
  };
  //vest
  _playerVest = vest player;
  if (_playerVest in comfyVests) then {
    _comfortLevel = _comfortLevel + 10;
    _vestComfy = true;
  } else {
    if (_playerHeadgear in uncomfyVests) then {
      _comfortLevel = _comfortLevel - 10;
      _vestComfy = false;
    } else {
      _comfortLevel = _comfortLevel - 3;
      _vestComfy = false;
    };
  };
  //backpack
  _playerBackpack = backpack player;
  if (_playerBackpack in comfyBags) then {
    _comfortLevel = _comfortLevel + 10;
    _backpackComfy = true;
  } else {
    if (_playerHeadgear in uncomfyBags) then {
      _comfortLevel = _comfortLevel - 10;
      _backpackComfy = false;
    } else {
      _comfortLevel = _comfortLevel - 3;
      _backpackComfy = false;
    };
  };
  //Uniform
  _playerUniform = uniform player;
  if (_playerUniform in comfyUniforms) then {
    _comfortLevel = _comfortLevel + 10;
    _uniComfy = true;
  } else {
    if (_playerHeadgear in uncomfyUniforms) then {
      _comfortLevel = _comfortLevel - 10;
      _uniComfy = false;
    } else {
      _comfortLevel = _comfortLevel - 3;
      _uniComfy = false;
    };
  };
  //facewear
  _playerFacewear = goggles player;
  if (_playerFacewear in comfyFacewear) then {
    _comfortLevel = _comfortLevel + 10;
    _faceComfy = true;
  } else {
    if (_playerHeadgear in uncomfyFacewear) then {
      _comfortLevel = _comfortLevel - 10;
      _faceComfy = false;
    } else {
      _comfortLevel = _comfortLevel - 3;
      _faceComfy = false;
    };
  };
  //dayTime
  _dayTime = call vics_ply_isDay;

  //nearFire
  _nearFire = false;
  _nearObjects = getPos player nearObjects 6;
  _firesArray = [];
  {
    if (_x in firesList) then {
      _firesArray pushBack _x;
    };
  }forEach _nearObjects;
  if (count _firesArray > 0) then {
    //There is a fire near
    _fire = _firesArray select 0;
    if (inflamed _fire) then {
      _nearFire = true;
      _nearFireLevel = _nearFireLevel + 30;
    } else {
      //Fires arent lit
      _nearFireLevel = _nearFireLevel - 60;
    };
  } else {
    //No fires near
    _nearFireLevel = _nearFireLevel - 60;
  };
  _nearFire;
  //rain
  _playerRainLevel = rain;
  _headCovered = player call vics_ply_underCover;
  if (_playerRainLevel > 0) then {
    if (_headCovered) then {
      //head covered
      _wetLevel = _wetLevel - 5;
    } else {
      //Not covered
      if (_nearFire) then {
        _wetLevel = (_wetLevel + (_playerRainLevel / 2));
      } else {
        _wetLevel = (_wetLevel + (_playerRainLevel * 1));
      };
    };
  } else {
    _wetLevel = _wetLevel - 10;
  };

  _loadLevel = (((loadAbs Player)/(maxLoad player)) * 100);


  _coldLevel = _nearFireLevel - _wetLevel;

  //sleep
  _playerLastSleep = 0;
  _tiredLevel = _playerLastSleep;

  //At base
  _playerAtBase = false;


  //Calculation

  if (_comfortLevel > 100) then {
    _comfortLevel = 100;
  };
  if (_comfortLevel < 0) then {
    _comfortLevel = 0;
  };
  if (_loadLevel > 100) then {
    _loadLevel = 100;
  };
  if (_loadLevel < 0) then {
    _loadLevel = 0;
  };
  if (_wetLevel > 100) then {
    _wetLevel = 100;
  };
  if (_wetLevel < 0) then {
    _wetLevel = 0;
  };
  if (_tiredLevel > 100) then {
    _tiredLevel = 100;
  };
  if (_tiredLevel < 0) then {
    _tiredLevel = 0;
  };
  if (_nearFireLevel > 100) then {
    _nearFireLevel = 100;
  };
  if (_nearFireLevel < 0) then {
    _nearFireLevel = 0;
  };
  if (_coldLevel > 100) then {
    _coldLevel = 100;
  };
  if (_coldLevel < 0) then {
    _coldLevel = 0;
  };


_moraleAdjustment = 0;
  if (_comfortLevel < 30) then {
    _moraleAdjustment = _moraleAdjustment - 3;
  } else {
    if (_comfortLevel < 50) then {
      _moraleAdjustment = _moraleAdjustment - 1;
    } else {
      if (_comfortLevel < 70) then {
        _moraleAdjustment = _moraleAdjustment + 1;
      } else {
        if (_comfortLevel <= 90) then {
          _moraleAdjustment = _moraleAdjustment + 3;
        } else {
            _moraleAdjustment = _moraleAdjustment + 5;
        };
      };
    };
  };

  if (_loadLevel <= 30) then {
    _moraleAdjustment = _moraleAdjustment + 2;
  } else {
    if (_loadLevel <= 79) then {
      _moraleAdjustment = _moraleAdjustment + 1;
    } else {
      if (_loadLevel <= 80) then {
        _moraleAdjustment = _moraleAdjustment - 2;
      } else {
        if (_loadLevel <= 90) then {
          _moraleAdjustment = _moraleAdjustment - 5;
        } else {
            _moraleAdjustment = _moraleAdjustment - 8;
        };
      };
    };
  };

  if (_wetLevel <= 0) then {
    _moraleAdjustment = _moraleAdjustment + 0;
  } else {
    if (_wetLevel < 30) then {
      _moraleAdjustment = _moraleAdjustment - 3;
    } else {
      if (_wetLevel < 70) then {
        _moraleAdjustment = _moraleAdjustment - 6;
      } else {
        if (_wetLevel <= 90) then {
          _moraleAdjustment = _moraleAdjustment - 8;
        } else {
            _moraleAdjustment = _moraleAdjustment - 10;
        };
      };
    };
  };

  if (_tiredLevel <= 0) then {
    _moraleAdjustment = _moraleAdjustment + 0;
  } else {
    if (_tiredLevel < 30) then {
      _moraleAdjustment = _moraleAdjustment - 3;
    } else {
      if (_tiredLevel < 70) then {
        _moraleAdjustment = _moraleAdjustment - 6;
      } else {
        if (_tiredLevel <= 90) then {
          _moraleAdjustment = _moraleAdjustment - 8;
        } else {
            _moraleAdjustment = _moraleAdjustment - 10;
        };
      };
    };
  };

  if (_coldLevel <= 0) then {
    _moraleAdjustment = _moraleAdjustment + 0;
  } else {
    if (_coldLevel < 30) then {
      _moraleAdjustment = _moraleAdjustment + 0;
    } else {
      if (_coldLevel < 70) then {
        _moraleAdjustment = _moraleAdjustment - 1;
      } else {
        if (_coldLevel <= 90) then {
          _moraleAdjustment = _moraleAdjustment - 4;
        } else {
            _moraleAdjustment = _moraleAdjustment - 6;
        };
      };
    };
  };

  if (_moraleAdjustment > 100) then {
    _moraleAdjustment = 100;
  };
  if (_moraleAdjustment < -100) then {
    _moraleAdjustment = -100;
  };

_playerMoraleLevel = _playerMoraleLevel + _moraleAdjustment;

  if (_playerMoraleLevel > 100) then {
    _playerMoraleLevel = 100;
  };
  if (_playerMoraleLevel < 0) then {
    _playerMoraleLevel = 0;
  };

  //[Morale, Comfort, Load, Wet, Tired, Fire, Cold]
  //systemChat format ["M:%1 C:%2 L:%3 W:%4 T:%5 F:%6 C:%7",_playerMoraleLevel,_comfortLevel,_loadLevel,_wetLevel,_tiredLevel,_nearFireLevel,_coldLevel];
  //systemChat format ["H:%1 V:%2 B:%3 U:%4 F:%5",_headgearComfy,_vestComfy,_backpackComfy,_uniComfy,_faceComfy];
  profileNameSpace setVariable [(missionPrefix + "playerMorale"),[_playerMoraleLevel,_comfortLevel,_loadLevel,_wetLevel,_tiredLevel,_nearFireLevel,_coldLevel]];

};


vics_ply_isDay = {
  //Check if daytime or not locally to client
  _isDay = true;
  //If later than 19:00, it is not considered day
  if (dayTime > 19) then {
    _isDay = false;
  } else {
    _isDay = true;
  };
  //Return Variable
  _isDay;
};

vics_ply_underCover = {
	lineIntersectsSurfaces [
		getPosWorld _this,
		getPosWorld _this vectorAdd [0, 0, 50],
		_this, objNull, true, 1, "GEOM", "NONE"
	] select 0 params ["","","","_house"];
	if (!isnil "_house") exitWith { true };
	false;
};

vics_ply_recieveEmail = {
  params ["_emailSender","_emailSubject","_emailBody",["_emailArrival",nil]];
  _emailsArray = profileNameSpace getVariable ["playerEmails",[]];
  if (isNil "_emailArrival") then {
    _currentTime = systemTime apply {if (_x < 10) then {"0" + str _x} else {str _x}};
    _emailArrival = ((_currentTime select 3) + ":" + (_currentTime select 4) + " " + (_currentTime select 1) + "/" + (_currentTime select 2) + "/" + (_currentTime select 0));
  };
  _emailsArray pushBack [_emailSender,_emailSubject,_emailBody,_emailArrival];
  profileNameSpace setVariable ["playerEmails",_emailsArray];
};

vics_ply_reloadEmails = {
  _emailsArray = profileNameSpace getVariable ["playerEmails",[]];
  closeDialog 0;
  createDialog "vicsEmailClient";
  if (count _emailsArray > 0) then {

    _emailList = findDisplay 2288 displayCtrl 1500;
    _emailList ctrlRemoveAllEventHandlers "LBDblClick";
    _emailList ctrlAddEventHandler ["LBDblClick","[_this select 0,_this select 1] call vics_ply_openEmail;"];
    for "_i" from ((count _emailsArray) - 1) to 0 step -1 do {
      _emailSelected = _emailsArray select _i;
      _emailFrom = _emailSelected select 0;
      _emailSubject = _emailSelected select 1;
      _emailBody = _emailSelected select 2;
      _emailArrival = _emailSelected select 3;
      _emailEntry = ("                " + _emailFrom);
      _emailSubjectDate = (_emailArrival);
      _lbIndex = _emailList lbAdd _emailEntry;
      _emailList lbSetTextRight [_lbIndex, _emailSubjectDate];
      _emailList lbSetData [_lbIndex,(str _emailSelected)];
    };
  };
};

vics_ply_openEmail = {
  params ["_control","_selectedIndex"];
  _emailSummaryText = findDisplay 2288 displayCtrl 1100;
  _emailBodyText = findDisplay 2288 displayCtrl 1101;
  _emailStr = _control lbData _selectedIndex;
  _emailSelected = parseSimpleArray _emailStr;
  _emailFrom = _emailSelected select 0;
  _emailSubject = _emailSelected select 1;
  _emailBody = _emailSelected select 2;
  _emailArrival = _emailSelected select 3;
  _summaryStr = format ["From: %1 <br/> Subject: %2 <br/> Arrived At: %3",_emailFrom,_emailSubject,_emailArrival];
  _emailBodyText ctrlSetStructuredText parseText _emailBody;
  _emailSummaryText ctrlSetStructuredText parseText _summaryStr;
};

vics_ply_removeItems = {
  params ["_item","_amount"];
  for "_i" from 1 to _amount do {
    player removeItem _item;
  };
 };

vics_ply_placeBag = {
  _backpack = backpack player;
  _backpackContainer = backpackContainer player;
  _magazinesCargo = magazinesAmmo _backpackContainer;
  if (isNil "_magazinesCargo") then {
    _magazinesCargo = [];
  };
  //systemChat str _magazinesCargo;
  _itemsCargo = getItemCargo _backpackContainer;
  if (isNil "_itemsCargo") then {
    _itemsCargo = [];
  };
  _weaponsCargo = getWeaponCargo _backpackContainer;
  if (isNil "_weaponsCargo") then {
    _weaponsCargo = [];
  };
  _backpacksCargo = getBackpackCargo _backpackContainer;
  if (isNil "_backapcksCargo") then {
    _backapcksCargo = [];
  };
  _backpackInventory = [_magazinesCargo,_itemsCargo,_weaponsCargo,_backpacksCargo];
  _gwh = createVehicle ["Weapon_Empty",(getPosATL player),[],0,"CAN_COLLIDE"];
  player action ["DropBag", _gwh, typeOf unitBackpack player];
  _backpackPos = getPosATL player;
  systemChat str _backpackPos;
  _ident = random 100000;
  _backpackContainer setVariable ["backpackIdent",_ident,true];
  [_backpack,_backpackPos,_backpackInventory,(str _gwh),player,_ident] remoteExec ["vics_sys_persistBag",2];
};

vics_ply_adminMenu = {
  _adminStatus = call BIS_fnc_admin;
  if (((getPlayerUID player) in adminUIDs) or (_adminStatus isEqualTo 2)) then {
    closeDialog 0;
    createDialog "vicsMainMenuTabletAdmin";
  };
};

vics_ply_animate = {
  params ["_animation"];
  [player, _animation] remoteExec ["switchMove", 0];
  player playMoveNow _animation;
};



_laptops = [];
_emailClient = ["emailClient", "Open Email","",{[] call vics_ply_reloadEmails;},{true}] call ace_interact_menu_fnc_createAction;
{
  [_x,0,["ACE_MainActions"], _emailClient] call ace_interact_menu_fnc_addActionToObject;
}forEach _laptops;

_intelTurnIn = ["intelTurnIn", "Send Intel","",{[_player,(magazines _player)] remoteExec ["vics_intel_turnIn",2,false]},{true}] call ace_interact_menu_fnc_createAction;
//[intelTurnIn,0,["ACE_MainActions"], _intelTurnIn] call ace_interact_menu_fnc_addActionToObject;

_orderingAction = ["orderingAction", "Ordering","",{nil},{true}] call ace_interact_menu_fnc_createAction;
//[emailLaptop_3,0,["ACE_MainActions"], _orderingAction] call ace_interact_menu_fnc_addActionToObject;

_medicalSupplies = ["medicalSupplies", "Medical Supplies","",{["supplyDelivery","medicalSupplies"] remoteExec ["vics_support_supplyRequest",2]},{true}] call ace_interact_menu_fnc_createAction;
//[emailLaptop_3,0,["ACE_MainActions","orderingAction"], _medicalSupplies] call ace_interact_menu_fnc_addActionToObject;

_commandStatus = ["commandStatus", "Check in with command","",{[player] remoteExec ["vics_support_creditCheck",2]},{true}] call ace_interact_menu_fnc_createAction;
//[emailLaptop_3,0,["ACE_MainActions"], _commandStatus] call ace_interact_menu_fnc_addActionToObject;




//
// OREO Menu
//


_commsCard = ["commsCard", "Open Comms Card","",{createDialog "vicsCommsCard";},{("VEM_commsCard" in (items player));}] call ace_interact_menu_fnc_createAction;
[player,1,["ACE_SelfActions","ACE_Equipment"],_commsCard] call ace_interact_menu_fnc_addActionToObject;


//OREO Menu
_vicsMenu = ["vicsMenu", "OREO Menu","",{nil},{true}] call ace_interact_menu_fnc_createAction;
[player,1,["ACE_SelfActions"],_vicsMenu] call ace_interact_menu_fnc_addActionToObject;

/*
Animations list:
"w_sit27": Leg under backside, gun resting
"w_crouch4": Sleeping gun against helmet
"w_crouch5": Sleeping gun down
"pos_briefing_4": Checking phone
"pos_calm_36_kneel": Kneeling, gun in hand
"pos_calm_63": sitting gun in shoulder
"pos_calm_78": Kneeling, gun low ready
"R_crouch_002MP": Kneeling, gun in hand
"R_theme_021Para": sitting leaned against wall
"R_other_004": Sitting, gun on ground, leaning against wall
"R_other_019": Sitting low against wall


*/


//
// Animation Actions
//

_animationMenu = ["animationMenu","Animations","",{},{true}] call ace_interact_menu_fnc_createAction;
[player,1,["ACE_SelfActions", "vicsMenu"],_animationMenu] call ace_interact_menu_fnc_addActionToObject;

_cancelAnimation = ["cancelAnimation","Cancel Animation","",{[""] call vics_ply_animate;},{true}] call ace_interact_menu_fnc_createAction;
[player,1,["ACE_SelfActions", "vicsMenu", "animationMenu"],_cancelAnimation] call ace_interact_menu_fnc_addActionToObject;

_sittingMenu = ["sittingMenu","Sitting","",{},{true}] call ace_interact_menu_fnc_createAction;
[player,1,["ACE_SelfActions", "vicsMenu", "animationMenu"],_sittingMenu] call ace_interact_menu_fnc_addActionToObject;

_sit27 = ["sit27","Sit Down 1","",{["w_sit27"] call vics_ply_animate;},{true}] call ace_interact_menu_fnc_createAction;
[player,1,["ACE_SelfActions", "vicsMenu", "animationMenu","sittingMenu"],_sit27] call ace_interact_menu_fnc_addActionToObject;

_pos_calm_63 = ["pos_calm_63","Sit Down 2","",{["pos_calm_63"] call vics_ply_animate;},{true}] call ace_interact_menu_fnc_createAction;
[player,1,["ACE_SelfActions", "vicsMenu", "animationMenu","sittingMenu"],_pos_calm_63] call ace_interact_menu_fnc_addActionToObject;

_rother4 = ["rother4","Sit against wall 1","",{["R_other_004"] call vics_ply_animate;},{true}] call ace_interact_menu_fnc_createAction;
[player,1,["ACE_SelfActions", "vicsMenu", "animationMenu","sittingMenu"],_rother4] call ace_interact_menu_fnc_addActionToObject;

_R_theme_021Para = ["R_theme_021Para","Sit against wall 2","",{["R_theme_021Para"] call vics_ply_animate;},{true}] call ace_interact_menu_fnc_createAction;
[player,1,["ACE_SelfActions", "vicsMenu", "animationMenu","sittingMenu"],_R_theme_021Para] call ace_interact_menu_fnc_addActionToObject;

_R_other_019 = ["R_other_019","Sit against wall 3","",{["R_other_019"] call vics_ply_animate;},{true}] call ace_interact_menu_fnc_createAction;
[player,1,["ACE_SelfActions", "vicsMenu", "animationMenu","sittingMenu"],_R_other_019] call ace_interact_menu_fnc_addActionToObject;

_w_crouch4 = ["w_crouch4","Sleep 1","",{["w_crouch4"] call vics_ply_animate;},{true}] call ace_interact_menu_fnc_createAction;
[player,1,["ACE_SelfActions", "vicsMenu", "animationMenu"],_w_crouch4] call ace_interact_menu_fnc_addActionToObject;


//
//Construction Actions
//

//Construction Menu
_constructMain = ["constructMain","Construction","",{nil},{true}] call ace_interact_menu_fnc_createAction;
[player,1,["ACE_SelfActions", "vicsMenu"],_constructMain] call ace_interact_menu_fnc_addActionToObject;

//Small sandbag
_constructSandbag = ["constructSandbag", "Sandbags (Short)","",{["Land_BagFence_01_Short_green_F","RBD_sandbagKit",1] call RBD_fnc_object;},{("RBD_sandbagKit" in (items player));}] call ace_interact_menu_fnc_createAction;
[player, 1, ["ACE_SelfActions", "vicsMenu", "constructMain"],_constructSandbag] call ace_interact_menu_fnc_addActionToObject;

//Big sandbag
_constructSandbag = ["constructSandbag", "Sandbags (Long)","",{["Land_BagFence_01_long_green_F","RBD_sandbagKit",2] call RBD_fnc_object;},{("RBD_sandbagKit" in (items player));}] call ace_interact_menu_fnc_createAction;
[player, 1, ["ACE_SelfActions", "vicsMenu", "constructMain"],_constructSandbag] call ace_interact_menu_fnc_addActionToObject;

//Round sandbag
_constructSandbag = ["constructSandbag", "Sandbags (Round)","",{["Land_BagFence_01_round_green_F","RBD_sandbagKit",1] call RBD_fnc_object;},{("RBD_sandbagKit" in (items player));}] call ace_interact_menu_fnc_createAction;
[player, 1, ["ACE_SelfActions", "vicsMenu", "constructMain"],_constructSandbag] call ace_interact_menu_fnc_addActionToObject;

//Corner sandbag
_constructSandbag = ["constructSandbag", "Sandbags (Corner)","",{["Land_BagFence_01_corner_green_F","RBD_sandbagKit",1] call RBD_fnc_object;},{("RBD_sandbagKit" in (items player));}] call ace_interact_menu_fnc_createAction;
[player, 1, ["ACE_SelfActions", "vicsMenu", "constructMain"],_constructSandbag] call ace_interact_menu_fnc_addActionToObject;

//Small HESCO
_constructHesco = ["constructHescoSmalll", "HESCO (Short)","",{["Land_HBarrier_3_f","RBD_hescoKit",1] call RBD_fnc_object;},{("RBD_hescoKit" in (items player));}] call ace_interact_menu_fnc_createAction;
[player, 1, ["ACE_SelfActions", "vicsMenu", "constructMain"],_constructHesco] call ace_interact_menu_fnc_addActionToObject;

//Big HESCO
_constructHesco = ["constructHescoBig", "HESCO (Long)","",{["Land_HBarrier_5_f","RBD_hescoKit",2] call RBD_fnc_object;},{("RBD_hescoKit" in (items player));}] call ace_interact_menu_fnc_createAction;
[player, 1, ["ACE_SelfActions", "vicsMenu", "constructMain"],_constructHesco] call ace_interact_menu_fnc_addActionToObject;


//
//Gear Actions
//

//Gear Menu
_gearChange = ["gearchange","Gear Modifiers","helmet_icon.paa",{nil},{true}] call ace_interact_menu_fnc_createAction;
[player,1,["ACE_SelfActions", "vicsMenu"],_gearChange] call ace_interact_menu_fnc_addActionToObject;

//_accModify = ["accModify", "Accessories Modifiers","",{nil},{true}] call ace_interact_menu_fnc_createAction;

//[player,1,["ACE_SelfActions", "vicsMenu", "gearchange"],_accModify] call ace_interact_menu_fnc_addActionToObject;

//_uniModify = ["uniModify", "Unifrom Modifiers","",{nil},{true}] call ace_interact_menu_fnc_createAction;

//[player,1,["ACE_SelfActions", "vicsMenu", "gearchange"],_uniModify] call ace_interact_menu_fnc_addActionToObject;

//_myaction = ['TestAction 1','Raise/Lower Face cover','',{call vics_fnc_mask;},{true}] call ace_interact_menu_fnc_createAction;

//[player, 1, ["ACE_SelfActions", "vicsMenu", "gearchange", "accModify"], _myaction] call ace_interact_menu_fnc_addActionToObject;

//_myaction2 = ['TestAction 2','add/remove Face cover','',{call vics_fnc_wrap;},{true}] call ace_interact_menu_fnc_createAction;

//[player, 1, ["ACE_SelfActions", "vicsMenu", "gearchange", "accModify"], _myaction2] call ace_interact_menu_fnc_addActionToObject;

//_myaction3 = ['TestAction 3','Raise/Lower Goggles','',{call vics_fnc_goggles;},{true}] call ace_interact_menu_fnc_createAction;

//[player, 1, ["ACE_SelfActions", "vicsMenu", "gearchange", "accModify"], _myaction3] call ace_interact_menu_fnc_addActionToObject;

//_uniformRoll = ["RollUniform", "Roll/Unroll Uniform","",{call vics_ply_rollSleeves;},{true}] call ace_interact_menu_fnc_createAction;

//[player, 1, ["ACE_SelfActions", "vicsMenu", "gearchange", "uniModify"], _uniformRoll] call ace_interact_menu_fnc_addActionToObject;


//
//Backpack Actions
//

//Backpack Actions Menu
_backpackChange = ["backpackChange", "Backpack Actions","",{nil},{true}] call ace_interact_menu_fnc_createAction;
[player,1,["ACE_SelfActions", "vicsMenu", "gearchange"],_backpackChange] call ace_interact_menu_fnc_addActionToObject;

_backpackPlace = ["backpackChange", "Set down Backpack","",{[] call vics_ply_placeBag},{true}] call ace_interact_menu_fnc_createAction;
[player,1,["ACE_SelfActions", "vicsMenu", "gearchange", "backpackChange"],_backpackPlace] call ace_interact_menu_fnc_addActionToObject;

//Compress Backpack
_backpackCompress = ['backpack Compress','Compress Backpack','',{call vics_ply_compressBackpack},{true}] call ace_interact_menu_fnc_createAction;
[player, 1, ["ACE_SelfActions", "vicsMenu", "gearchange", "backpackChange"], _backpackCompress] call ace_interact_menu_fnc_addActionToObject;

//Decompress Backpack
_backpackDecompress = ['backpack Decompress','Decompress Backpack','',{call vics_ply_decompressBackpack},{true}] call ace_interact_menu_fnc_createAction;
[player, 1, ["ACE_SelfActions", "vicsMenu", "gearchange", "backpackChange"], _backpackDecompress] call ace_interact_menu_fnc_addActionToObject;

//
//Phone Actions
//

//Open Phone
_phoneInteract = ["phoneInteract", "Open Phone", "",{call vics_ply_openPhone},{true}] call ace_interact_menu_fnc_createAction;
[player,1,["ACE_SelfActions", "vicsMenu"],_phoneInteract] call ace_interact_menu_fnc_addActionToObject;





//_blackTShirt = ["gryTshirtOn", "Put on Grey T-Shirt","",{["tfl_new_gry_mc_uniform"] call vics_ply_switchUniform;},{[_player, "Repo_gryTshirt"] call BIS_fnc_hasItem;}] call ace_interact_menu_fnc_createAction;
//[player, 1, ["ACE_MainActions"],_blackTShirt] call ace_interact_menu_fnc_addActionToObject;
