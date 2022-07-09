
vics_sys_debugEnemyPresence = {
  _toggle = profileNameSpace getVariable "enemy_presence_toggle";
  if (isNil "_toggle") then {
    _toggle = 0;
  };
  _toggle;
  if (_toggle == 0) then {
    _toggle = 1;
    [] call vics_obj_debugEnemyPresence;
  } else {
    _toggle = 0;
  };
  debugEnemyPresence = _toggle;
  profileNameSpace setVariable ["enemy_presence_toggle",_toggle];
  publicVariableServer "debugEnemyPresence";
  true;
};

vics_sys_debugObjWeight = {
  _toggle = profileNameSpace getVariable "obj_weight_toggle";
  if (isNil "_toggle") then {
    _toggle = 0;
  };
  _toggle;
  if (_toggle == 0) then {
    _toggle = 1;
    [] call vics_obj_debugObjWeight;
  } else {
    _toggle = 0;
  };
  debugObjWeight = _toggle;
  profileNameSpace setVariable ["obj_weight_toggle",_toggle];
  publicVariableServer "debugObjWeight";
  true;
};

vics_sys_nearestPlayer = {
  params ["_pos"];
  _closestPlayerArray = [allPlayers, [], {_pos distance2D (getPos (_x))}, "ASCEND"] call bis_fnc_sortBy;
  _closestPlayer = _closestPlayerArray select 0;
  if ((_closestPlayer distance2d _pos) > 300) then {
    _closestPlayer = nil;
  };
  _closestPlayer;
};

vics_sys_playersClose = {
  params ["_pos","_radius"];
  _playerClose = [];
  {
  if ((_x distance _pos) < _radius) then {
    _playerClose pushback _x;
  };
  }foreach allPlayers;
  _playerClose;
};


vics_sys_debugEconValues = {
  _objectivesSaved = profileNameSpace getVariable (missionPrefix + "objectivesSaved");
  _opforForcePool = profileNameSpace getVariable (missionPrefix + "opforForcePool");
  _opforMorale = profileNameSpace getVariable (missionPrefix + "opforMorale");
  _opforGroups = profileNameSpace getVariable (missionPrefix + "opforGroups");
  _aiLimit = profileNameSpace getVariable (missionPrefix + "aiLimit");
  _civMorale = profileNameSpace getVariable [(missionPrefix + "civMorale"),0];
//
  _opforObjs = 0;
  _bluforObjs = 0;
  _uncappedObjs = 0;
  _totalObjs = (count _objectivesSaved);
  {
    _objectiveCaptured = _x select 2 select 0;
    if (_objectiveCaptured == "opfor") then {
      _opforObjs = _opforObjs + 1;
    };
    if (_objectiveCaptured == "blufor") then {
      _bluforObjs = _bluforObjs + 1;
    };
    if (_objectiveCaptured == "none") then {
      _uncappedObjs = _uncappedObjs + 1;
    };
  }forEach _objectivesSaved;
  _opforObjs;
  _bluforObjs;
  _uncappedObjs;
//
  _opforGroupsCount = (count _opforGroups);
  _unitsCount = 0;
  {
    _group = _x select 0;
    _units = units _group;
    _unitsCount = _unitsCount + (count _units);
  }forEach _opforGroups;
  _unitsCount;
//
  _serverFPS = diag_fps;
  _objectiveDebugText = format ["Opfor: %2/%1 - Blufor %3/%1 - Uncapped: %4/%1",_totalObjs,_opforObjs,_bluforObjs,_uncappedObjs];
  _opforEconDebugText = format ["Groups: %1/%5 - Units: %2 Morale: %3 ForcePool: %4",_opforGroupsCount,_unitsCount,_opforMorale,_opforForcePool,_aiLimit];
  _serverDebugText = format ["Server: %1",_serverFPS];
  _civDebug = format ["Morale: %1",_civMorale];
  [_objectiveDebugText, "VICS_Obj", true] call vics_sys_debug;
  [_opforEconDebugText, "VICS_Opfor", true] call vics_sys_debug;
  [_serverDebugText, "VICS_Sys", true] call vics_sys_debug;
  [_civDebug,"VICS_Civ",true] call vics_sys_debug;
};

vics_sys_debugObjectives = {

};




vics_sys_save = {
  _aiPersist = [] call vics_opfor_persist;
  waitUntil {_aiPersist isEqualTo true};
  [] call vics_sys_timePersist;
  [] call vics_sys_userMarkersSave;
  [] call vics_sys_vehPersistNew;
  //[] call vics_pmc_balSave;
  [] call vics_sys_cratePersist;
  //call vics_sys_buildingDamageSave;
  [] call vics_ied_save;
  [] call vics_sys_verifyBagSave;
  [] spawn vics_hvt_saveHVTs;
  _hotZonesDetection = [] call vics_obj_hotzones;
  waitUntil {_hotZonesDetection isEqualTo true};
  saveProfileNameSpace;
  ["Game state saved!", "VICS_Sys", true] call vics_sys_debug;
  true;
};

vics_sys_saveQuit = {
  _saveState = [] call vics_sys_save;
  waitUntil {_saveState isEqualTo true};
  [] remoteExec ["vics_ply_playerExit",0];
};

vics_sys_timePersist = {
  _dateToSave = date;
  profileNameSpace setVariable [(missionPrefix + "savedDate"),_dateToSave];
  ["Date and time saved", "VICS_Sys", true] call vics_sys_debug;
};

vics_sys_timeLoad = {
  _dateSaved = profileNameSpace getVariable (missionPrefix + "savedDate");
  if (isNil "_dateSaved") then {

  } else {
    setDate _dateSaved;
    ["Date and time loaded", "VICS_Sys", true] call vics_sys_debug;
  };
};

