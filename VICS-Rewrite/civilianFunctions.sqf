// Civlian Functions


vics_civ_generate = {
  _objectivesSaved = profileNameSpace getVariable (missionPrefix + "objectivesSaved");
  _objectivesSavedUpdated = [];
  {
    _selectedOBJ = _x;
    _selectedPos = _selectedOBJ select 0;
    _objectiveWeight = _selectedOBJ select 1;
    _capturedStatus = _selectedOBJ select 2 select 0;
    _civArray = _selectedOBJ select 6;
    _extrasArray = _selectedOBJ select 7;
    _civIdentityArray = _extrasArray select 8;
    _playerClose = [];
    {
    if ((_x distance _selectedPos) < civDistance) then {
      _playerClose pushback _x;
    };
    } foreach allPlayers;
    _playerClose;
    _inBlacklist = false;
    _blackListMarkers = objectiveOffwhiteList + civilianSpawnBlacklist + objectiveSpawnBlacklist;
    {
      _blackListMarker = _x;
      if (_selectedPos inArea _blackListMarker) then {
        _inBlacklist = true;
      };
      if (_inBlacklist isEqualTo true) exitWith {};
    }forEach _blackListMarkers;
    _inBlacklist;

    _playerNearTest = [];
    {
    if ((_x distance _selectedPos) < civDistanceMinimum) then {
      _playerNearTest pushback _x;
    };
    } foreach allPlayers;
    _playerNearTest;

    if (_inBlacklist isEqualTo false) then {
      if ((count _playerClose isEqualTo 0) && (count _playerNearTest isEqualTo 0)) then {
        {
          if ((_x getVariable ["ace_captives_isHandcuffed", false]) isEqualTo false) then {
            deleteVehicle _x;
          };
        } forEach _civArray;
        _civArray = [];
        _selectedOBJ set [6,_civArray];
      } else {
        _nearBuildings = nearestObjects [_selectedPos, ["House","Camp"], 200];
        _buildingsUsed = [];
        _objIndex = _objectivesSaved find _selectedOBJ;
          if (count _civArray == 0) then {
            _civsMin = civValues select 0;
            _civsMax = civValues select 2;
          _civsToSpawnBase = civValues select 1;
          _numberToSpawn = ((_objectiveWeight * civWeightMultiplier) * _civsToSpawnBase);
          if (_numberToSpawn < _civsMin) then {
            _numberToSpawn = _civsMin;
          } else {
            if (_numberToSpawn > _civsMax) then {
              _numberToSpawn = _civsMax;
            };
            _numberToSpawn;
          };
          _numberToSpawn;
          for "_i" from 1 to _numberToSpawn do {
            _selectedBuilding = selectRandom _nearBuildings;
            if !(isNil "_selectedBuilding") then {
              if (_selectedBuilding in _buildingsUsed) then {
              } else {
                _buildingsUsed pushBackUnique _selectedBuilding;
                _civArray = [_selectedBuilding,false,nil,_capturedStatus] call vics_civ_populate;
                waitUntil {!(isNil "_civArray")};
                {
                  _civUnit = _x;
                  _civName = name _civUnit;
                  _civFace = face _civUnit;
                  _civIdentity = [_civName,_civFace];

                  _civUnit setVariable ["objectiveIndex",_objIndex];
                  if ((count _civIdentityArray) < 15) then {
                    _civIdentityArray pushBackUnique _civIdentity;
                    diag_log "New identity added";
                  } else {
                    if ((count _civIdentityArray) < 30) then {
                      _random100 = random 100;
                      if (_random100 < 10) then {
                        _civIdentityArray pushBackUnique _civIdentity;
                        diag_log "New identity added";
                      } else {
                        _randomIdentity = selectRandom _civIdentityArray;
                        [_civUnit, (_randomIdentity select 0)] remoteExec ["setName",0];
                        [_civUnit, (_randomIdentity select 1)] remoteExec ["setFace",0];
                        diag_log "Identity loaded";
                      };
                    } else {
                      _randomIdentity = selectRandom _civIdentityArray;
                      [_civUnit, (_randomIdentity select 0)] remoteExec ["setName",0];
                      [_civUnit, (_randomIdentity select 1)] remoteExec ["setFace",0];
                      diag_log "Identity loaded";
                    };
                  };
                }forEach _civArray;
                _extrasArray set [8,_civIdentityArray];
                _selectedOBJ set [6,_civArray];
                _selectedOBJ set [7,_extrasArray];
                _objectivesSaved set [_objIndex, _selectedOBJ];
              };
            };
            uiSleep smoothSpawn;
          };
        };
      };
    };
  } forEach _objectivesSaved;
  profileNameSpace setVariable [(missionPrefix + "objectivesSaved"),_objectivesSaved];
  true;
};

