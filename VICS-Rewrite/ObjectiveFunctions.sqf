vics_obj_debugEnemyPresence = {
  [] spawn {
    while {debugObjRunning isEqualTo true} do {
      if (debugObjOccupied isEqualTo false) exitWith {
        systemChat "Enemy Debug stopped!";
        _objectivesSaved = profileNameSpace getVariable (missionPrefix + "objectivesSaved");
        {
          _marker = _x select 3;
          _marker setMarkerAlpha 0;
        }forEach _objectivesSaved;
      };
      if (debugObjOccupied isEqualTo true) then {
        //systemChat "debug Running!";
        _objectivesSaved = profileNameSpace getVariable (missionPrefix + "objectivesSaved");
        _allOpfor = [];
        _allBlufor = [];
        {
          if((side _x) == east) then {
            _allOpfor pushBackUnique _x;
          };
          if((side _x) == west) then {
            _allBlufor pushBackUnique _x;
          };

        }forEach allUnits;
        _allOpfor;
        _allBlufor;
        {
          _opForInArea = [];
          _BluforInArea = [];
          _objective = _x select 3;
          _objective setMarkerAlpha 1;
          _objective setmarkercolor "colorGrey";
          {
            if (_x inArea _objective) then {
              _opForInArea pushBackUnique _x;
            };
          }forEach _allOpfor;
          _opForInArea;
          {
            if (_x inArea _objective) then {
              _BluforInArea pushBackUnique _x;
            };
          }forEach _allBlufor;
        _BluforInArea;
        if ((count _opForInArea) > (count _BluforInArea)) then {
          _objective setMarkerColor "colorRed";
        };
        if ((count _BluforInArea) > (count _opForInArea)) then {
          _objective setMarkerColor "colorBlue";
        };
        }forEach _objectivesSaved;
      };
      uiSleep 10;
      [] call vics_obj_debugObjWeight;
    };
  };
  true;
};

vics_obj_debugObjWeight = {
  _debugMarkers = missionNamespace getVariable (missionPrefix + "debugMarkers");
  if (isNil "_debugMarkers") then {
    _debugMarkers = [];
  };
  _debugMarkers;
  {
    deleteMarker _x;
  }forEach _debugMarkers;
  if (debugObjWeight isEqualTo true) then {
    _objectivesSaved = profileNameSpace getVariable (missionPrefix + "objectivesSaved");
    _debugMarkers = [];
    {
      _objPos = _x select 0;
      _objWeight = _x select 1;
      _objCaptured = _x select 2 select 0;
      _objTicks = _x select 2 select 1;
      _objective = _x select 3;
      _objHostility = _x select 7 select 2;
      //systemChat format ["%1",_objective];
      _weightMarker = createMarker [((str _objective) + "_ticks"), (getMarkerPos _objective)];
      _weightMarker setMarkerType "hd_dot";
      _markerStr = format ["Tk:%1 Own:%2 Wt:%3 Hst:%4",_objTicks,_objCaptured,_objWeight,_objHostility];
      _weightMarker setMarkerText _markerStr;
      _debugMarkers pushBackUnique _weightMarker;
    }forEach _objectivesSaved;
    _debugMarkers;
    missionNamespace setVariable [(missionPrefix + "debugMarkers"),_debugMarkers];
  };
};



vics_obj_generation = {
startTime = diag_tickTime;
profileNamespace setVariable ["objectiveMarkers",objectiveOffwhiteList];
profileNameSpace setVariable ["objectivesSaved",[]];
_objectiveMarkers = profileNamespace getVariable (missionPrefix + "ObjectiveMarkers");
if (isNil "_objectiveMarkers") then {
  profileNameSpace setVariable [(missionPrefix + "ObjectiveMarkers"),objectiveOffwhiteList];
};
  _enterableBuildings = [];
  runCount = 0;
  _centerposition = [worldSize / 2, worldsize / 2, 0];
  _nearBuildings = nearestObjects [_centerposition, ["House","Camp"], 100000];
  {
    _buildingPositions = _x buildingPos -1;
    if ((count _buildingPositions) > 0) then {
      //_marker = createMarker [(str _x), (getPos _x)];
      //_marker setMarkerType "mil_dot";
      _enterableBuildings pushBackUnique _x;
    };
  }forEach _nearBuildings;
  {
    _building = _x;
    _buildingPos = getPos _building;
    [_building, _buildingPos] call vics_obj_markerSafe;
  }forEach _enterableBuildings;
  waitUntil {endGeneration isEqualTo true};
  profileNameSpace setVariable [(missionPrefix + "enterableBuildings"),_enterableBuildings];
  true;
};