vics_sys_saveWipe = {
  _profileVars = [
    "objectivesSaved",
    "objectiveMarkers",
    "opforGroups",
    "opforGroupsSaved",
    "opforFobs",
    "aiLimit",
    "opforForcePool",
    "opforMorale",
    "savedDate",
    "availableMissions",
    "activeMissions",
    "srtcurrentIntel",
    "infantrycurrentIntel",
    "savedVehs",
    "opforMissionPlan",
    "opforVehPool",
    "aiLimit",
    "pmcUnitBalance",
    "userMarkers",
    "savedCrates",
    "createdFobs",
    "usedFobNames",
    "allIEDSaved",
    "civMorale",
    "forestLocationArray",
    "drugProductionTasks",
    "opforFunds",
    "allBackpacks",
    "intelValue",
    "commandCredits",
    "allTrashSaved"
    ];
  {
    profileNameSpace setVariable [(missionPrefix + _x),nil];
  }forEach _profileVars;
  _allMissionSaves = profileNameSpace getVariable "allMissionSaves";
  if (missionPrefix in _allMissionSaves) then {
    _prefixIndex = _allMissionSaves find missionPrefix;
    _allMissionSaves = _allMissionSaves deleteAt _prefixIndex;
  };
  ["Save wiped - Restart game to start a new campaign","VICS_SYS",true] call vics_sys_debug;
};

vics_sys_userMarkersSave = {
  _userMarkers = profileNameSpace getVariable (missionPrefix + "userMarkers");
  if (isNil "_userMarkers") then {
    _userMarkers = [];
    profileNameSpace setVariable [(missionPrefix + "userMarkers"),_userMarkers];
  };
  _newUserMarkers = [];
  _mapMarkers = allMapMarkers;
  _userMarkers;
  {
    _marker = _x;
    _markerStr = _marker call BIS_fnc_markerToString;
    _userMarkerBool = ["user",_markerStr,false] call bis_fnc_inString;
    if (_userMarkerBool isEqualTo true) then {
      _newUserMarkers pushBack _markerStr;
    };
  }forEach _mapMarkers;
  profileNameSpace setVariable [(missionPrefix + "userMarkers"),_newUserMarkers];
  ["Markers saved.","VICS_SYS",true] call vics_sys_debug;
};

vics_sys_userMarkersLoad = {
  _userMarkers = profileNameSpace getVariable (missionPrefix + "userMarkers");
  if (isNil "_userMarkers") then {
    _userMarkers = [];
    profileNameSpace setVariable [(missionPrefix + "userMarkers"),_userMarkers];
  };
  _userMarkers;
  {
    _x call BIS_fnc_stringToMarker;
  }forEach _userMarkers;
  ["Markers loaded.","VICS_SYS",true] call vics_sys_debug;
};

vics_sys_buildingChanged = {
  params ["_old","_new","_ruin"];
  _buildingChanged = missionNameSpace getVariable ["buildingChangedArray",[]];
  if (_ruin) then {
    _posATL = getPosATL _new;
    _dmg = 1;
    _buildingChanged pushBack [_posATL,_dmg];
  };
  _buildingChanged;
  missionNameSpace setVariable ["buildingChangedArray",_buildingChanged];
};


vics_sys_buildingDamageSave = {
  _enterableBuildings = missionNameSpace getVariable "enterableBuildings";
  _buildingChanged = missionNameSpace getVariable ["buildingChangedArray",[]];
  _buildingDamage = [];
  {
    _damageValue = getDammage _x;
    if (_damageValue > 0.25) then {
      _posATL = getPosATL _x;
      _buildingDamage pushBack [_posATL,_damageValue];
    };
  }forEach _enterableBuildings;
  _buildingDamage append _buildingChanged;
  profileNameSpace setVariable [(missionPrefix + "buildingDamage"),_buildingDamage];
};

vics_sys_buildingDamageLoad = {
  _buildingDamage = profileNameSpace getVariable (missionPrefix + "buildingDamage");
  {
    _buildingPos = _x select 0;
    _damageState = _x select 1;
    //_nearBuildings = nearestObjects [_buildingPos, ["House","Camp"], 30];
    _nearestBuilding = nearestObject _buildingPos;
    systemChat str _buildingPos;
    _nearestBuilding setDamage [_damageState,false];
  }forEach _buildingDamage;
};


TAG_fnc_getContents = {
	params[ "_container" ];

  private _cargo = [
 weaponsItemsCargo _container call BIS_fnc_consolidateArray,
 ( itemCargo _container select{ !( toLowerANSI( _x call BIS_fnc_itemType select 1 ) in [ "backpack", "uniform", "vest" ] ) } ) call BIS_fnc_consolidateArray,
 magazinesAmmoCargo _container call BIS_fnc_consolidateArray
];

private _containerCargo = everyContainer _container;
{
 _x params[ "_type", "_object" ];

 _containerCargo set[ _forEachIndex, [ _type, _object call TAG_fnc_getContents ]];
}forEach _containerCargo;
_invToSave = [_cargo, _containerCargo];
_invToSave;
};