vics_civ_populate = {
  params ["_building",["_civArrayCheck",false],["_amount",nil],["_capturedStatus","none"]];
  //systemChat format ["%1 %2 %3",_building,_civArrayCheck,_amount];
  _chosenPos = [];
  _selectedInteriorPos = _building buildingPos -1;
  //systemChat format ["%1",_selectedInteriorPos];
  _randomNumber = ceil (random [1,1,2]);
  if (isNil "_amount") then {
  } else {
    _randomNumber = _amount;
  };
  _randomNumber;
  // Determine if this group should have chance of having intel
  // if vem is enabled
  _cqbHasIntel = false;
  if (vemEnabled) then {
    _cqbIntelRandomNum = random 100; // Betw 0-1000
    if(intelSpawnChances select 2 > _cqbIntelRandomNum) then {
      _cqbHasIntel = true;
    };
  };
  _possiblePositions = (count _selectedInteriorPos);
  if (_possiblePositions <= _randomNumber) then {
    _randomNumber = _possiblePositions - 1;
  };
  _randomNumber;
  for "_i" from 1 to _randomNumber do {
    _randomlySelectedInteriorPos = selectRandom _selectedInteriorPos;
    if (isNil "_randomlySelectedInteriorPos") then {

    } else {
      if (_randomlySelectedInteriorPos in _chosenPos) then {
        _i = _i - 1;
      } else {
        if !(_randomlySelectedInteriorPos inArea "blufor_1") then {
          //systemChat "Trying to create unit";
          _group = createGroup [civilian, true];
          //Waiting for 2.10 release to use below code
          /*_group addEventHandler ["KnowsAboutChanged", {
            params ["_group", "_targetUnit", "_newKnowsAbout", "_oldKnowsAbout"];
            if ((_newKnowsAbout >= 3) && ((side _targetUnit) isEqualTo West)) then {
              [_group,_targetUnit,_newKnowsAbout] call vics_opfor_spotter;
            };
          }];
          */
          _unitToSpawn = selectRandom civilians;
          _createdUnit = _group createUnit [_unitToSpawn,_randomlySelectedInteriorPos,[],0,"CAN_COLLIDE"];
          [_createdUnit, ["Interact", "CIV\civInteractMenu.sqf", nil, 2, true, true, "", "true", 3.5, false]] remoteExec ["addAction",0, true];
          _createdUnit addEventHandler ["Killed", {
	           params ["_unit", "_killer", "_instigator", "_useEffects"];
             [_unit,_killer] call vics_civ_civKilled;
          }];
          _civIdentity = [_createdUnit] call vics_civ_civIdentity;
          [_createdUnit] call vics_civ_randomize;
          if(vemEnabled && _cqbHasIntel) then {
            // This unit can have intel - see if they do
            _randomUnitHasIntel = random 100;
            if(intelSpawnChances select 3 > _randomUnitHasIntel) then {
              // This unit will have a piece of intel
              [_createdUnit] call vem_intel_unitAddRandomIntelItem;
            };
          };
          _sVest = false;
          _numberToBeat = 30;
          if (_capturedStatus == "opfor") then {
            _numberToBeat = _numberToBeat + 60;
            _sVestChance = random 100;
            if (_sVestChance < sVestSpawnChance) then {
              [_createdUnit] call vics_ied_bomber;
              _sVest = true;
            };
          };
          _chosenPos pushBackUnique _randomlySelectedInteriorPos;
          if !(_sVest) then {
            _createdUnit setFormDir (random 359);
            _createdUnit disableAI "WEAPONAIM";
            _createdUnit disableAI "CHECKVISIBLE";
            _createdUnit disableAI "TARGET";
            _createdUnit disableAI "AUTOTARGET";
            if ((random 100) < civSpotterChance) then {
              _createdUnit setVariable ["spotterBool",true];
              _createdUnit linkItem "ItemRadio";
            };
            _randomPatrolChance = random 100;
            _dayTime = dayTime;
            if ((_dayTime > 19) or (_dayTime < 5)) then {
              _numberToBeat = _numberToBeat + 60;
            };
            _numberToBeat;
            if (_randomPatrolChance > _numberToBeat) then {
            [_group] call CBA_fnc_clearWaypoints;
            [_group, _randomlySelectedInteriorPos, 150, 5, "MOVE", "SAFE", "YELLOW", "LIMITED", "STAG COLUMN", "", [1,8,30]] call CBA_fnc_taskPatrol;
            } else {
              _createdUnit disableAI "PATH";

            };
            _renegadeChallenge = random 100;
            if (_renegadeChallenge < renegadeChance) then {
              [-3000,_createdUnit] call vics_civ_setRating;
            };
            [_createdUnit] spawn vics_civ_randomChatter;
          };
          _civArray pushBackUnique _createdUnit;
        };
      };
    };
  };
  _civArray;
};