vics_obj_sizeCheck = {
  params ["_building","_buildingPos"];
  if ((_buildingsNearCount > 0) && (_buildingsNearCount <= 20) && ("tiny" in objectivesToCreate)) then {
    _markerColor = "colorGrey";
    _weight = 1;
    [_building,_buildingPos,_markerColor,_weight] call vics_obj_markerSafe;
  };
  if ((_buildingsNearCount > 3) && (_buildingsNearCount < 40) && ("small" in objectivesToCreate)) then {
    _markerColor = "colorGreen";
    _weight = 2;
    [_building,_buildingPos,_markerColor,_weight] call vics_obj_markerSafe;
  };
  if ((_buildingsNearCount >= 10) && (_buildingsNearCount < 65) && ("medium" in objectivesToCreate)) then {
    _markerColor = "colorYellow";
    _weight = 3;
    [_building,_buildingPos,_markerColor,_weight] call vics_obj_markerSafe;
  };
  if ((_buildingsNearCount >= 20) && (_buildingsNearCount < 85) && ("large" in objectivesToCreate)) then {
    _markerColor = "colorOrange";
    _weight = 4;
    [_building,_buildingPos,_markerColor,_weight] call vics_obj_markerSafe;
  };
  if ((_buildingsNearCount >= 85) && ("huge" in objectivesToCreate)) then {
    _markerColor = "colorRed";
    _weight = 5;
    [_building,_buildingPos,_markerColor,_weight] call vics_obj_markerSafe;
  };

  /*_buildingsNearCount = 0;
  {
    _buildingPositions = _x buildingPos -1;
    if ((count _buildingPositions) > 0) then {
      _buildingsNearCount = _buildingsNearCount + 1;
    };
  }forEach _nearBuildings;
  if (_buildingsNearCount > 10) then {
    runCount = runCount + 1;
    systemChat Format ["RunCount: %1",runCount];
    _currentMarker = createMarker [((str _building) + "objective"), _buildingPos];
    _currentMarker setMarkerType "hd_dot";
    _currentMarker setMarkerSize [250,250];
    _currentMarker setMarkerBrush "Grid";
    _currentMarker setMarkerShape "ELLIPSE";
    _currentMarker setMarkerColor "colorOPFOR";
    _currentMarker setMarkerAlpha 0.75;
    //_objectiveMarkers pushBackUnique _currentMarker;
  };
  */
  //Take this loop, and run it once per building, so that it builds onto the objectiveMarkers array, currently doesnt update that array per loop.
  true;
};