TAG_fnc_setContents = {
 params[ "_container", "_contents" ];
 _contents params[ "_cargo", "_containers" ];

 {
  _x params[ "_cont", "_contents" ];

  _every = everyContainer _container;
  if ( _cont call BIS_fnc_itemType select 1 == "backpack" ) then {
   _container addBackpackCargoGlobal[ _cont, 1 ];
  }else{
   _container addItemCargoGlobal[ _cont, 1 ];
  };
  _addedContainer = ( everyContainer _container - _every ) select 0 select 1;

  clearItemCargoGlobal _addedContainer;
  clearWeaponCargoGlobal _addedContainer;
  clearBackpackCargoGlobal _addedContainer;
  clearMagazineCargoGlobal _addedContainer;

  [ _addedContainer, _contents ] call TAG_fnc_setContents;
 }forEach _containers;

 _fnc_addContents = {
  params[ "_index", "_details", "_count" ];

  switch ( _index ) do {
   //weapons
   case ( 0 ) : {
    _container addWeaponWithAttachmentsCargoGlobal[ _details, _count ];
   };
   //items
   case ( 1 ) : {
    _container addItemCargoGlobal[ _details, _count ];
   };
   //magazines
   case ( 2 ) : {
    _details params[ "_mag", "_ammo" ];

    _container addMagazineAmmoCargo[ _mag, _count, _ammo ];
   };
  };
 };

 {
  private _index = _forEachIndex;
  {
   _x params[ "_item", "_count" ];

   [ _index, _item, _count ] call _fnc_addContents;
  }forEach _x;
 }forEach _cargo;
};



vics_sys_vehPersistNew = {
  _syncedObjects = synchronizedObjects vehPersist;
  _deadVehs = profileNameSpace getVariable [(missionPrefix + "deadVehs"),[]];
  _vehsArray = [];
  {
    _veh = _x;
    _vehVar = vehicleVarName _x;
    //_vehType = typeOf _veh;
    _vehPos = getPosATL _veh;
    _vehdir = getDir _veh;
    _vehFuel = fuel _veh;
    _vehHitPoints = getAllHitPointsDamage _veh;
    _vehAmmoArray = magazinesAllTurrets _veh;
    _vehInventory = [_veh] call TAG_fnc_getContents;
    _vehSave = [];
    if (alive _veh) then {
      _vehSave = [_vehVar,_vehPos,_vehdir,_vehFuel,_vehHitPoints,_vehInventory,_vehAmmoArray,true];
    } else {
      _vehSave = [_vehVar,_vehPos,_vehdir,_vehFuel,_vehHitPoints,_vehInventory,_vehAmmoArray,false];
      _deadVehs pushBackUnique _vehVar;
    };
    _vehSave;
    _vehsArray pushBackUnique _vehSave;

  }forEach _syncedObjects;
  _vehsArray;
  _deadVehs;
  _vehPersistDebug = format ["Vehs: %1",_vehsArray];
  [_vehPersistDebug,"VICS_SYS",true] call vics_sys_debug;
  profileNameSpace setVariable [(missionPrefix + "savedVehs"),_vehsArray];
  profileNameSpace setVariable [(missionPrefix + "deadVehs"),_deadVehs];
};

vics_sys_vehLoadNew = {
  [] spawn {
    _syncedObjects = synchronizedObjects vehPersist;
    _savedVehs = profileNameSpace getVariable (missionPrefix + "savedVehs");
    _deadVehs = profileNameSpace getVariable [(missionPrefix + "deadVehs"),[]];
    if (isNil "_savedVehs") then {
      _savedVehs = [];
    };
    _savedVehs;
    _loadedVics = [];
    {
      _veh = missionNameSpace getVariable [_x, objNull];
      if (_veh in _syncedObjects) then {
        deleteVehicle _veh;
      };
      uiSleep 0.01;
    }forEach _deadVehs;

    {
      _veh = missionNameSpace getVariable [(_x select 0), objNull];
      _veh enableSimulationGlobal false;
      _veh allowDamage false;
      _veh hideObjectGlobal true;
    }forEach _savedVehs;

    {
      _veh = missionNameSpace getVariable [(_x select 0), objNull];
      if (_veh in _syncedObjects) then {
        _vehAlive = _x select 7;
        if (isNil "_vehAlive") then {
          _vehAlive = true;
        };
        _vehAlive;
        if (_vehAlive isEqualTo true) then {
          _loadedVics pushBack _veh;
          clearItemCargoGlobal _veh;
          clearMagazineCargoGlobal _veh;
          clearWeaponCargoGlobal _veh;
          clearBackpackCargoGlobal _veh;
          _vehPos = _x select 1;
          _vehDir = _x select 2;
          _vehFuel = _x select 3;
          _vehHitPoints = _x select 4;
          _vehInventory = _x select 5;
          _vehAmmoArray = _x select 6;
          _vehHitPointsName = _vehHitPoints select 0;
          _veh setDir _vehDir;
          _veh setPosATL _vehPos;
          _veh setFuel _vehFuel;
          {
            _hitPointName = _x;
            _hitPointDamage = _vehHitPoints select 2 select _forEachIndex;
            _veh setHitPointDamage [_hitPointName, _hitPointDamage, false];
          }forEach _vehHitPointsName;
          ///Vehicle inventory Load
          [_veh, _vehInventory] call TAG_fnc_setContents;

          if !(isNil "_vehAmmoArray") then {
            _veh setVehicleAmmo 0;
            _vehAmmoCurrent = magazinesAllTurrets _veh;
            {
              _magClassCur = _x select 0;
              _turretArrayCur = _x select 1;
              _veh removeMagazinesTurret [_magClassCur,_turretArrayCur];
            }foreach _vehAmmoCurrent;
            {
              _magClass = _x select 0;
              _turretArray = _x select 1;
              _ammoCount = _x select 2;
              if (_ammoCount > 0) then {
                _veh addMagazineTurret [_magClass, _turretArray, _ammoCount];
              };
            }forEach _vehAmmoArray;
          };
          _veh enableSimulationGlobal true;
          _veh allowDamage true;
          _veh hideObjectGlobal false;
        } else {
          deleteVehicle _veh;
        };
      };
      uiSleep 0.01;
    }forEach _savedVehs;

    {
      _x enableSimulationGlobal true;
      _x allowDamage true;
      _x hideObjectGlobal false;
    }forEach _loadedVics;
  };
  true;
};