vics_civ_civIdentity = {
  params ["_unit"];
};

/*
vics_civ_traffic = {
  _civVehsSpawned = missionNameSpace getVariable "civVehs";
  if (isNil "_civVehsSpawned") then {
    _civVehsSpawned = [];
  };
  _civVehsSpawned;
  _civVehsAlive = [];
  {
    if (alive _x) then {
      _civVehsAlive pushBackUnique _x;
    } else {

    };
  }forEach _civVehsSpawned;
  _civVehsCount = count _civVehsAlive;
  if (_civVehsCount < civVehicleLimit) then {
    _objectivesSaved = profileNameSpace getVariable (missionPrefix + "objectivesSaved");
    _randomChance = random 100;
    if (_randomChance > 0) then {
      _randomNum = random [1,3,4];
      for "_i" from 1 to _randomNum do {
        _selectedOBJ = selectRandom _objectivesSaved;
        _objPos = _selectedOBJ select 0;
        _objMarker = _selectedOBJ select 3;
        _objSelect = 0;
        _objsSelected = [];
        while {_objSelect < 4} do {
          _obj = selectRandom _objectivesSaved;
          _objsSelected pushBackUnique _obj;
          _objSelect = _objSelect + 1;
        };
        _capturedStatus = _selectedOBJ select 2 select 0;
        if (_capturedStatus isEqualTo "none") then {
          //_selectedSafePos = [_objPos,0,40,7] call BIS_fnc_findSafePos;
          _roadsNearPos = _objPos nearRoads 1000;
          _selectedSafePos = getPosATL (selectRandom _roadsNearPos);
          _vicSpawn = selectRandom civVehicles;
          _vehSpawned = createVehicle [_vicSpawn,_selectedSafePos];
          // Add each unit to to group
          _seatCount = [_vicSpawn, true] call bis_fnc_crewCount;
          _randomAmountToAdd = round (random [2,(_seatCount/2),_seatCount]);
          _grp = createGroup civilian;
          for "_i" from 1 to _randomAmountToAdd do {
            _unitToCreate = selectrandom civilians;
          _createdUnit = _grp createUnit [_unitToCreate,[0,0],[],0,"NONE"];
          uiSleep 0.1;
          };

          _units = units _grp;
          {
            _x moveInAny _vehSpawned;
          } forEach _units;
          _leader = leader _grp;
          _leader moveInDriver _vehSpawned;
          _civVehsAlive pushBackUnique _leader;
          missionNameSpace setVariable ["civVehs",_civVehsAlive];
          {
            _selectedWPT = _x select 0;
          _nearestRoad = [_selectedWPT, 500] call BIS_fnc_nearestRoad;
          _roadPos = getPos _nearestRoad;
          _waypoint = _grp addWaypoint [_roadPos, 0];
          _waypoint setWaypointType "MOVE";
          } forEach _objsSelected;
          _waypointCycle = _grp addWaypoint [_selectedSafePos, 0];
          _waypointCycle setWaypointType "CYCLE";
          _wpIndex = currentWaypoint _grp;
          [_grp,_wpIndex] setWaypointBehaviour "SAFE";
          [_grp,_wpIndex] setWaypointSpeed "LIMITED";
          _vehSpawned limitSpeed 40;
        };
      };
    };
  } else {
  };
};
*/


