if (!isServer) exitWith {};
vics_ied_debug = {
  params [["_toggle",true]];
  _iedDebug = missionNameSpace getVariable ["iedDebug",[]];
  {
    deleteMarker _x;
  }forEach _iedDebug;
  if (_toggle) then {
    _allIEDs = profileNameSpace getVariable [(missionPrefix + "allIEDSaved"),[]];
    _debugMarkers = [];
    {
      _iedItem = _x select 1;
      _iedPos = _x select 2;
      _trashSpawn = _x select 3;
      _rotation = _x select 4;
      _ordnance = _x select 5;
      _debugTxt = format ["ORD: %1 - TRSH: %2 - OBJCT: %3",_ordnance,_trashSpawn,_iedItem];
      _debugMarker = createMarker [(str _iedPos),_iedPos];
      _debugMarker setMarkerType "hd_dot";
      _debugMarker setMarkerText _debugTxt;
      _debugMarkers pushBack _debugMarker;
    }forEach _allIEDs;
    missionNameSpace setVariable ["iedDebug",_debugMarkers];
  } else {

  };
};

vics_bomber_debug = {
  params [["_toggle",true]];
  [_toggle] spawn {
    params [["_toggle",true]];
    _bomberDebug = missionNameSpace getVariable ["bomberDebug",[]];
    _bomberMarkers = [];
    for "_i" from 1 to 60 do {

      uiSleep 1;
    };
  };
};



vics_ied_request = {
  [] spawn {
    _loopCount = 0;
    _allIEDs = profileNameSpace getVariable [(missionPrefix + "allIEDSaved"),[]];
    if ((count _allIEDs) < IEDLimit) then {
      _objectivesSaved = profileNameSpace getVariable (missionPrefix + "objectivesSaved");
      for "_i" from 0 to (count _objectivesSaved - 1) do {
        _randomIEDChance = random 100;
        if (_randomIEDChance < IEDSpawnChance) then {
          _selectedOBJ = _objectivesSaved select _i;
          _selectedPos = _selectedOBJ select 0;
          _objectiveWeight = _selectedOBJ select 1;
          _capturedStatus = _selectedOBJ select 2 select 0;
          if (_capturedStatus isEqualTo "opfor") then {
            _availableRoads = [];
            for "_j" from 0 to 4 do {
              _randomPos = [[[_selectedPos,500]]] call BIS_fnc_randomPos;
              _nearestRoad = [_randomPos,500,[]] call BIS_fnc_nearestRoad;
              if !(isNull _nearestRoad) then {
                _availableRoads pushBack _nearestRoad;
              };
            };
            _availableRoads;
            //systemChat format ["%1",_availableRoads];
            [_availableRoads] call vics_ied_spawnChance;
            //[_availableRoads] call vics_ied_test;
          };
        };
        _loopCount = _loopCount + 1;
        //systemChat str _loopCount;
        uiSleep 0.01;
      };
    };
  };
};

vics_ied_test = {
  params ["_availableRoads"];
  hint str _availableRoads;
};

vics_ied_spawnChance = {
  params ["_availableRoads"];
  diag_log "Made it";
  if (count _availableRoads > 0) then {
    _selectedRoad = selectRandom _availableRoads;
    _roadPos = getPosATL _selectedRoad;

    _inBlacklist = false;
    _blackListMarkers = objectiveOffwhiteList + objectiveSpawnBlacklist;
    {
      _blackListMarker = _x;
      if (_roadPos inArea _blackListMarker) then {
        _inBlacklist = true;
      };
    }forEach _blackListMarkers;
    _inBlacklist;
    if !(_inBlacklist) then {
      _playerClose = [];
      {
      if ((_x distance _roadPos) < 500) then {
        _playerClose pushback _x;
      };
      } foreach allPlayers;
      _playerClose;
      if ((count _playerClose) isEqualTo 0) then {
        _randomTrashCheck = random 100;
        _trashSpawned = 0;
        if (_randomTrashCheck > 60) then {
          _trashSpawned = 1;
        } else {
          _trashSpawned = 0;
        };
        [_roadPos, _trashSpawned] call vics_ied_create;
      };
    };
  };
};