vics_sys_vehPersist = {
  _syncedObjects = synchronizedObjects vehPersist;
  _deadVehs = profileNameSpace getVariable [(missionPrefix + "deadVehs"),[]];
  _vehsArray = [];
  {
    _veh = _x;
    _vehVar = vehicleVarName _x;
    //_vehType = typeOf _veh;
    _vehPos = getPosATL _veh;
    _vehdir = getDir _veh;
    _vehFuel = fuel _veh;
    _vehHitPoints = getAllHitPointsDamage _veh;
    _magazinesCargo = getMagazineCargo _veh;
    _vehCustomization = [_veh] call BIS_fnc_getVehicleCustomization;
    if (isNil "_magazinesCargo") then {
      _magazinesCargo = [];
    };
    _itemsCargo = getItemCargo _veh;
    if (isNil "_itemsCargo") then {
      _itemsCargo = [];
    };
    _weaponsCargo = getWeaponCargo _veh;
    if (isNil "_weaponsCargo") then {
      _weaponsCargo = [];
    };
    _backpacksCargo = getBackpackCargo _veh;
    if (isNil "_backapcksCargo") then {
      _backapcksCargo = [];
    };
    _backpackItemCargo = [];
    _backpacksSelectable = _backpacksCargo select 0;

    {

    }forEach _backpacksSelectable;
    _vehAmmoArray = magazinesAllTurrets _veh;
    _vehInventory = [_magazinesCargo,_itemsCargo,_weaponsCargo,_backpacksCargo];
    _vehSave = [];
    if (alive _veh) then {
      _vehSave = [_vehVar,_vehPos,_vehdir,_vehFuel,_vehHitPoints,_vehInventory,_vehAmmoArray,true,_vehCustomization];
    } else {
      _vehSave = [_vehVar,_vehPos,_vehdir,_vehFuel,_vehHitPoints,_vehInventory,_vehAmmoArray,false,_vehCustomization];
      _deadVehs pushBackUnique _vehVar;
    };
    _vehSave;
    _vehsArray pushBackUnique _vehSave;

  }forEach _syncedObjects;
  _vehsArray;
  _deadVehs;
  _vehPersistDebug = format ["Vehs: %1",_vehsArray];
  [_vehPersistDebug,"VICS_SYS",true] call vics_sys_debug;
  profileNameSpace setVariable [(missionPrefix + "savedVehs"),_vehsArray];
  profileNameSpace setVariable [(missionPrefix + "deadVehs"),_deadVehs];
};

vics_sys_vehLoad = {
  [] spawn {
    _syncedObjects = synchronizedObjects vehPersist;
    _savedVehs = profileNameSpace getVariable (missionPrefix + "savedVehs");
    _deadVehs = profileNameSpace getVariable [(missionPrefix + "deadVehs"),[]];
    if (isNil "_savedVehs") then {
      _savedVehs = [];
    };
    _savedVehs;
    _loadedVics = [];
    {
      _veh = missionNameSpace getVariable [_x, objNull];
      if (_veh in _syncedObjects) then {
        deleteVehicle _veh;
      };
      uiSleep 0.01;
    }forEach _deadVehs;

    {
      _veh = missionNameSpace getVariable [(_x select 0), objNull];
      _veh enableSimulationGlobal false;
      _veh allowDamage false;
      _veh hideObjectGlobal true;
    }forEach _savedVehs;

    {
      _veh = missionNameSpace getVariable [(_x select 0), objNull];
      if (_veh in _syncedObjects) then {
        _vehAlive = _x select 7;
        if (isNil "_vehAlive") then {
          _vehAlive = true;
        };
        _vehAlive;
        if (_vehAlive isEqualTo true) then {
          _loadedVics pushBack _veh;
          clearItemCargoGlobal _veh;
          clearMagazineCargoGlobal _veh;
          clearWeaponCargoGlobal _veh;
          clearBackpackCargo _veh;
          _vehPos = _x select 1;
          _vehDir = _x select 2;
          _vehFuel = _x select 3;
          _vehHitPoints = _x select 4;
          _vehInventory = _x select 5;
          _vehAmmoArray = _x select 6;
          _vehHitPointsName = _vehHitPoints select 0;
          _vehCustomization = _x select 8;
          _veh setDir _vehDir;
          _veh setPosATL _vehPos;
          _veh setFuel _vehFuel;
          {
            _hitPointName = _x;
            _hitPointDamage = _vehHitPoints select 2 select _forEachIndex;
            _veh setHitPointDamage [_hitPointName, _hitPointDamage, false];
          }forEach _vehHitPointsName;
          ///Vehicle inventory Load
          _magazinesSelectable = _vehInventory select 0;
          if (isNil "_magazinesSelectable") then {
            _magazinesSelectable = [];
          };
          _itemsSelectable = _vehInventory select 1;
          if (isNil "_itemsSelectable") then {
            _itemsSelectable = [];
          };
          _weaponsSelectable = _vehInventory select 2;
          if (isNil "_weaponsSelectable") then {
            _weaponsSelectable = [];
          };
          _backpacksSelectable = _vehInventory select 3;
          if (isNil "_backpacksSelectable") then {
            _backpacksSelectable = [];
          };
          _magazineSelection = _magazinesSelectable select 0;
          _itemSelection = _itemsSelectable select 0;
          {
            _magToAdd = _x;
            _amountMagToAdd = _magazinesSelectable select 1 select _forEachIndex;
            _veh addMagazineCargoGlobal [_magToAdd,_amountMagToAdd];
          }forEach _magazineSelection;
          {
            _itemToAdd = _x;
            _amountItemToAdd = _itemsSelectable select 1 select _forEachIndex;
            _veh addItemCargoGlobal [_itemToAdd,_amountItemToAdd];
          }forEach (_itemsSelectable select 0);
          {
            _weaponToAdd = _x;
            _amountWeaponToAdd = _weaponsSelectable select 1 select _forEachIndex;
            _veh addWeaponCargoGlobal [_weaponToAdd, _amountWeaponToAdd];
          }forEach (_weaponsSelectable select 0);
          {
            _backpackToAdd = _x;
            _amountBackpackToAdd = _backpacksSelectable select 1 select _forEachIndex;
            _veh addBackpackCargoGlobal [_backpackToAdd, _amountBackpackToAdd];
          }forEach (_backpacksSelectable select 0);
          if !(isNil "_vehAmmoArray") then {
            _veh setVehicleAmmo 0;
            _vehAmmoCurrent = magazinesAllTurrets _veh;
            {
              _magClassCur = _x select 0;
              _turretArrayCur = _x select 1;
              _veh removeMagazinesTurret [_magClassCur,_turretArrayCur];
            }foreach _vehAmmoCurrent;
            {
              _magClass = _x select 0;
              _turretArray = _x select 1;
              _ammoCount = _x select 2;
              if (_ammoCount > 0) then {
                _veh addMagazineTurret [_magClass, _turretArray, _ammoCount];
              };
            }forEach _vehAmmoArray;
          };
          [_veh,(_vehCustomization select 0),(_vehCustomization select 1)] call BIS_fnc_initVehicle;
          _veh enableSimulationGlobal true;
          _veh allowDamage true;
          _veh hideObjectGlobal false;
        } else {
          deleteVehicle _veh;
        };
      };
      uiSleep 0.01;
    }forEach _savedVehs;

    {
      _x enableSimulationGlobal true;
      _x allowDamage true;
      _x hideObjectGlobal false;
    }forEach _loadedVics;
  };
  true;
};