vics_civ_trafficGenerate = {
  _objectivesSaved = profileNameSpace getVariable (missionPrefix + "objectivesSaved");
  _civVehicleWorld = missionNameSpace getVariable ["civVehicleWorld",[]];
  _objectivesSavedUpdated = [];
  {
    _selectedOBJ = _x;
    _selectedPos = _selectedOBJ select 0;
    _objectiveWeight = _selectedOBJ select 1;
    _capturedStatus = _selectedOBJ select 2 select 0;
    _extrasArray = _selectedOBJ select 7;
    _civTrafficArray = _extrasArray select 4;
    //systemChat str _civTrafficArray;
    _playerClose = [];
    {
    if ((_x distance _selectedPos) < civDistance) then {
      _playerClose pushback _x;
    };
    } foreach allPlayers;
    _playerClose;

    _inBlacklist = false;
    _blackListMarkers = objectiveOffwhiteList + civilianSpawnBlacklist;
    _inBlacklist = [_selectedPos,_blackListMarkers] call vics_sys_posInBlacklist;
    if (_inBlacklist isEqualTo false) then {
      if (count _playerClose isEqualTo 0) then {
        {
          _vehicleArraySelected = _x;
          _vehicle = _x select 0;
          _vehicleDelete = true;
          {
          if ((_x distance (getPos _vehicle)) < civDistance) exitWith {_vehicleDelete = false; _civVehicleWorld pushBack _vehicleArraySelected;};
          } foreach allPlayers;
          if (_vehicleDelete isEqualTo true) then {
            _crew = _x select 1;
            {
                deleteVehicle _x;
            }forEach _crew;
            deleteVehicle _vehicle;
          };
        } forEach _civTrafficArray;
        _civTrafficArray = [];
        _extrasArray set [4,_civTrafficArray];
        _selectedOBJ set [7,_extrasArray];
      } else {
        _roadsNearPos = _selectedPos nearRoads 600;
        _roadsUsed = [];
        _objIndex = _objectivesSaved find _selectedOBJ;
          if (count _civTrafficArray == 0) then {
            _civsMin = civTrafficValues select 0;
            _civsMax = civTrafficValues select 2;
          _civsToSpawnBase = civTrafficValues select 1;
          _numberToSpawn = ((_objectiveWeight * civWeightMultiplier) * _civsToSpawnBase);
          if (_numberToSpawn < _civsMin) then {
            _numberToSpawn = _civsMin;
          } else {
            if (_numberToSpawn > _civsMax) then {
              _numberToSpawn = _civsMax;
            };
            _numberToSpawn;
          };
          _numberToSpawn;
          if ((count _roadsNearPos) >= _numberToSpawn) then {
            for "_i" from 1 to _numberToSpawn do {
              _selectedRoad = selectRandom _roadsNearPos;
              _roadPos = getPosATL _selectedRoad;
              _playerTooClose = [_roadPos,civDistanceMinimum] call vics_sys_playersNearPos;
              if (!(isNil "_roadsNearPos")&&((count _playerTooClose) isEqualTo 0)) then {
                if (_selectedRoad in _roadsUsed) then {
                } else {
                  _roadsUsed pushBackUnique _selectedRoad;
                  _civTrafficArray = [_selectedRoad,false,nil,_capturedStatus] call vics_civ_trafficPopulate;
                  waitUntil {!(isNil "_civTrafficArray")};
                  _extrasArray set [4,_civTrafficArray];
                  _selectedOBJ set [7,_extrasArray];
                  _objectivesSaved set [_objIndex, _selectedOBJ];
                };
              };
              uiSleep smoothSpawn;
            };
          };
        };
      };
    };
  } forEach _objectivesSaved;
  _civVehicleWorldUpdated = [];
  {
    _vehicle = _x select 0;
    _vehicleDelete = true;
    {
    if ((_x distance (getPos _vehicle)) < civDistance) exitWith {_vehicleDelete = false;};
    } foreach allPlayers;
    if (_vehicleDelete isEqualTo true) then {
      _crew = _x select 1;
      {
          deleteVehicle _x;
      }forEach _crew;
      deleteVehicle _vehicle;
    } else {
      _civVehicleWorldUpdated pushBack _x;
    };
  } forEach _civVehicleWorld;
  profileNameSpace setVariable [(missionPrefix + "objectivesSaved"),_objectivesSaved];
  missionNameSpace setVariable ["civVehicleWorld",_civVehicleWorldUpdated];
  true;
};