vics_obj_markerSafe = {
  params ["_building","_buildingPos"];
  _objectiveMarkersUpdated = [];
  _objectiveMarkers = profileNamespace getVariable (missionPrefix + "ObjectiveMarkers");
  _inArea = 0;
  for "_i" from ((count _objectiveMarkers) - 1) to 0 step -1 do {
    //systemChat format ["%1",_i];
    _markerPos = getMarkerPos (_objectiveMarkers select _i);
    if ((_markerPos distance2D _buildingPos) <= objectiveSizeMultiplier) exitWith {_inArea = 1};
  };
  _inArea;
  if (_inArea == 0) then {
    _nearBuildings = nearestObjects [_buildingPos, ["House","Camp"], objectiveSizeMultiplier];
    _buildingsNearCount = 0;
    {
      _buildingPositions = _x buildingPos -1;
      if ((count _buildingPositions) > 0) then {
        _buildingsNearCount = _buildingsNearCount + 1;
      };
    }forEach _nearBuildings;
    _objectiveWeight = 0;
    _markerColor = "colorGrey";
    if ((_buildingsNearCount > 0) && (_buildingsNearCount <= 20) && ("tiny" in objectivesToCreate)) then {
      _markerColor = "colorGrey";
      _objectiveWeight = 1;
    };
    if ((_buildingsNearCount > 20) && (_buildingsNearCount < 40) && ("small" in objectivesToCreate)) then {
      _markerColor = "colorGreen";
      _objectiveWeight = 2;
    };
    if ((_buildingsNearCount >= 40) && (_buildingsNearCount < 65) && ("medium" in objectivesToCreate)) then {
      _markerColor = "colorYellow";
      _objectiveWeight = 3;
    };
    if ((_buildingsNearCount >= 65) && (_buildingsNearCount < 85) && ("large" in objectivesToCreate)) then {
      _markerColor = "colorOrange";
      _objectiveWeight = 4;
    };
    if ((_buildingsNearCount >= 85) && ("huge" in objectivesToCreate)) then {
      _markerColor = "colorRed";
      _objectiveWeight = 5;
    };
    _currentMarker = createMarker [((str _building) + "_objective"), _buildingPos];
    _currentMarker setMarkerType "hd_dot";
    _currentMarker setMarkerSize [objectiveSizeMultiplier,objectiveSizeMultiplier];
    _currentMarker setMarkerBrush "Grid";
    _currentMarker setMarkerShape "ELLIPSE";
    _currentMarker setMarkerColor _markerColor;
    _currentMarker setMarkerAlpha 1;
    _objectiveMarkersUpdated pushBackUnique _currentMarker;
    _objectivesSaved = profileNameSpace getVariable "objectivesSaved";
    _ownership = "none";
    _ownershipChallenge = random 100;
    if (_ownershipChallenge < opforOwnershipChance) then {
      _ownership = "opfor";
    };
    _ownership;
    _objectiveToSave = [_buildingPos,_objectiveWeight,[_ownership,objCapturedTicks],_currentMarker,[],[],[],[false,objectiveCivMorale,50,-1,[],[],[],[],[],[],[],[],false]];
    //[position, weight, [last captured by, ticks to reset],current marker,array,array,array,[HotZone,Obj Civ Morale,obj Hostility, OBJ Region, Traffic Array, Parked Cars Array, Structures Array, production Array, Civ Personalities Array, HVT Array, Animals array, Roadblock Array, Sorted OBJ Array, ambient sounds playing bool]]
    /*
          0       1           2:0               2:1                3          4    5    6       7:0            7:1          7:2         7:3         7:4             7:5                   7:6              7:7                7:8                 7:9           7:10              7:11            7:12                    7:13
    */
    _objectivesSaved pushBackUnique _objectiveToSave;
    profileNameSpace setVariable [(missionPrefix + "objectivesSaved"),_objectivesSaved];
  };
  _objectiveMarkersFinal = _objectiveMarkers + _objectiveMarkersUpdated;
  profileNamespace setVariable [(missionPrefix + "objectiveMarkers"),_objectiveMarkersFinal];
  //systemChat format ["vics-obj-objectives: %1",_objectiveMarkersFinal];
  endTime = diag_tickTime;
  //systemChat format ["Total time generating: %1",endTime - startTime];
  endGeneration = true;
};