vics_sys_cleanup = {
  _dead = allDeadMen;
  if ((count _dead) >= cleanupDead) then {
    _playerClose = [];
    {
      _body = _x;
      if ((getNumber(configfile >> "CfgVehicles" >> typeOf _body >> "side") == 1) && (cleanupFriendlies isEqualTo false)) then {
        ["Friendly Body Found","VICS_SYS",true] call vics_sys_debug;
      } else {
        _position = getPos _body;
        {
        if ((_x distance _position) < cleanupDistance) then {
          _playerClose pushback _x;
        };
        } foreach allPlayers;
        _playerClose;
        if ((count _playerClose) == 0) then {
          deleteVehicle _body;
        };
      };
    }forEach _dead;
  };
  ["cleanup Finished","VICS_SYS",true] call vics_sys_debug;
  true;
};

vics_sys_baseDefense = {
  {
    _blackListMarker = _x;
    _playersInBase = [];
    {
      _player = _x;
      if ((getPos _player) inArea _blackListMarker) then {
        _playersInBase pushBack _player;
      };
    }forEach allPlayers;
    _playersInBase;
    if ((count _playersInBase) == 0) then {
      _opfor = [];
      {
        if (((side _x) == east) && ((getPos _x) inArea _blackListMarker)) then {
          _opfor pushBack _x;
        };
      }forEach allUnits;
      _opfor;
      {
        deleteVehicle _x;
      }forEach _opfor;
    };
  }forEach objectiveOffwhiteList;
  true;
};


vics_sys_cratePersist = {
  _syncedObjects = synchronizedObjects cratePersist;
  _cratesArray = [];
  {
    _crate = _x;
    _crateVar = str _x;
    _cratePos = getPosATL _crate;
    _cratedir = getDir _crate;
    _magazinesCargo = getMagazineCargo _crate;
    if (isNil "_magazinesCargo") then {
      _magazinesCargo = [];
    };
    _itemsCargo = getItemCargo _crate;
    if (isNil "_itemsCargo") then {
      _itemsCargo = [];
    };
    _weaponsCargo = getWeaponCargo _crate;
    if (isNil "_weaponsCargo") then {
      _weaponsCargo = [];
    };
    _backpacksCargo = getBackpackCargo _crate;
    if (isNil "_backapcksCargo") then {
      _backapcksCargo = [];
    };
    _crateInventory = [_magazinesCargo,_itemsCargo,_weaponsCargo,_backpacksCargo];
    _crateSave = [_crateVar,_cratePos,_cratedir,_crateInventory];
    _cratesArray pushBackUnique _crateSave;
  }forEach _syncedObjects;
  _cratesArray;
  profileNameSpace setVariable [(missionPrefix + "savedCrates"),_cratesArray];
};