vics_civ_trafficPopulate = {
  params ["_road",["_civArrayCheck",false],["_amount",nil],["_capturedStatus","none"]];
  //systemChat format ["%1 %2 %3",_building,_civArrayCheck,_amount];
  _chosenPos = [];
  _roadPos = getPosATL _road;
  //systemChat format ["%1",_selectedInteriorPos];
  _randomNumber = 1;
  if (isNil "_amount") then {
  } else {
    _randomNumber = _amount;
  };
  _randomNumber;
  // Determine if this group should have chance of having intel
  // if vem is enabled
  for "_i" from 1 to _randomNumber do {
    _randomlySelectedInteriorPos = _roadPos;
    if (isNil "_randomlySelectedInteriorPos") then {

    } else {
      if (_randomlySelectedInteriorPos in _chosenPos) then {
        _i = _i - 1;
      } else {
        if (true) then {
          //systemChat "Trying to create unit";
          _vicSpawn = selectRandom civVehicles;
          _safePos = _roadPos findEmptyPosition [0,10,_vicSpawn];
            if !(_safePos isEqualTo []) then {
              _vehSpawned = createVehicle [_vicSpawn,_safePos,[],0,"CAN_COLLIDE"];
              _vehSpawned setFuel (random [0.2,0.5,0.9]);
              if ((random 100) < lockedChance) then {
                _vehSpawned setVehicleLock "LOCKEDPLAYER";
              };
            // Add each unit to to group
            _seatCount = [_vicSpawn, true] call bis_fnc_crewCount;
            _randomAmountToAdd = round (random [2,(_seatCount/2),_seatCount]);
            _grp = createGroup civilian;
            for "_i" from 1 to _randomAmountToAdd do {
              _unitToCreate = selectrandom civilians;
              _createdUnit = _grp createUnit [_unitToCreate,[0,0],[],0,"CAN_COLLIDE"];
              _createdUnit addEventHandler ["Killed", {
    	           params ["_unit", "_killer", "_instigator", "_useEffects"];
                 [_unit,_killer] call vics_civ_civKilled;
              }];
              _createdUnit disableAI "TARGET";
              _createdUnit disableAI "AUTOTARGET";
              _createdUnit disableAI "WEAPONAIM";
              //_createdUnit disableAI "CHECKVISIBLE";
              uiSleep 0.1;
            };

            _units = units _grp;
            {
              _x assignAsCargo _vehSpawned;
              _x moveInAny _vehSpawned;
            } forEach _units;
            _leader = leader _grp;
            _leader assignAsDriver _vehSpawned;
            _leader moveInDriver _vehSpawned;
            _vehArray = [_vehSpawned,_units];
            _civTrafficArray pushBackUnique _vehArray;
            _objSelect = 0;
            _objsSelected = [];
            while {_objSelect < 1} do {
              _obj = selectRandom _objectivesSaved;
              _objsSelected pushBackUnique _obj;
              _objSelect = _objSelect + 1;
            };
            {
              _selectedWPT = _x select 0;
            _nearestRoad = [_selectedWPT, 500] call BIS_fnc_nearestRoad;
            _roadPos = getPos _nearestRoad;
            _waypoint = _grp addWaypoint [_roadPos, 0];
            _waypoint setWaypointType "MOVE";
            } forEach _objsSelected;
            _waypointCycle = _grp addWaypoint [_roadPos, 0];
            _waypointCycle setWaypointType "CYCLE";
            _wpIndex = currentWaypoint _grp;
            [_grp,_wpIndex] setWaypointBehaviour "SAFE";
            [_grp,_wpIndex] setWaypointSpeed "LIMITED";
            _vehSpawned limitSpeed 45;
            _grp allowFleeing 0;
          };
        };
      };
    };
  };
  //systemChat str _civTrafficArray;
  _civTrafficArray;
};



vics_civ_setRating = {
  params ["_setRating","_unit"];
   _getRating = rating _unit;
   _addVal = _setRating - _getRating;
   _unit addRating _addVal;
};

vics_civ_civKilled = {
  params ["_unit","_killer"];
  if ((side _killer) isEqualTo West) then {
    //systemChat "West killed!";
    ["Command","Incident Report","Reports state that a civilian was killed recently due to our actions. This is unnaceptable and will be punished."] remoteExec ["vics_ply_recieveEmail",0];
  };
  if ((side _killer) isEqualTo East) then {
    //systemChat "East killed!";
  };
};