vics_obj_loadObjectives = {
  _debugMarkers = [];
  _objectivesSaved = profileNameSpace getVariable (missionPrefix + "objectivesSaved");
  _objectivesSavedUpdated = [];
  //[ObjectivePos,_objectiveWeight]
  {
    _objectivePos = _x select 0;
    _objectiveWeight = _x select 1;
    _objectiveLastCatpured = _x select 2 select 0;
    _objectiveTicksLeft = _x select 2 select 1;
    _objectiveMarker = _x select 3;
    _objHotZone = _x select 7 select 0;
    _objCivMorale = _x select 7 select 1;
    _objHostilityValue = _x select 7 select 2;
    _objRegion = _x select 7 select 3;
    _objStructures = _x select 7 select 6;
    _objProduction = _x select 7 select 7;
    _objCivProfiles = _x select 7 select 8;
    _objHVTs = _x select 7 select 9;
    _objRoadblocks = _x select 7 select 11;
    if (isNil "_objHostilityValue") then {
      _objHostilityValue = 50;
    };
    _objHostilityValue;
    if (isNil "_objStructures") then {
      _objStructures = [];
    };
    _objStructures;
    if (isNil "_objCivMorale") then {
      _objCivMorale = objectiveCivMorale;
    };
    _objCivMorale;
    if (isNil "_objHotZone") then {
      _objHotZone = false;
    };
    _objHotZone;
    if (isNil "_objRegion") then {
      _objRegion = -1;
    };
    _objRegion;
    if (isNil "_objProduction") then {
      _objProduction = [];
    };
    _objProduction;
    if (isNil "_objCivProfiles") then {
      _objCivProfiles = [];
    };
    _objCivProfiles;
    if (isNil "_objHVTs") then {
      _objHVTs = [];
    };
    _objHVTs;
    if (isNil "_objRoadblocks") then {
      _objRoadblocks = [];
    };
    _objRoadblocks;



    _markerColor = switch (_objectiveWeight) do {
      case 1: {"colorGrey"};
      case 2: {"colorGreen"};
      case 3: {"colorYellow"};
      case 4: {"colorOrange"};
      case 5: {"colorRed"};
    };
    _currentMarker = nil;
    _doLoad = true;
    if (_objHotZone) then {
      _index = [hotZones, _objectiveMarker] call BIS_fnc_findNestedElement;
      if !(_index isEqualTo []) then {
        _currentMarker = _objectiveMarker;
      } else {
        _doLoad = false;
      };
    } else {
      _currentMarker = createMarker [((str _objectivePos) + "objectiveGen"), _objectivePos];
      if (_currentMarker isEqualTo "") then {
        Diag_Log "VICS-OBJ: MARKER HAS SAME NAME. MARKER HAS SAME NAME. MARKER HAS SAME NAME";
      };
      _currentMarker setMarkerType "hd_dot";
      _currentMarker setMarkerSize [objectiveSizeMultiplier,objectiveSizeMultiplier];
      _currentMarker setMarkerBrush "Grid";
      _currentMarker setMarkerShape "ELLIPSE";
      _currentMarker setMarkerColor _markerColor;
      _currentMarker setMarkerAlpha 0;
    };
    _currentMarker;
    _doLoad;
    if (_doLoad) then {
      _objectiveToSave = [_objectivePos,_objectiveWeight,[_objectiveLastCatpured,_objectiveTicksLeft],_currentMarker,[],[],[],[_objHotZone,_objCivMorale,_objHostilityValue,_objRegion,[],[],_objStructures,_objProduction,_objCivProfiles,_objHVTs,[],_objRoadblocks,[],false]];
      _objectivesSavedUpdated pushBackUnique _objectiveToSave;
      _debugMarkers pushBackUnique _currentMarker;
      missionNamespace setVariable ["currentMarkers",_debugMarkers];
    };
  }forEach _objectivesSaved;
  _markersToHide = objectiveOffwhiteList + objectiveSpawnBlacklist;
  {
    _marker = _x;
    _marker setMarkerAlpha 0;
  }forEach _markersToHide;
  {
    _marker = _x select 0;
    _marker setMarkerAlpha 0;
  }forEach hotZones;
  _markers = ["border_0","border_1","border_2"];
{
 _x setMarkerAlpha 1;
}forEach _markers;
  _debugMarkers;
  _objectivesSavedUpdated;
  profileNameSpace setVariable [(missionPrefix + "objectivesSaved"),_objectivesSavedUpdated];
  //systemChat format ["Objectives on map: %1",count _debugMarkers];
  true;
};

vics_obj_fobCreation = {
  _objectivesSaved = profileNameSpace getVariable (missionPrefix + "objectivesSaved");
  _fobsCreated = [];
  while {(count _fobsCreated) < (fobsToCreate)} do {
    _objective = selectRandom _objectivesSaved;
    _fobCreate = 1;
    _fobInBlackList = 0;
    _objectivePos = _objective select 0;
    {
      _blacklistMarker = _x;
      if (_objectivePos inArea _blackListMarker) exitWith {_fobInBlackList = 1; systemChat "FOB in Blacklist"};
    }forEach objectiveSpawnBlacklist;
    if (_fobInBlackList isEqualTo 1) then {
    } else {
      {
        _fobPos = _x select 0;
        if ((_objectivePos distance2D _fobPos) < fobDistance) exitWith {_fobCreate = 0;};
      }forEach _fobsCreated;
      if (_fobCreate == 1) then {
        _currentMarker = createMarker [((str _objectivePos) + "_fob"), _objectivePos];
        _currentMarker setMarkerType "hd_dot";
        _currentMarker setMarkerColor "colorBlack";
        _currentMarker setMarkerAlpha 1;
        _currentMarker setMarkerText "FOB";
        _building = nearestBuilding _objectivePos;
        _fob = [_objectivePos,_building,_objective];
        _fobsCreated pushBackUnique _fob;
      };
      profileNameSpace setVariable [(missionPrefix + "opforFobs"),_fobsCreated];
    };
  };
  true;
};