vics_sys_crateLoad = {
  [] spawn {
    _savedCrates = profileNameSpace getVariable (missionPrefix + "savedCrates");
    if (isNil "_savedCrates") then {
      _savedCrates = [];
    };
    _savedCrates;
    {
      _crate = missionNameSpace getVariable [(_x select 0), objNull];
      _crate enableSimulationGlobal false;
      _crate allowDamage false;
      _cratePos = _x select 1;
      _crateDir = _x select 2;
      _crate setDir _crateDir;
      _crate setPosATL _cratePos;
      clearItemCargoGlobal _crate;
      clearMagazineCargoGlobal _crate;
      clearWeaponCargoGlobal _crate;
      clearBackpackCargo _crate;
      _allSelectable = _x select 3;
      _magazinesSelectable = _allSelectable select 0;
      if (isNil "_magazinesSelectable") then {
        _magazinesSelectable = [];
      };
      _itemsSelectable = _allSelectable select 1;
      if (isNil "_itemsSelectable") then {
        _itemsSelectable = [];
      };
      _weaponsSelectable = _allSelectable select 2;
      if (isNil "_weaponsSelectable") then {
        _weaponsSelectable = [];
      };
      _backpacksSelectable = _allSelectable select 3;
      if (isNil "_backpacksSelectable") then {
        _backpacksSelectable = [];
      };
        _magazineSelection = _magazinesSelectable select 0;
        _itemSelection = _itemsSelectable select 0;
        {
          _magToAdd = _x;
          _amountMagToAdd = _magazinesSelectable select 1 select _forEachIndex;
          _crate addMagazineCargoGlobal [_magToAdd,_amountMagToAdd];
        }forEach _magazineSelection;
        {
          _itemToAdd = _x;
          _amountItemToAdd = _itemsSelectable select 1 select _forEachIndex;
          _crate addItemCargoGlobal [_itemToAdd,_amountItemToAdd];
        }forEach (_itemsSelectable select 0);
        {
          _weaponToAdd = _x;
          _amountWeaponToAdd = _weaponsSelectable select 1 select _forEachIndex;
          _crate addWeaponCargoGlobal [_weaponToAdd, _amountWeaponToAdd];
        }forEach (_weaponsSelectable select 0);
        {
          _backpackToAdd = _x;
          _amountBackpackToAdd = _backpacksSelectable select 1 select _forEachIndex;
          _crate addBackpackCargoGlobal [_backpackToAdd, _amountBackpackToAdd];
        }forEach (_backpacksSelectable select 0);

      uiSleep 0.01;
      _crate enableSimulationGlobal true;
    }forEach _savedCrates;
  };
};

vics_sys_tentCreate = {
  params ["_playerPos","_playerDir","_UID","_playerObject"];
  _tentComp = ["playerTent",_playerPos,[0,0,0],_playerDir,True,false,False] call LARs_fnc_spawnComp;
  _tentObjectArray = [_tentComp] call LARs_fnc_getCompObjects;
  _tentObject = _tentObjectArray select 0;
  _tentObject setVariable [(missionPrefix + "tentOwner"), _UID, true];
  _returnArray = [_tentObjectArray,_tentObject];
  //_playerObject setVariable ["tentObject",_returnArray,true];
};

vics_sys_tentUpdate = {
  params ["_tentArray",["_remove",false]];
  _tentsSaved = profileNameSpace getVariable (missionPrefix + "tentsSaved");
  if (isNil "_tentsSaved") then {
    _tentsSaved = [];
  };
  _tentsSaved;
  if (_remove) then {
    _index = _tentsSaved find _tentArray;
    _tentsSaved deleteAt _index;
  } else {
    _tentsSaved pushBack _tentArray;
  };
  profileNameSpace setVariable [(missionPrefix + "tentsSaved"),_tentsSaved];
};

vics_sys_tentSave = {

};

vics_sys_tentLoad = {
  _tentsSaved = profileNameSpace getVariable (missionPrefix + "tentsSaved");
  if (isNil "_tentsSaved") then {
    _tentsSaved = [];
  };
  _tentsSaved;
  {
    _tentArray = _x;
    _tentPos = _tentArray select 0;
    _tentDir = _tentArray select 1;
    _tentOwner = _tentArray select 2;
    _tentComp = ["playerTent",_tentPos,[0,0,0],_tentDir,True,false,False] call LARs_fnc_spawnComp;
    _tentObjectArray = [_tentComp] call LARs_fnc_getCompObjects;
    _tentObject = _tentObjectArray select 0;
    _tentObject setVariable [(missionPrefix + "tentOwner"), _tentOwner, true];
  }forEach _tentsSaved;
};