vics_civ_parkedCarGenerate = {
  _objectivesSaved = profileNameSpace getVariable (missionPrefix + "objectivesSaved");
  _objectivesSavedUpdated = [];
  {
    _selectedOBJ = _x;
    _selectedPos = _selectedOBJ select 0;
    _objectiveWeight = _selectedOBJ select 1;
    _capturedStatus = _selectedOBJ select 2 select 0;
    _extrasArray = _selectedOBJ select 7;
    _civParkedArray = _extrasArray select 5;
    _playerClose = [];
    {
    if ((_x distance _selectedPos) < civDistance) then {
      _playerClose pushback _x;
    };
    } foreach allPlayers;
    _playerClose;
    _inBlacklist = false;
    _blackListMarkers = objectiveOffwhiteList + civilianSpawnBlacklist;
    _inBlacklist = [_selectedPos,_blackListMarkers] call vics_sys_posInBlacklist;

    if (_inBlacklist isEqualTo false) then {
      if (count _playerClose == 0) then {
        {
          deleteVehicle _x;
        } forEach _civParkedArray;
        _civParkedArray = [];
        _extrasArray set [5,_civParkedArray];
        _selectedOBJ set [7,_extrasArray];
      } else {
        _roadsNearPos = _selectedPos nearRoads 450;
        _roadsUsed = [];
        _objIndex = _objectivesSaved find _selectedOBJ;
          if (count _civParkedArray == 0) then {
            _civsMin = civTrafficValues select 0;
            _civsMax = civTrafficValues select 2;
          _civsToSpawnBase = civTrafficValues select 1;
          _numberToSpawn = ((_objectiveWeight * civWeightMultiplier) * _civsToSpawnBase);
          if (_numberToSpawn < _civsMin) then {
            _numberToSpawn = _civsMin;
          } else {
            if (_numberToSpawn > _civsMax) then {
              _numberToSpawn = _civsMax;
            };
            _numberToSpawn;
          };
          _numberToSpawn;
          for "_i" from 1 to _numberToSpawn do {
            _selectedRoad = selectRandom _roadsNearPos;
            if ((count _roadsNearPos) > 0) then {
              _roadPos = getPosATL _selectedRoad;
              _playerTooClose = [_roadPos,civDistanceMinimum] call vics_sys_playersNearPos;
              if (!(_selectedRoad in _roadsUsed) && ((count _playerTooClose) isEqualTo 0)) then {
                _roadsUsed pushBackUnique _selectedRoad;
                _civParkedArray = [_selectedRoad,false,nil,_capturedStatus] call vics_civ_parkedCarPopulate;
                waitUntil {!(isNil "_civParkedArray")};
                _extrasArray set [5,_civParkedArray];
                _selectedOBJ set [7,_extrasArray];
                _objectivesSaved set [_objIndex, _selectedOBJ];
              } else {

              };
            };
            uiSleep smoothSpawn;
          };
        };
      };
    };
  } forEach _objectivesSaved;
  profileNameSpace setVariable [(missionPrefix + "objectivesSaved"),_objectivesSaved];
  true;
};

vics_civ_parkedCarPopulate = {
  params ["_road",["_civArrayCheck",false],["_amount",nil],["_capturedStatus","none"]];
  //systemChat format ["%1 %2 %3",_building,_civArrayCheck,_amount];
  _chosenPos = [];
  _roadPos = getPosATL _road;
  //systemChat format ["%1",_selectedInteriorPos];
  _randomNumber = 1;
  if (isNil "_amount") then {
  } else {
    _randomNumber = _amount;
  };
  _randomNumber;
  // Determine if this group should have chance of having intel
  // if vem is enabled
  _cqbHasIntel = false;
  if (vemEnabled) then {
    _cqbIntelRandomNum = random 100; // Betw 0-1000
    if(intelSpawnChances select 2 > _cqbIntelRandomNum) then {
      _cqbHasIntel = true;
    };
  };
  for "_i" from 1 to _randomNumber do {
    _randomlySelectedInteriorPos = _roadPos;
    if (isNil "_randomlySelectedInteriorPos") then {

    } else {
      if (_randomlySelectedInteriorPos in _chosenPos) then {
        _i = _i - 1;
      } else {
        if !(_randomlySelectedInteriorPos inArea "blufor_1") then {
          //systemChat "Trying to create unit";
          _vicSpawn = selectRandom civVehicles;
          _roadInfo = getRoadInfo _road;
          _roadWidth = _roadInfo select 1;
          _roadDir = getDir _road;
          _sideOfRoad = selectRandom [-3.5,3.5];
          _roadPosRel = _road modelToWorld [_sideOfRoad,0,0.1];
          if (isOnRoad _roadPosRel) then {
            _safePos = _roadPosRel isFlatEmpty [-1,-1,0.1];
            if !(_safePos isEqualTo []) then {
              _safePos = ASLToATL _safePos;
              _vehSpawned = createVehicle [_vicSpawn,_safePos];
              _vehSpawned setDir _roadDir;
              _vehSpawned setPos _safePos;
              _vehSpawned setFuel (random [0.2,0.5,0.9]);
              if ((random 100) < lockedChance) then {
                _vehSpawned setVehicleLock "LOCKEDPLAYER";
              };
              _civParkedArray pushBack _vehSpawned;
            };
          };
        };
      };
    };
  };
  _civParkedArray;
};

vics_civ_crowdGen = {

};