vics_obj_hotzones = {
  //_hotZonesArray = [];
  _objectivesSaved = profileNameSpace getVariable (missionPrefix + "objectivesSaved");
  {
    _hotZone = _x;
    _hotZoneMarker = _hotZone select 0;
    _index = [_objectivesSaved, _hotZoneMarker] call BIS_fnc_findNestedElement;
    if !(_index isEqualTo []) then {
      systemChat "Its already there";
    } else {
      _hotZoneWeight = _hotZone select 1;
      _hotZonePosition = getMarkerPos _hotZoneMarker;
      _hotZoneToSave = [_hotZonePosition,_hotZoneWeight,["none",objCapturedTicks],_hotZoneMarker,[],[],[],[true]];
      _objectivesSaved pushBackUnique _hotZoneToSave;
    };
  }forEach hotzones;
  //_objectivesSaved append _hotZonesArray;
  _objectivesSaved;
  profileNameSpace setVariable [(missionPrefix + "objectivesSaved"),_objectivesSaved];
  true;
};





vics_obj_randomDoorLock = {
  _enterableBuildings = [];
  _centerposition = [worldSize / 2, worldsize / 2, 0];
  _nearBuildings = nearestObjects [_centerposition, ["House","Camp"], 100000];
  {
    _buildingPositions = _x buildingPos -1;
    if ((count _buildingPositions) > 0) then {
      _enterableBuildings pushBackUnique _x;
    };
  }forEach _nearBuildings;
  missionNameSpace setVariable ["enterableBuildings",_enterableBuildings];
  _lockchance = 10;
  {
    _building = _x;
    _class = configFile >> "CfgVehicles" >> typeOf _building;
    _num = getNumber (_class >> "numberofdoors");
    for "_i" from 1 to _num do {
      if (random 100 < _lockchance) then {
        _buildingPos = getPos _building;
				_var = format ["bis_disabled_Door_%1", _i];
				_anim = format ["Door_%1_rot", _i];
				_building animate[_anim, 0];
				_building setVariable[_var,1,true];
        _doorSelection = format ["Door_%1",_i];
        _building addAction ["Cut Lock","(_this select 3) select 1 setVariable[(_this select 3) select 0,0,true];",[_var,_building],0.8,false,true,"","[_this,'ACE_wirecutter'] call bis_fnc_hasItem;",1,false,_doorSelection];
			};
    };
  }forEach _enterableBuildings;
};

vics_obj_alert = {
  params ["_objective"];
  _alertNeeded = false;
  _objPos = _objective select 0;
  {
    if (_objPos inArea _x) exitWith {_alertNeeded = true};
  }forEach alertZones;
  if (_alertNeeded) then {
    _randomNum = random 100;
    if (_randomNum <= 5) then {
      //_mrkr = createMarker [(str _objPos + "_alert"),_objPos];
      //_mrkr setMarkerType "hd_objective";
      //_mrkr setMarkerText "Cartel Movement Reported";
      _taskID = (str _objPos + "_alertTask");
      if (([_taskID] call BIS_fnc_taskExists) isEqualTo false) then {
        [BLUFOR,_taskID,["Possible cartel movement has been reported.","Activity Reported",""],_objPos,"ASSIGNED",1,true,"",false] call BIS_fnc_taskCreate;
      };
    };
  };
};

vics_obj_steetlightsShutoff = {
  _objectivesSaved = profileNameSpace getVariable (missionPrefix + "objectivesSaved");
  {
    _objectiveSelected = _x;
    _objPos = _objectiveSelected select 0;
    _blackListMarkers = objectiveOffwhiteList + objectiveSpawnBlacklist;
    _inBlacklist = false;
    {
      _blackListMarker = _x;
      if (_objPos inArea _blackListMarker) then {
        _inBlacklist = true;
      };
      if (_inBlacklist isEqualTo true) exitWith {};
    }forEach _blackListMarkers;
    _inBlacklist;
    if !(_inBlacklist) then {
      systemChat "turning off";
      [_objPos] call vics_sys_toggleStreetlights;


    } else {
      //In Blacklist
    };
  }forEach _objectivesSaved;
};