vics_sys_isDay = {
  //Check if daytime or not
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

vics_sys_toggleStreetlights = {
  params ["_pos",["_onOff",false],["_radius",objectiveSizeMultiplier]];
  _lampTypes = [
    "Lamps_Base_F",
    "Land_LampAirport_F",
    "Land_LampSolar_F",
    "Land_LampStreet_F",
    "Land_LampStreet_small_F",
    "PowerLines_base_F",
    "Land_LampDecor_F",
    "Land_LampHalogen_F",
    "Land_LampHarbour_F",
    "Land_LampShabby_F",
    "Land_PowerPoleWooden_L_F",
    "Land_NavigLight",
    "Land_runway_edgelight",
    "Land_runway_edgelight_blue_F",
    "Land_Flush_Light_green_F",
    "Land_Flush_Light_red_F",
    "Land_Flush_Light_yellow_F",
    "Land_Runway_PAPI",
    "Land_Runway_PAPI_2",
    "Land_Runway_PAPI_3",
    "Land_Runway_PAPI_4",
    "Land_fs_roof_F", // Fuel station roof lights
    "Land_fs_sign_F",
    "Land_Lamp_Small_EP1",
    "Land_Lamp_Street2_EP1",
    "Land_PowLines_Conc2L_EP1",
    "Land_Lampa_ind"
  ];
  _damage = 0;
  if (_onOff) then {
    _damage = 0;
  } else {
    _damage = 0.95;
  };
  _damage;
  {
    _lampClass = _x;
     _lamps = _pos nearObjects [_lampClass, _radius];
     {
       _lampObject = _x;
       _lampObject setDamage _damage;
       diag_log "Lights out!";
       } forEach _lamps;
  }forEach _lampTypes;
};

vics_sys_persistBag = {
  params ["_bagClass","_bagPos","_backpackInventory","_gwh","_unit","_ident"];
  _allBackpacks = profileNameSpace getVariable [(missionPrefix + "allBackpacks"),[]];
  _backpackContainer = str (backpackContainer _unit);
  _backpackToSave = [_bagClass,_bagPos,_backpackInventory,_gwh,_backpackContainer,_ident];
  _allBackpacks pushBack _backpackToSave;
  profileNameSpace setVariable [(missionPrefix + "allBackpacks"),_allBackpacks];
};

vics_sys_loadBags = {
  _allBackpacks = profileNameSpace getVariable [(missionPrefix + "allBackpacks"),[]];
  {
    _bagArray = _x;
    _bagClass = _bagArray select 0;
    _bagPos = _bagArray select 1;
    _allSelectable = _bagArray select 2;
    _bagIdent = _bagArray select 5;
    _weaponHolder = createVehicle ["GroundWeaponHolder_scripted",_bagPos,[],0,"CAN_COLLIDE"];
    _weaponHolder addBackpackCargoGlobal [_bagClass,1];
    _backpackCreated = (((everyContainer _weaponHolder) select 0) select 1);
    _backpackCreated setVariable ["backpackIdent",_bagIdent,true];

    //systemChat format ["%1 : %2 : %3 : %4",_bagClass,_bagPos,_weaponHolder,_backpackCreated];

    _magazinesSelectable = _allSelectable select 0;
    if (isNil "_magazinesSelectable") then {
      _magazinesSelectable = [];
    };
    _itemsSelectable = _allSelectable select 1;
    if (isNil "_itemsSelectable") then {
      _itemsSelectable = [];
    };
    _weaponsSelectable = _allSelectable select 2;
    if (isNil "_weaponsSelectable") then {
      _weaponsSelectable = [];
    };
    _backpacksSelectable = _allSelectable select 3;
    if (isNil "_backpacksSelectable") then {
      _backpacksSelectable = [];
    };
      _magazineSelection = _magazinesSelectable select 0;
      _itemSelection = _itemsSelectable select 0;
      {
        _magToAdd = _x select 0;
        _amountMagToAdd = _x select 1;
        _backpackCreated addMagazineAmmoCargo [_magToAdd,1,_amountMagToAdd];
        systemChat format ["%1 : %2",_magToAdd,_amountMagToAdd];
      }forEach _magazinesSelectable;
      {
        _itemToAdd = _x;
        _amountItemToAdd = _itemsSelectable select 1 select _forEachIndex;
        _backpackCreated addItemCargoGlobal [_itemToAdd,_amountItemToAdd];
      }forEach (_itemsSelectable select 0);
      {
        _weaponToAdd = _x;
        _amountWeaponToAdd = _weaponsSelectable select 1 select _forEachIndex;
        _backpackCreated addWeaponCargoGlobal [_weaponToAdd, _amountWeaponToAdd];
      }forEach (_weaponsSelectable select 0);
      {
        _backpackToAdd = _x;
        _amountBackpackToAdd = _backpacksSelectable select 1 select _forEachIndex;
        _backpackCreated addBackpackCargoGlobal [_backpackToAdd, _amountBackpackToAdd];
      }forEach (_backpacksSelectable select 0);


      _bagArray set [3,_weaponHolder];
      _bagArray set [4,_backpackCreated];
      _allBackpacks set [_forEachIndex,_bagArray];
  }forEach _allBackpacks;
  profileNameSpace setVariable [(missionPrefix + "allBackpacks"),_allBackpacks];
};

vics_sys_verifyBagSave = {
  _allBackpacks = profileNameSpace getVariable [(missionPrefix + "allBackpacks"),[]];
  _allBackpacksUpdated = [];
  {
    _nearestObjects = nearestObjects [(_x select 1), ["weaponholder"], 5];
    _nearestObjectsStr = [];
    _backpackContainers = [];
    _backpackContainer = nil;
    {
      _backpackContainer = firstBackpack  _x;
      if !(isNull _backpackContainer) then {
        _backpackIdent = _backpackContainer getVariable ["backpackIdent",0];
        _nearestObjectsStr pushBack _backpackIdent;
        _backpackContainers pushBack _backpackContainer;
      };
    }forEach _nearestObjects;
    diag_log str _nearestObjectsStr;
    diag_log (_x select 5);
    if ((_x select 5) in _nearestObjectsStr) then {
      _backpackIndex = (_nearestObjectsStr find (_x select 5));
      _backpackContainer = _backpackContainers select _backpackIndex;
      _magazinesCargo = magazinesAmmo _backpackContainer;
      if (isNil "_magazinesCargo") then {
        _magazinesCargo = [];
      };
      systemChat str _magazinesCargo;
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
      _x set [2,_backpackInventory];
      _allBackpacksUpdated pushBack _x;
      diag_log "Bag is still there!";
    };
  }forEach _allBackpacks;
  profileNameSpace setVariable [(missionPrefix + "allBackpacks"),_allBackpacksUpdated];
};

vics_sys_posInBlacklist = {
  params ["_pos","_blackListMarkers"];
  _inBlacklist = false;
  _blackListMarkers = objectiveOffwhiteList + objectiveSpawnBlacklist;
  {
    _blackListMarker = _x;
    if (_pos inArea _blackListMarker) then {
      _inBlacklist = true;
    };
    if (_inBlacklist isEqualTo true) exitWith {};
  }forEach _blackListMarkers;
  _inBlacklist;
};

vics_sys_playersNearPos = {
  params ["_pos","_distance"];
  _playerClose = [];
  {
  if ((_x distance _pos) < _distance) then {
    _playerClose pushback _x;
  };
  } foreach allPlayers;
  _playerClose;
};

vics_sys_countTime = {
  params ["_dateStart","_dateEnd"];
  _yearStart = _dateStart select 0;
  _monthStart = _dateStart select 1;
  _dayStart = _dateStart select 2;
  _hourStart = _dateStart select 3;
  _minStart = _dateStart select 4;
  _yearEnd = _dateEnd select 0;
  _monthEnd = _dateEnd select 1;
  _dayEnd = _dateEnd select 2;
  _hourEnd = _dateEnd select 3;
  _minEnd = _dateEnd select 4;
  _daysTotal = 0;
  for "_i" from _yearStart to (_yearEnd - 1) do
  {
  /*
  Definition of a leap year:
  - if year is dividable by 4, it is a leap year
  - if year is dividable by 100, it is NOT a leap year
  - if year is dividable by 400, it is a leap year
  - else, it is NOT a leap year
  */
  _isLeapYear = if(_i mod 4 == 0 && {_i mod 100 != 0 || _i mod 400 == 0}) then {true} else {false};
  if(_isLeapYear) then
  {
  _daysTotal = _daysTotal + 366;
  }
  else
  {
  _daysTotal = _daysTotal + 365;
  };
  };
  _isLeapYear = if(_yearStart mod 4 == 0 && {_yearStart mod 100 != 0 || _yearStart mod 400 == 0}) then {true} else {false};
  _daysSum = 0;
  _daysOfMonths = [31, if(_isLeapYear) then {29} else {28}, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31];
  {
  if(_monthStart isEqualTo (_forEachIndex + 1)) exitWith {};
  _daysSum = _daysSum - _x;
  } forEach _daysOfMonths;
  _isLeapYear = if(_yearEnd mod 4 == 0 && {_yearEnd mod 100 != 0 || _yearEnd mod 400 == 0}) then {true} else {false};
  _daysOfMonths = [31, if(_isLeapYear) then {29} else {28}, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31];
  {
  if(_monthEnd isEqualTo (_forEachIndex + 1)) exitWith {};
  _daysSum = _daysSum + _x;
  } forEach _daysOfMonths;
  //Adding one to include day of
  _daysTotal = _daysTotal - _dayStart + _dayEnd + _daysSum + 1;
  diag_log str _daysTotal;
  _daysTotal;
};

vics_sys_uncache = {
  params ["_units"];
  {
    _x enablesimulationglobal true;
		_x hideobjectglobal false;
  }forEach _units;
};

vics_sys_indoors = {
  params ["_position"];
  _aslPos = AGLToASL _position;
	lineIntersectsSurfaces [
		_aslPos,
		_aslPos vectorAdd [0, 0, 50],
		objNull, objNull, true, 1, "GEOM", "NONE"
	] select 0 params ["","","","_house"];
	if (!isnil "_house") exitWith { true };
	false;
};

vics_sys_debugNames = {
  _objectivesSaved = profileNameSpace getVariable (missionPrefix + "objectivesSaved");
  _totalNames = 0;
  _civNames = [];
  _duplicates = 0;
  _duplicateArray = [];
  {
    _selectedOBJ = _x;
    _extrasArray = _selectedOBJ select 7;
    _civIdentityArray = _extrasArray select 8;
    {
      _civName = _x select 0;
      diag_log _civName;
      if (_civName in _civNames) then {
        _duplicates = _duplicates + 1;
        _duplicateArray pushBack _civName;
      } else {
        _civNames pushBack _civName;
      };
      _totalNames = _totalNames + 1;
    }forEach _civIdentityArray;
  } forEach _objectivesSaved;
  systemChat ("Duplicate Names: "+ str _duplicates);
  diag_log str _duplicateArray;
  systemChat ("Total Names: " + str _totalNames);
};

vics_sys_generateNames = {
  _objectivesSaved = profileNameSpace getVariable (missionPrefix + "objectivesSaved");
  _totalNames = 0;
  _civNames = [];
  _duplicates = 0;
  _duplicateArray = [];
  {
    _selectedOBJ = _x;
    _extrasArray = _selectedOBJ select 7;
    _civIdentityArray = [];
    _objIndex = _objectivesSaved find _selectedOBJ;
    _group = createGroup [civilian, true];
    _units = [];
    for "_i" from 1 to 45 do {
      _unitToSpawn = selectRandom civilians;
      _createdUnit = _group createUnit [_unitToSpawn,[0,0,0],[],0,"CAN_COLLIDE"];
      _units pushBack _createdUnit;
      uiSleep 0.01;
    };
    uiSleep 0.01;
    {
      _civName = name _x;
      _civNames pushBack _civName;
      _civFace = face _x;
      diag_log _civName;
      _civIdentity = [_civName,_civFace];
      _civIdentityArray pushBackUnique _civIdentity;
      _duplicateArray pushBackUnique _civName;
      deleteVehicle _x;
    }forEach _units;
    deleteGroup _group;
    uiSleep 0.01;
    _extrasArray set [8,_civIdentityArray];
    _selectedOBJ set [7,_extrasArray];
    _objectivesSaved set [_objIndex, _selectedOBJ];
  } forEach _objectivesSaved;
  profileNameSpace setVariable [(missionPrefix + "objectivesSaved"),_objectivesSaved];
  systemChat str (count _civNames);
  systemChat str (count _duplicateArray);
  //diag_log str _duplicateArray;
  //systemChat ("Total Names: " + str _totalNames);
};