vics_civ_animals = {
  _objectivesSaved = profileNameSpace getVariable (missionPrefix + "objectivesSaved");
  {
    _selectedOBJ = _x;
    _selectedPos = _selectedOBJ select 0;
    _objectiveWeight = _selectedOBJ select 1;
    _objExtrasArray = _selectedOBJ select 7;
    _objHostility = _objExtrasArray select 2;
    _objAnimals = _objExtrasArray select 10;
    _objIndex = _objectivesSaved find _selectedOBJ;
    _blackListMarkers = objectiveOffwhiteList + objectiveSpawnBlacklist;
    _inBlacklist = [_selectedPos,_blackListMarkers] call vics_sys_posInBlacklist;
    if (_inBlacklist isEqualTo false) then {
      _playerClose = [_selectedPos,civDistance] call vics_sys_playersNearPos;
      if (count _playerClose == 0) then {
        {
          deleteVehicle _x;
        } forEach _objAnimals;
        _objAnimals = [];
        _objExtrasArray set [10,_objAnimals];
      } else {
        _capturedStatus = _selectedOBJ select 2 select 0;
        _currentMarker = _selectedOBJ select 3;
        _chanceToPopulate = random 100;
          if ((count _objAnimals isEqualTo 0) && (_objectiveWeight <= 4) && (_chanceToPopulate < animalChance)) then {
            _safePos = [_selectedPos,30,300,2] call BIS_fnc_findSafePos;
          //If players are too close to objective
            _playerNear = [_safePos,civDistanceMinimum] call vics_sys_playersNearPos;
            if (count _playerNear == 0) then {
              _objAnimals = [_safePos,_selectedOBJ] call vics_civ_animalPopulate;
              waitUntil {!(isNil "_objAnimals")};
              _objExtrasArray set [10,_objAnimals];
              _selectedOBJ set [7,_objExtrasArray];
              _objectivesSaved set [_objIndex, _selectedOBJ];
            };
          } else {
            //Cant spawn animals here
        };
      };
    };
  } forEach _objectivesSaved;
  profileNameSpace setVariable [(missionPrefix + "objectivesSaved"),_objectivesSaved];
};

vics_civ_animalPopulate = {
  params ["_position","_objective"];
  _animalsArray = [];
  for "_i" from 1 to (random [2,6,9]) do {
    _createdUnit = createAgent ["Goat_random_F",_position,[],10,"NONE"];
    _createdUnit setDir (random 360);
    _createdUnit addEventHandler ["Killed", {
      //systemChat "Animal killed!";
    }];
    _animalsArray pushBackUnique _createdUnit;
    //diag_log "Spawning unit";
  };
   //[_position,_group] call vics_opfor_patrol;
  _animalsArray;
};

vics_civ_randomize = {
  params ["_unit"];
  _headgear = [];
  _backpacks = ["B_CivilianBackpack_01_Everyday_Astra_F","B_CivilianBackpack_01_Everyday_Black_F","B_CivilianBackpack_01_Everyday_Vrana_F","B_FieldPack_cbr","UK3CB_B_Hiker","B_Messenger_Black_F","B_Messenger_Olive_F"];
  if ((random 100) < 25) then {
    removeBackpackGlobal _unit;
    _unit addBackpackGlobal (selectRandom _backpacks);
  };
};

vics_civ_conversate = {
  params ["_unit"];
};

vics_civ_randomChatter = {
  params ["_unit"];
  while {alive _unit} do {
    _playersNear = [(getPos _unit),15] call vics_sys_playersNearPos;
    if ((count _playersNear) > 0) then {
    _objectivesSaved = profileNameSpace getVariable (missionPrefix + "objectivesSaved");
    _civObjective = _unit getVariable "objectiveIndex";
    _selectedObj = _objectivesSaved select _civObjective;
    _objHostility = _selectedObj select 7 select 2;
    _chatterArray = [];
    if (_objHostility >= 0) then {
      _chatterArray = ["Man this is so weird, it's like I can think now.","I wonder if those soldiers think of us when they aren't around.","Woah that guy looks cool!","Soldiers? Where?"];
    };
    if (_objHostility >= 30) then {
      _chatterArray = ["Man this is so weird, it's like I can think now.","I wonder if those soldiers think of us when they aren't around.","Woah that guy looks cool!","Soldiers? Where?"];
    };
    if (_objHostility >= 60) then {
      _chatterArray = ["Man this is so weird, it's like I can think now.","I wonder if those soldiers think of us when they aren't around.","Woah that guy looks cool!","Soldiers? Where?"];
    };
    if (_objHostility >= 90) then {
      _chatterArray = ["Man this is so weird, it's like I can think now.","I wonder if those soldiers think of us when they aren't around.","Woah that guy looks cool!","Soldiers? Where?"];
    };
    _chatterArray;
      _chatterSelected = selectRandom _chatterArray;
      //[_chatterSelected] remoteExec ["systemChat",_playersNear];
    };
    uiSleep (random [10,30,60]);
  };
};