vics_obj_regionGen = {
    systemChat "Script ran!";
  _objectivesSaved = profileNameSpace getVariable (missionPrefix + "objectivesSaved");
  //_sortedOBJs = [_objectivesSaved,[],{player distance2D (_x select 0)},"ASCEND"] call BIS_fnc_sortBy;
  _blackListMarkers = objectiveOffwhiteList + objectiveSpawnBlacklist;
  _regionCenters = [];
  _regionNumber = 0;
  while {(count _regionCenters) < (regionAmount)} do {
    _objective = selectRandom _objectivesSaved;
    _regionCreate = 1;
    _regionInBlackList = 0;
    _objectivePos = _objective select 0;
    {
      _blacklistMarker = _x;
      if (_objectivePos inArea _blackListMarker) exitWith {_regionInBlackList = 1; systemChat "Region in Blacklist"};
    }forEach _blackListMarkers;
    if (_regionInBlackList isEqualTo 1) then {
    } else {
      {
        _regionPos = _x select 0 select 0;
        if ((_objectivePos distance2D _regionPos) < fobDistance) exitWith {_regionCreate = 0;};
      }forEach _regionCenters;
      if (_regionCreate == 1) then {
        _currentMarker = createMarker [((str _objectivePos) + "_regionCreate"), _objectivePos];
        //_currentMarker setMarkerType "hd_dot";
        //_currentMarker setMarkerColor "colorBlack";
        //_currentMarker setMarkerAlpha 1;
        //_currentMarker setMarkerText "Region Center";
        _region = [_objective,_regionNumber,[]];
        _regionCenters pushBackUnique _region;
        _objIndex = _objectivesSaved find _objective;
        _extrasArray = _objective select 7;
        _extrasArray set [3,_regionNumber];
        _objective set [7,_extrasArray];
        _objectivesSaved set [_objIndex,_objective];
        _regionNumber = _regionNumber + 1;
      };
    };
  };
  _objCount = count _objectivesSaved;
  _objsAssigned = _regionCenters;
  {
    _regionPos = _x select 0 select 0;
    _sortedOBJs = [_objectivesSaved,[],{_regionPos distance (_x select 0)},"ASCEND"] call BIS_fnc_sortBy;

    //diag_log str _sortedOBJs;
    _x set [2,_sortedOBJs];
  }forEach _regionCenters;
  _currentPick = 0;
  systemChat "At the loop!";
  _loopLimit = (_objCount);
  _colors = ["ColorRed","ColorBlue","ColorYellow","ColorGreen","ColorPink","ColorWhite","ColorOrange","ColorKhaki","ColorGrey","ColorBlack","ColorBrown"];
  for "_i" from 1 to _loopLimit do {
    systemChat "In the loop!";
    if (_currentPick isEqualTo regionAmount) then {
      _currentPick = 0;
    };
    private _regionCenter = _regionCenters select _currentPick;
    private _regionNumber = _regionCenter select 1;
    private _sortedOBJList = _regionCenter select 2;
    diag_log format ["%1",_sortedOBJList];
    private _objFound = 0;
    private _objSelected = nil;
    {
      _objSelected = _x;
      if !(_objSelected in _objsAssigned) exitWith {_objFound = 1};
    }forEach _sortedOBJList;
    if (_objFound isEqualTo 1) then {
      diag_log str _objSelected;
      _objPos = _objSelected select 0;
      _mrkr = createMarker [((Str _objPos) + "SortingMarker"),_objPos];
      _mrkr setMarkerType "hd_dot";
      _mrkr setMarkerSize [objectiveSizeMultiplier,objectiveSizeMultiplier];
      _mrkr setMarkerBrush "Grid";
      _mrkr setMarkerShape "ELLIPSE";
      _mrkr setMarkerColor (_colors select _currentPick);
      _mrkr setMarkerText str _regionNumber;
      _objIndex = _objectivesSaved find _objSelected;
      _extrasArray = _objSelected select 7;
      _extrasArray set [3,_regionNumber];
      _objSelected set [7,_extrasArray];
      _objectivesSaved set [_objIndex,_objSelected];
      _objsAssigned pushBack _objSelected;
    };
    _currentPick = _currentPick + 1;
    uiSleep 0.1;
  };
  //profileNameSpace setVariable [(missionPrefix + "objectivesSaved"),_objectivesSaved];
};

