_config = execVM "VICS-Rewrite\playerConfiguration.sqf";
waitUntil {scriptDone _config};
execVM "VICS-Rewrite\supportFunctions.sqf";
execVM "VICS-Rewrite\intelFunctions.sqf";
execVM "VICS-Rewrite\incognitoFunctions.sqf";
execVM "VICS-Rewrite\haloFunctions.sqf";
execVM "VICS-Rewrite\pmcFunctions.sqf";
execVM "VICS-Rewrite\buildingFunctions.sqf";
_playerFunctions = execVM "VICS-Rewrite\playerFunctions.sqf";
waitUntil {scriptDone _playerFunctions};
[] call vics_ply_load;
[] call vics_ply_modCheck;
[] call vics_ply_redeployMenu;
[] call vics_ply_addKeyEH;
[] call vics_ply_solarBattery;
if (player getVariable ["isSneaky",false]) then {
    [player] execVM "INC_undercover\Scripts\initUCR.sqf";
};

if (player getVariable ["copConstruct",false]) then {
  [] call vics_ply_addCOPOption;
};

if (player getVariable ["pbConstruct",false]) then {
  [] call vics_ply_addPBOption;
};

if (player getVariable ["suppliesOrder",false]) then {
  [] call vics_ply_addSuppliesOption;
};

[
    ["UpdateButtons",["Join Us","https://discord.gg/GxDFpg2nWC"]]
] call (missionNameSpace getVariable ["DiscordRichPresence_fnc_update",{}]);

uiSleep 10;

execVM "LevelUp\LevelUpMainLoop.sqf";
execVM "LevelUp\loadStats.sqf";