vics_ied_trashSpawn = {
  [] spawn {
    _allTrash = profileNameSpace getVariable [(missionPrefix + "allTrashSaved"),[]];
    if ((count _allTrash) < trashLimit) then {
      _objectivesSaved = profileNameSpace getVariable (missionPrefix + "objectivesSaved");
      for "_i" from 0 to (count _objectivesSaved - 1) do {
        _randomIEDChance = random 100;
        if (_randomIEDChance < trashSpawnChance) then {
          _selectedOBJ = _objectivesSaved select _i;
          _selectedPos = _selectedOBJ select 0;
          _availableRoads = [];
          for "_j" from 0 to 4 do {
            _randomPos = [[[_selectedPos,500]]] call BIS_fnc_randomPos;
            _nearestRoad = [_randomPos,500,[]] call BIS_fnc_nearestRoad;
            if !(isNull _nearestRoad) then {
              _availableRoads pushBack _nearestRoad;
            };
          };
          _availableRoads;
          if ((count _availableRoads > 0) && ((count _allTrash) < trashLimit)) then {
            _selectedRoad = selectRandom _availableRoads;
            _roadPos = getPosATL _selectedRoad;

            _inBlacklist = false;
            _blackListMarkers = objectiveOffwhiteList + objectiveSpawnBlacklist;
            _inBlacklist = [_roadPos,_blackListMarkers] call vics_sys_posInBlacklist;
            if !(_inBlacklist) then {
              _playersClose = [_roadPos,500] call vics_sys_playersNearPos;
              if ((count _playersClose) isEqualTo 0) then {
                _location = [(_roadPos select 0),(_roadPos select 1),0];
                _trashItems = ["junk_1","junk_2","junk_3","junk_4","junk_5","junk_6","junk_7"];
                _selectedTrash = selectRandom _trashItems;
                _randomPos = [[[_location,13]]] call BIS_fnc_randomPos;
                _randomRotation = random 360;
                _trashSpawned = [_selectedTrash,_randomPos,[0,0,0],_randomRotation] call LARs_fnc_spawnComp;
                _mrkr = createMarker [(str _randomPos),_randomPos];
                //_mrkr setMarkerType "HD_DOT";
                //_mrkr setMarkerText "Trash Spawn";
                //[trash name, position, rotation]
                _trashSave = [_selectedTrash,_randomPos,_randomRotation];
                _allTrash pushBackUnique _trashSave;
                profileNameSpace setVariable [(missionPrefix + "allTrashSaved"),_allTrash];
              };
            };
          };
        };
        uiSleep 0.01;
      };
      profileNameSpace setVariable [(missionPrefix + "allTrashSaved"),_allTrash];
    };
  };
};

vics_ied_trashLoad = {
  [] spawn {
    _allTrash = profileNameSpace getVariable [(missionPrefix + "allTrashSaved"),[]];
    {
      _trashName = _x select 0;
      _trashPos = _x select 1;
      _trashRotation = _x select 2;
      _trashSpawned = [_trashName,_trashPos,[0,0,0],_trashRotation] call LARs_fnc_spawnComp;
    } forEach _allTrash;
  };
};

vics_ied_create = {
  params ["_location", "_trash"];
  _location = [(_location select 0),(_location select 1),0];
  _selectedIED = selectRandom ["ACE_IEDUrbanSmall_Range","ACE_IEDLandSmall_Range"];
  _iedOrdnance = selectRandom ["ATMine_Range_Ammo"];
  _explosiveDevice = selectRandom [""];
  _trashItems = ["junk_1","junk_2","junk_3","junk_4","junk_5","junk_6","junk_7"];
  _spawnedIED = createVehicle [_selectedIED,_location,[],13,"CAN_COLLIDE"];
  _spawnedIED addEventHandler ["Hit", {
    params ["_unit", "_source", "_damage", "_instigator"];
    _pos = getPos _unit;
    _boom = "ATMine_Range_Ammo" createVehicle _pos;
    _boom setDamage 1;
    deleteVehicle _unit;
  }];
  _buriedChallenge = random 100;
  _hiddenBool = false;
  if (_buriedChallenge < IEDBuryChance) then {
    _spawnedIED hideObjectGlobal true;
    _hiddenBool = true;
  };
  _hiddenBool;
  _IEDPos = getPosATL _spawnedIED;
  if (_trash == 1) then {
    randomRotation = random 359;
    _randomTrash = selectRandom _trashItems;
    trashSpawned = _randomTrash;
    _iedTrash = [_randomTrash,_IEDPos,[0,0,0],randomRotation] call LARs_fnc_spawnComp;
  } else {
    trashSpawned = "";
    randomRotation = "";
  };
  _hiddenBool;
  //[Actual object created, IED string used, Position, trash spawned, rotation of trash, ordance of ied, hidden bool]
  _iedSave = [_spawnedIED,_selectedIED,_IEDPos,trashSpawned,randomRotation,_iedOrdnance,_hiddenBool];
  _allIEDs = profileNameSpace getVariable (missionPrefix + "allIEDSaved");
  _allIEDs pushBackUnique _iedSave;
  profileNameSpace setVariable [(missionPrefix + "allIEDSaved"),_allIEDs];
  [_spawnedIED,_iedOrdnance] spawn vics_ied_activate;
};

vics_ied_activate = {
  params ["_ied","_ordnance"];
  _detonate = 0;
  while {alive _ied} do {
    _playerClose = [];
  {
  if ((_x distance _ied) < 300) then {
  _playerClose pushback _x;
  };
  } foreach allPlayers;
  _playerClose;
    if ((count _playerClose > 0) && (_detonate == 0)) then {
      [_ied,_ordnance] call vics_ied_detonate;
      _detonate = 1;
    };
    uiSleep 5;
  };
};