vics_obj_sortDistanceInit = {
  openMap true;
  _objectivesSaved = profileNameSpace getVariable (missionPrefix + "objectivesSaved");
  {
    _objSelected = _x;
    _objExtrasArray = _objSelected select 7;
    _objSortedArray = _objExtrasArray select 12;
    _sortedOBJs = [_objSelected] call vics_obj_sortDistance;
    //_objIndex = _objectivesSaved find _objSelected;
    //_objExtrasArray set [12,_sortedOBJs];
    //_objective set [7,_objExtrasArray];
    //_objectivesSaved set [_objIndex,_objSelected];
  }forEach _objectivesSaved;
  //profileNameSpace setVariable [(missionPrefix + "objectivesSaved"),_objectivesSaved];
  true;
};

vics_obj_sortDistance = {
  params ["_objective"];
  _objectivesSaved = profileNameSpace getVariable (missionPrefix + "objectivesSaved");
  //_objsCount = count _objectivesSaved;
  _objPos = _objective select 0;
  _sortedOBJs = [_objectivesSaved,[],{_objPos distance2D (_x select 0)},"ASCEND"] call BIS_fnc_sortBy;
  {
    _obj = _x;
    _objPosLoop = _obj select 0;
    //_mrkr = createMarker [(str _objPosLoop + "Testingmrkr"),_objPosLoop];
    //_mrkr setMarkerType "HD_DOT";
    //_distance = str (_objPos distance2D _objPosLoop);
    //_mrkr setMarkerText _distance;
    //_map = findDisplay 12;
    //(findDisplay 12 displayCtrl 51) drawLine [_objPos,_objPosLoop,[0,0,1,1]];
  }forEach _sortedOBJs;
  _sortedOBJs resize 11;
  _sortedOBJs deleteAt 0;

  _sortedOBJs;
};

vics_obj_revealHostility = {
  _objectivesSaved = profileNameSpace getVariable (missionPrefix + "objectivesSaved");
  {
    _objectivePos = _x select 0;
    _objectiveWeight = _x select 1;
    _objectiveLastCatpured = _x select 2 select 0;
    _objectiveTicksLeft = _x select 2 select 1;
    _objectiveMarker = _x select 3;
    _objHotZone = _x select 7 select 0;
    _objCivMorale = _x select 7 select 1;
    _objHostilityValue = _x select 7 select 2;
  }forEach _objectivesSaved;
};


/*
{
  _objPos = _x select 0;
  _mrkr = createMarker [((Str _objPos) + "SortingMarker"),_objPos];
  _mrkr setMarkerType "hd_dot";
  _markerCount = _markerCount + 1;
  _mrkr setMarkerText str _markerCount;
}forEach _sortedOBJs;
*/

/*
while {(count _objsAssigned) < _objCount} do {
  {
    private _regionCenter = _x;
    private _regionNumber = _regionCenter select 1;
    private _sortedOBJList = _regionCenter select 2;
    diag_log format ["%1",_sortedOBJList];
    private _objFound = 0;
    private _objSelected = nil;
    {
      _objSelected = _x;
      if !(_objSelected in _objsAssigned) exitWith {_objFound = 1};
    }forEach _sortedOBJList;
    if (_objFound isEqualTo 1) then {
      diag_log str _objSelected;
      _objPos = _objSelected select 0;
      _mrkr = createMarker [((Str _objPos) + "SortingMarker"),_objPos];
      _mrkr setMarkerType "hd_dot";
      _mrkr setMarkerText str _regionNumber;
      _objIndex = _objectivesSaved find _objSelected;
      _extrasArray = _objSelected select 7;
      _extrasArray set [3,_regionNumber];
      _objSelected set [7,_extrasArray];
      _objectivesSaved set [_objIndex,_objSelected];
      _objsAssigned pushBack _objSelected;
    };
  }forEach _regionCenters;
};
/*
