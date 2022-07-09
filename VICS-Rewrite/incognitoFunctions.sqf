uniWhitelist = ["Project_BJC_PCU_Jean_blk3","U_BG_Guerilla2_1"];
vestWhitelist = [""];
backWhitelist = [""];
headWhitelist = [""];
faceWhitelist = [""];
nvgWhitelist = [""];
coveredCargoVehicles = ["UK3CB_TKC_B_SUV","C_Van_02_transport_F"];


vics_inc_init = {
  params ["_side","_unit"];
  _grp = createGroup [_side,true];
  [_unit] join _grp;
  [] spawn player_fnc_sideDebug;
};

player_fnc_sideDebug = {
  _side = side player;
  systemChat format ["Side: %1",_side];
};


vics_inc_incognitoCheck = {
  [] spawn {
    while {true} do {
      _uni = uniform player;
      _vest = vest player;
      _backpack = backpack player;
      _headgear = headgear player;
      _curWeapon = currentWeapon player;
      _goggles = goggles player;
      _nvg = hmd player;
      _priWeapon = primaryWeapon player;
      _secWeapon = secondaryWeapon player;
      _thirdWeapon = handgunWeapon player;
      _playerSide = side player;
      if (vehicle player == player) then {
        if (_curWeapon == "") then {
          //systemChat "No weapon in hand";
          if ((_priWeapon == "") && (_secWeapon == "")) then {
            //systemChat "No weapon on back";
            if ((_uni in uniWhitelist) && (_vest in vestWhitelist) && (_backpack in backWhitelist)) then {
              //systemChat "Gear stages cleared";
              if ((_headgear in headWhitelist) && (_goggles in faceWhitelist) && (_nvg in nvgWhitelist)) then {
                //systemChat "Headgear cleared";
                systemChat "Undercover active";
                player setVariable ["incognitoCheck",true];
                player setCaptive true;
              } else {
                //headgear check failed
                player setVariable ["incognitoCheck",false];
                player setCaptive false;
              };
            } else {
              //stage of gear not in whitelist and is equipped
              player setVariable ["incognitoCheck",false];
              player setCaptive false;
            };
          } else {
            //Primary or secondary weapon is equipped
            player setVariable ["incognitoCheck",false];
            player setCaptive false;
          };
        } else {
          //Weapon in hand
          player setVariable ["incognitoCheck",false];
          player setCaptive false;
        };
      } else {
        [] spawn vics_inc_vehicleCheck;
      };
      uiSleep 1;
    };
  };
};

vics_inc_vehicleCheck = {
  _veh = vehicle player;
  if (((typeOf _veh) in coveredCargoVehicles) && ((_veh getCargoIndex player) > 0)) then {
    systemChat "Player in cargo";
    player setVariable ["incognitoCheck",true];
    player setCaptive true;
  };
};

vics_inc_enemyKnowsAbout = {
  _knowsAbout = east knowsAbout player;
  systemChat format ["%1",_knowsAbout];
};

vics_inc_buildWhitelist = {
  _uni = uniform player;
  _vest = vest player;
  _backpack = backpack player;
  _headgear = headgear player;
  _curWeapon = currentWeapon player;
  _goggles = goggles player;
  _nvg = hmd player;
  _loadout = [_uni,_vest,_backpack,_headgear,_goggles,_nvg];
  copyToClipboard str _loadout;
};