vics_civ_callToPrayer = {
  [] spawn {
    _times = ["03:50","12:55","17:00","20:30","22:15"];
    _time = dayTime;
    _timeStr = [_time, "HH:MM"] call BIS_fnc_timeToString;
    if (_timeStr in _times) then {
      _callToPrayer = missionNameSpace getVariable ["callToPrayer",false];
      if !(_callToPrayer) then {
        _objectivesSaved = profileNameSpace getVariable (missionPrefix + "objectivesSaved");
        {
          _selectedOBJ = _x;
          _selectedPos = _selectedOBJ select 0;
          _playersClose = [_selectedPos,1500] call vics_sys_playersNearPos;
          if ((count _playersClose) > 0) then {
            missionNameSpace setVariable ["callToPrayer",true];
            _religionBuildings = _selectedPos nearObjects ["Land_A_Mosque_small_1_EP1",500];
            _selectedBuilding = selectRandom _religionBuildings;
            _aslPos = getPosASL _selectedBuilding;
            playSound3D ["alphaSFX\callToPrayer.ogg", _selectedBuilding,false,_aslPos,5,1,150];
            //_mrkr = createMarker [(str _aslPos),_aslPos];
            //_mrkr setMarkerType "HD_DOT";
            //_mrkr setMarkerText "Prayer";
          };
        }forEach _objectivesSaved;
        uiSleep 180;
        missionNameSpace setVariable ["callToPrayer",false];
      } else {
        //systemChat "Call to prayer active";
      };
    };
  };
};

vics_civ_ambientSounds = {
  _callToPrayer = missionNameSpace getVariable ["callToPrayer",false];
  if !(_callToPrayer) then {
    _objectivesSaved = profileNameSpace getVariable (missionPrefix + "objectivesSaved");
    _sounds = [["sfxsound2",82],0.1,["sfxsound3",31],0.5,["sfxsound4",52],0.4,["music1",133],0.2,["music2",119],0.15,["news1",121],0.25];
    {
      _selectedOBJ = _x;
      _selectedPos = _selectedOBJ select 0;
      _objExtrasArray = _selectedOBJ select 7;
      _objAmbientSounds = _objExtrasArray select 13;
      _objIndex = _objectivesSaved find _selectedOBJ;
      _blackListMarkers = objectiveOffwhiteList + objectiveSpawnBlacklist + civilianSpawnBlacklist;
      _inBlacklist = [_selectedPos,_blackListMarkers] call vics_sys_posInBlacklist;
      if (_inBlacklist isEqualTo false) then {
        if !(_objAmbientSounds) then {
          _playersClose = [_selectedPos,1500] call vics_sys_playersNearPos;
          if ((count _playersClose) > 0) then {
            _houses = _selectedPos nearObjects ["house",700];
            _enterableHouses = [];
            {
              _positions = _x buildingPos -1;
              if ((count _positions) >= 3) then {
                _enterableHouses pushBack _x;
              };
            }forEach _houses;
            for "_i" from 1 to 15 do {
              _houseSelected = selectRandom _enterableHouses;
              _soundSelected = selectRandomWeighted _sounds;
              _soundFile = _soundSelected select 0;
              _aslPos = getPosASL _houseSelected;
              //_mrkr = createMarker [(str _aslPos),_aslPos];
              //_mrkr setMarkerType "HD_DOT";
              //_mrkr setMarkerText _soundFile;
              playSound3D [("alphaSFX\" + _soundFile + ".ogg"), _houseSelected,false,_aslPos,1.5,1,100];
              [_soundSelected,_houseSelected,_aslPos,_selectedPos] spawn vics_civ_ambientSoundsLoop;
            };
            _objExtrasArray set [13,true];
            _selectedOBJ set [7,_objExtrasArray];
            _objectivesSaved set [_objIndex, _selectedOBJ];
          } else {
            _objExtrasArray set [13,false];
            _selectedOBJ set [7,_objExtrasArray];
            _objectivesSaved set [_objIndex, _selectedOBJ];
          };
        };
      };
    }forEach _objectivesSaved;
    profileNameSpace setVariable [(missionPrefix + "objectivesSaved"),_objectivesSaved];
  };
};

vics_civ_ambientSoundsLoop = {
  params ["_soundArray","_house","_aslPos","_objPos"];
  _soundFile = _soundArray select 0;
  _soundLength = _soundArray select 1;
  uiSleep _soundLength;
  _playersClose = [_objPos,1500] call vics_sys_playersNearPos;

  while {(count _playersClose) > 0} do {
    _callToPrayer = missionNameSpace getVariable ["callToPrayer",false];
    if !(_callToPrayer) then {
      //systemChat ("Looped " + _soundFile);
      playSound3D [("alphaSFX\" + _soundFile + ".ogg"), _house,false,_aslPos,1.5,1,100];
      uiSleep _soundLength;
      _playersClose = [_objPos,1500] call vics_sys_playersNearPos;
    };
  };
};
