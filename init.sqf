//[AiCacheDistance(players),TargetFPS(-1 for Auto),Debug,CarCacheDistance,AirCacheDistance,BoatCacheDistance]execvm "zbe_cache\main.sqf";
if (isServer) then {[1200,-1,false,1000,1500,1500]execvm "zbe_cache\main.sqf"};
["VICS MENU", "vicsMainMenuTablet"] call CBA_fnc_addPauseMenuOption;
if ((getPlayerUID player) isEqualTo "_SP_PLAYER_") then {
  [player] join grpNull;
  [
    ["UpdateDetails","Development mode active"],
    ["UpdateState","SQF isn't great"]
    ] call (missionNameSpace getVariable ["DiscordRichPresence_fnc_update",{}]);
};
execVM "VICS-Rewrite\debugFunctions.sqf";
execVM "VICS-Rewrite\dialogFunctions.sqf";
execVM "VICS-Rewrite\casFunctions.sqf";
execVM "CIV\interactFunctions.sqf";
0 setFog 0;
999999 setFog 0;
TCL_Debug = [False, False, False, False, False, False, False];
TCL_AI=[
  1,
  0.15,
  3,
  True,
  3,
  700,
  True,
  False,
  False,
  True,
  200,
  False
];
TCL_Feature=[
  True,
  5,
  True,
  True,
  60,
  True,
  75,
  True,
  1,
  True,
  15,
  True,
  50,
  True,
  50,
  True,
  75,
  40,
  60,
  True,
  70,
  50,
  True,
  15,
  50,
  300,
  700,
  True,
  0.90,
  5,
  True,
  50,
  True,
  50,
  True,
  5
];
TCL_IQ=[
  1,
  100,
  3
];
TCL_Radio=[True,30,[3000,5000,7000,10000,13000]];
TCL_System=[
  0,
  True,
  [EAST,RESISTANCE],
  True,
  True,
  True,
  5,
  True,
  0,
  False,
  False
];
TCL_Tweak=[
  0,
  50,
  50,
  0.5
];
TCL_Initialize = True;