vics_ied_detonate = {
  params ["_ied","_ordnance"];
  while {alive _ied} do {
    _playerClose = [];
  {
  if ((_x distance _ied) < 1.7) then {
  _playerClose pushback _x;
  };
  } foreach allPlayers;
  _playerClose;
    if (count _playerClose > 0) then {
      systemChat "Detonated";
      _pos = getPos _ied;
      _boom = _ordnance createVehicle _pos;
      _boom setDamage 1;
      deleteVehicle _ied;
    };
    uiSleep 0.5;
  };
};

vics_ied_save = {
  [] spawn {
   _allIEDs = profileNameSpace getVariable (missionPrefix + "allIEDSaved");
     {
       _ied = _x select 0;
       _iedPos = _x select 2;
       if ((alive _ied) && ((_iedPos distance2D [0,0]) > 500)) then {
       } else {
         _iedIndex = _allIEDs find _x;
         _allIEDs deleteAt _iedIndex;
       };
       uiSleep 0.01;
     } forEach _allIEDs;
     uiSleep 0.01;
   //systemChat format ["%1",(count _allIEDs)];
   profileNameSpace setVariable [(missionPrefix + "allIEDSaved"),_allIEDs];
 };
};


vics_ied_load = {
  [] spawn {
    _allIEDs = profileNameSpace getVariable [(missionPrefix + "allIEDSaved"),[]];
    newIEDs = [];
    {
      //[Actual object created, IED string used, Position, trash spawned, rotation of trash, ordance of ied]
      _iedItem = _x select 1;
      _iedPos = _x select 2;
      _trashSpawn = _x select 3;
      _rotation = _x select 4;
      _ordnance = _x select 5;
      _hiddenBool = _x select 6;
      if (isNil "_hiddenBool") then {
        _hiddenBool = false;
      };
      spawnedIED = createVehicle [_iedItem,_iedPos,[],0,"CAN_COLLIDE"];
      if (_hiddenBool isEqualTo true) then {
        spawnedIED hideObjectGlobal true;
      };
      spawnedIED addEventHandler ["Hit", {
        params ["_unit", "_source", "_damage", "_instigator"];
        //systemChat "Detonate";
        _pos = getPos _unit;
        _boom = "ATMine_Range_Ammo" createVehicle _pos;
        _boom setDamage 1;
        deleteVehicle _unit;
      }];
      if !(_trashSpawn == "") then {
        _iedTrash = [_trashSpawn,_iedPos,[0,0,0],_rotation] call LARs_fnc_spawnComp;
      };
      _iedSave = [spawnedIED,_iedItem,_iedPos,_trashSpawn,_rotation,_ordnance,_hiddenBool];
      //systemChat format ["IED Object: %1",_iedSave select 0];
      newIEDs pushBackUnique _iedSave;
    } forEach _allIEDs;
    //systemChat format ["NewIEDs: %1",newIEDs];
    profileNameSpace setVariable [(missionPrefix + "allIEDSaved"),newIEDs];
    {
      _ied = _x select 0;
      _ordnance = _x select 5;
      [_ied,_ordnance] spawn vics_ied_activate;
      uiSleep 0.1;
    } forEach newIEDs;
  };
};

vics_ied_bomber = {
  params ["_civUnit"];
  _group = group _civUnit;
  [_group] call CBA_fnc_clearWaypoints;
  [_group, _randomlySelectedInteriorPos, 150] call BIS_fnc_taskPatrol;
  _civUnit addVest "V_TacVest_blk";
  _civUnit enableAI "PATH";
  _civUnit addEventHandler ["Hit", {
    params ["_unit", "_source", "_damage", "_instigator"];
    _pos = getPos _unit;
    _boom = "ATMine_Range_Ammo" createVehicle _pos;
    _boom setDamage 1;
    _unit setDamage 1;
    _unit removeAllEventHandlers "hit";
    }];
    [_civUnit] call vics_ied_bomberSearch;
};


vics_ied_bomberSearch = {
  params ["_unit"];
  [_unit] spawn {
    params ["_unit"];
    systemChat "Searching";
    while {alive _unit} do {
        _playerClose = [];
      {
      if ((_x distance _unit) < 50) then {
      _playerClose pushback _x;
      };
      } foreach allPlayers;
      _playerClose;
      if (count _playerClose > 0) then {
        _playerSelected = selectRandom _playerClose;
        [_unit, _playerSelected] call vics_ied_bomberHunt;
      };
      uiSleep 30;
    };
  };
};

vics_ied_bomberHunt = {
  params ["_unit","_playerSelected"];
  _groupUnit = group _unit;
    _detonate = 0;
    [_groupUnit] call CBA_fnc_clearWaypoints;
    while {alive _unit} do {
    _playerPos = getPos _playerSelected;
    _unit move _playerPos;
    if (((_playerSelected distance _unit) < 5) && (_detonate == 0)) then {
      [_unit,"boom"] remoteExec ["say3D",0];
      _unit removeAllEventHandlers "hit";
      uiSleep 1.5;
      _pos = getPos _unit;
      _boom = "ATMine_Range_Ammo" createVehicle _pos;
      _boom setDamage 1;
      _detonate = 1;
    };
    uiSleep 1;
  };
};
