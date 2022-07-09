//missionsAvailable = ["cache"];
tieredMissions = [["cache"],["cache"],["cache"]];
cacheMissions = ["cache_camp_1"];
hostages = ["UK3CB_CHC_C_POLITIC","UK3CB_CHC_C_CAN"];
eliminateTargets = ["UK3CB_TKM_O_WAR"];
buildingBlacklist = ["Land_Misc_deerstand"];



vics_tsk_init = {
completedMissions = [];
/*
  Testing process of spawning basic missions
  profileNameSpace setVariable [(missionPrefix + "missionsOnMap"),[]];
  _missionsOnMap = profileNameSpace getVariable (missionPrefix + "missionsOnMap");
  if (isNil "_missionsOnMap") then {
    _missionsOnMap = [];
    profileNameSpace setVariable [(missionPrefix + "missionsOnMap"),_missionsOnMap];
  };
  _missionsOnMap;
  _rNum = random [4,4,4];
  for "_i" from 1 to _rNum do {
    [] spawn vics_tsk_cache;
  };
  */

  /*
    Available Missions array [[T1],[T2],[T3]]
    Active Missions array [[T1],[T2],[T3]]
    Tier mission array [[M1],[M2],[M...]]
    Mission Breakdown array [missionPosition,tier,missionNameType,exactMissionClass,activeStatus]


  */

  _availibleMissions = profileNameSpace getVariable (missionPrefix + "availableMissions");
  _activeMissions = profileNameSpace getVariable (missionPrefix + "activeMissions");
  if (isNil "_availibleMissions") then {
    _availibleMissions = [[],[],[]];
    profileNameSpace setVariable [(missionPrefix + "availableMissions"),_availibleMissions];
  };
  if (isNil "_activeMissions") then {
    _activeMissions = [[],[],[]];
    profileNameSpace setVariable [(missionPrefix + "activeMissions"),_activeMissions];
  };
  _allMissions = _availibleMissions + _activeMissions;
  _firstRun = false;
  //checking if any missions exist at all, if none, then run a pop function for base value of missions in cfg
  {
    if ((count _x) == 0) exitWith {_firstRun = true};
  }forEach _allMissions;
  if (_firstRun == true) then {
    //run a first run/repopulate function
  } else {
  };
};
vics_tsk_request = {
//generates mission requests for the process fnc to run through
  params ["_tier"];
  //allowing a tier to be passed if needed, mainly for debug
  if (!isNil "_tier") then {
    //if a tier is passed
    if (_tier == 4) then {
      [] spawn vics_tsk_hvtTrack;
    } else {
    _tierToSelect = _tier - 1;
    _missionsInTier = tieredMissions select _tierToSelect;
    _randomMissionType = selectRandom _missionsInTier;
    [_randomMissionType,_tier] call vics_tsk_process;
    };
  } else {

  };
};

vics_tsk_hvtTrack = {
  for "_i" from 1 to 100 do {
    mrkrs = [];
    {
      _hvt = _x;
      _mrkName = (str _hvt);
      _hvtPos = getPos _hvt;
      _hvtDir = getDir _hvt;
      deleteMarker _mrkName;
      _mrk = createMarker [_mrkName,_hvtPos];
      _mrk setMarkerType "hd_arrow";
      _mrk setMarkerColor "ColorRed";
      _mrk setMarkerDir _hvtDir;
      _mrk setMarkerText "HVT";
      mrkrs pushBack _mrkName;

    }forEach hvtTestArray;
    uiSleep 0.1;
    mrkrs;
  };
  {
    deleteMarker _x;
  }forEach mrkrs;
};
vics_tsk_process = {
  //sends mission to correct fnc based on passed Vars of type of mission
  params ["_missionType","_tier"];
  if (_missionType == "cache") then {
    _compToSpawn = selectRandom cacheMissions;
    [_compToSpawn,_tier] call vics_tsk_cache;
  };
};


vics_tsk_complete = {
  params ["_mission"];
  //completes mission passed and adds it to completed missions to prevent saving.

};



vics_tsk_save = {
  params ["_mission"];
  //saves current missions that arent complete and should be saved
  _availibleMissions = profileNameSpace getVariable (missionPrefix + "availableMissions");
  _missionsToSave = [];
  if (_mission in completedMissions) then {
    //Mission was completed, dont save it
  } else {
    //save the mission
  };
};


vics_tsk_load = {
  [] call vics_tsk_ruskiFob;
};




vics_tsk_cache = {
  params ["_comp","_tier"];
  _availibleMissions = profileNameSpace getVariable (missionPrefix + "availableMissions");
  _missionTierArray = _availibleMissions select (_tier - 1);
  _objectivesSaved = profileNameSpace getVariable (missionPrefix + "objectivesSaved");
  _selectedOBJ = selectRandom _objectivesSaved;
  _objPos = _selectedOBJ select 0;
  _safePos = [_objPos,5,300,20,0,1] call BIS_fnc_findSafePos;
  _inBlacklist = false;
  {
    _blackListMarker = _x;
    if (_safePos inArea _blackListMarker) then {
      _inBlacklist = true;
    };
    if (_inBlacklist isEqualTo true) exitWith {};
  }forEach objectiveOffwhiteList;
  _inBlacklist;
  if (_inBlacklist isEqualTo false) then {
    //Fixing bug with Lars library
    _safePos pushBack 0;
    _mrkr = createMarker [(str _safePos),_safePos];
    _mrkr setMarkerType "hd_dot";
    _compSelected = _comp;
    _compReference = [_compSelected,_safePos,[0,0,0],0,True,false,False] call LARs_fnc_spawnComp;
    _spawnPoints = nearestObjects [_safePos, ["Sign_Sphere25cm_Geometry_F"],40];
    _randomCampPoint = selectRandom _spawnPoints;
    _randomCampPos = getPos _randomCampPoint;
    _box = "Land_PlasticCase_01_small_black_F" createVehicle _randomCampPos;
    _itemToAdd = ("VEM_FILE_T" + (str _tier));
    _itemCountToAdd = random round 3;
    _box addItemCargoGlobal [_itemToAdd,_itemCountToAdd];
    _randomDir = random 359;
    _box setDir _randomDir;
    //Mission Breakdown array [missionPosition,tier,missionNameType,exactMissionClass,activeStatus]
    _missionGenerated = [_safePos,_tier,"cache",_compSelected,true,[_randomCampPos,_itemCountToAdd,_randomDir]];
    _missionTierArray pushBack _missionGenerated;
    _availibleMissions set [(_tier - 1),_missionTierArray];
    //_missionsOnMap pushBackUnique _missionGenerated;
    profileNameSpace setVariable [(missionPrefix + "availableMissions"),_availibleMissions];
    //_compReference = ["laptop",_randomCampPos] call LARs_fnc_spawnComp;
  };
};

vics_tsk_cacheLoad = {

};

vics_tsk_recovery = {
  _objectivesSaved = profileNameSpace getVariable (missionPrefix + "objectivesSaved");
  _objFound = false;
  _selectedObj = nil;
  while {_objFound isEqualTo false} do {
    _randomObj = selectRandom _objectivesSaved;
    if ((_randomObj select 2 select 0) isEqualTo "opfor") then {
      _selectedObj = _randomObj;
      _objFound = true;
    };
  };
  _selectedObj;
  _objectivePos = _selectedOBJ select 0;
  _objectiveMarker = _selectedOBJ select 3;
  if (true) then {
    _buildingPos = nil;
    for "_i" from 0 to 2000 do {
      _randomPos = [[_objectiveMarker]] call BIS_fnc_randomPos;
      //systemChat format ["%1",_randomPos];
      building = nearestBuilding _randomPos;

      _buildingPos = building buildingPos -1;
      if (((count _buildingPos) > 3) && !((typeOf building) in buildingBlacklist)) exitWith {buildingPosFinal = _buildingPos;};
    };
    building;
    _buildingType = typeOf building;
    _buildingLocation = getPos building;
    copyToClipboard (str _buildingType);
    buildingPosFinal;
    deleteMarker "taskMarker";
    if (isNil "buildingPosFinal") then {
      systemChat "Cant find appropriate building.";
    } else {

      _taskMarker = createMarker ["taskMarker", _objectivePos];
      _taskMarker setMarkerShape "ELLIPSE";
      _taskMarker setMarkerBrush "Cross";
      _taskMarker setMarkerSize [750,750];
      _taskMarker setMarkerColor "colorOPFOR";
      [Blufor,"task",["Find and rescue the hostage","Rescue Hostage",""],objNull,"ASSIGNED"] call BIS_fnc_taskCreate;
      //_randomBPos = selectRandom _buildingPos;
      _randomBPos = selectRandom ((building buildingPos -1) select {lineIntersects [AGLToASL _x, (AGLToASL _x) vectorAdd [0,0,10]]});
      _civToSpawn = selectRandom hostages;
      _civGroup = createGroup [Civilian,true];
      _hostage = _civGroup createUnit [_civToSpawn,_randomBPos,[],0,"CAN_COLLIDE"];
      [_hostage, true] call ACE_captives_fnc_setHandcuffed;
      missionNameSpace setVariable ["vicsHvtArray",[_hostage]];
      for "_i" from 1 to (ceil (random 4)) do {
        _grp = createGroup [east,true];
        _randomGroup = selectRandom groupsDesignation;
        _position = [[[_buildingLocation,50]],["water"]] call bis_fnc_randomPos;
        {
          _grp createUnit [_x,_position,[],0,"NONE"];
        }forEach _randomGroup;
        [_buildingLocation,_grp] call vics_opfor_defend;
      };
      _randomNumber = round (random [3,5,7]);
      [building,false,_randomNumber] call vics_opfor_cqbPopulate;
      //_createdObject = createVehicle ["Land_OfficeCabinet_02_F",_randomBPos,[],0,"CAN_COLLIDE"];
      //_compReference = ["laptop",_randomBPos,[0,0,0],0,True,false,False] call LARs_fnc_spawnComp;
      //deleteMarker "debug";
      //_marker = createMarker ["debug",_randomBPos];
    //  _marker setMarkerType "hd_destroy";
    };
  } else {

  };
};

vics_tsk_hvtTurnIn = {
  _hvtArray = missionNameSpace getVariable "vicsHvtArray";
  _hvtCount = count _hvtArray;
  _hvtTurnedIn = 0;
  {
    _hvt = _x;
    if (_hvt inArea "blufor_1") then {
      _hvtTurnedIn = _hvtTurnedIn + 1;
    };
  }forEach _hvtArray;
  if (_hvtCount isEqualTo _hvtTurnedIn) then {

  } else {

  };
};




vics_tsk_hvtArrest = {

};

vics_tsk_eliminate = {
  _objectivesSaved = profileNameSpace getVariable (missionPrefix + "objectivesSaved");
  _objFound = false;
  _selectedObj = nil;
  while {_objFound isEqualTo false} do {
    _randomObj = selectRandom _objectivesSaved;
    if ((_randomObj select 2 select 0) isEqualTo "opfor") then {
      _selectedObj = _randomObj;
      _objFound = true;
    };
  };
  _selectedObj;
  _objectivePos = _selectedOBJ select 0;
  _objectiveMarker = _selectedOBJ select 3;
  if (true) then {
    _buildingPos = nil;
    for "_i" from 0 to 1000 do {
      _randomPos = [[_objectiveMarker]] call BIS_fnc_randomPos;
      building = nearestBuilding _randomPos;

      _buildingPos = building buildingPos -1;
      if (((count _buildingPos) > 3) && !((typeOf building) in buildingBlacklist)) exitWith {buildingPosFinal = _buildingPos;};
    };
    building;
    _buildingType = typeOf building;
    copyToClipboard (str _buildingType);
    buildingPosFinal;
    deleteMarker "taskMarker";
    if (isNil "buildingPosFinal") then {
      systemChat "Cant find appropriate building.";
    } else {
      _buildingLocation = getPos building;
      _taskMarker = createMarker ["taskMarker", _objectivePos];
      _taskMarker setMarkerShape "ELLIPSE";
      _taskMarker setMarkerBrush "Border";
      _taskMarker setMarkerSize [750,750];
      _taskMarker setMarkerColor "colorOPFOR";
      [Blufor,"task",["Capture or Kill target","C\K Target",""],objNull,"ASSIGNED"] call BIS_fnc_taskCreate;
      _randomBPos = selectRandom _buildingPos;
      for "_i" from 1 to (ceil (random 4)) do {
        _grp = createGroup [east,true];
        _randomGroup = selectRandom groupsDesignation;
        _position = [[[_buildingLocation,50]],["water"]] call bis_fnc_randomPos;
        {
          _grp createUnit [_x,_position,[],0,"NONE"];
        }forEach _randomGroup;
        [_buildingLocation,_grp] call vics_opfor_defend;
      };
      _targetToSpawn = selectRandom eliminateTargets;
      _hostileGroup = createGroup [east,true];
      _target = _hostileGroup createUnit [_targetToSpawn,_randomBPos,[],0,"CAN_COLLIDE"];
      _target addEventHandler ["Killed", {
	       params ["_unit", "_killer", "_instigator", "_useEffects"];
         ["task", "SUCCEEDED"] call BIS_fnc_taskSetState;
         [format ["The target was killed by %1",_killer]] remoteExec ["systemChat",0];
         [15000] call vics_pmc_balChange;
         _unit removeAllEventHandlers "Killed";
      }];
      //[_hostage, true] call ACE_captives_fnc_setHandcuffed;
      _randomNumber = round (random [3,5,7]);
      [building,false,_randomNumber] call vics_opfor_cqbPopulate;
      //_createdObject = createVehicle ["Land_OfficeCabinet_02_F",_randomBPos,[],0,"CAN_COLLIDE"];
      //_compReference = ["laptop",_randomBPos,[0,0,0],0,True,false,False] call LARs_fnc_spawnComp;
      //deleteMarker "debug";
      //_marker = createMarker ["debug",_randomBPos];
    //  _marker setMarkerType "hd_destroy";
    };
  } else {

  };
};


vics_tsk_tableBuild = {
  _pos = getPosASL Player;
  _compReference = ["laptop",_pos] call LARs_fnc_spawnComp;
};

vics_tsk_deliverSupplies = {
  _objectivesSaved = profileNameSpace getVariable (missionPrefix + "objectivesSaved");
  _selectedOBJ = selectRandom _objectivesSaved;
  _objectivePos = _selectedOBJ select 0;
  _objectiveMarker = _selectedOBJ select 3;
  _randomPos = [[_objectiveMarker]] call BIS_fnc_randomPos;
  _taskMarker = createMarker ["taskMarker", _randomPos];
  _taskMarker setMarkerShape "ELLIPSE";
  _taskMarker setMarkerBrush "Border";
  _taskMarker setMarkerSize [50,50];
  _taskMarker setMarkerColor "colorBlue";
  [Blufor,"task",["Deliver supplies to civilians.","Deliver Supplies",""],objNull,"ASSIGNED"] call BIS_fnc_taskCreate;
  _suppliesBox = createVehicle ["C_IDAP_CargoNet_01_supplies_F",(getMarkerPos "supplyPoint")];
  waitUntil {_suppliesBox inArea _taskMarker};
  ["task", "SUCCEEDED"] call BIS_fnc_taskSetState;
  [2000] call vics_pmc_balChange;
  deleteMarker _taskMarker;
};


vics_tsk_rescuefriendlies = {
  [] spawn {
    _objectivesSaved = profileNameSpace getVariable (missionPrefix + "objectivesSaved");
    _selectedOBJ = selectRandom _objectivesSaved;
    _objectivePos = _selectedOBJ select 0;
    _objectiveMarker = _selectedOBJ select 3;
    _randomPos = [[_objectiveMarker]] call BIS_fnc_randomPos;
    //_safePos = [_randomPos,5,300,3,0,1] call BIS_fnc_findSafePos;
    _nearestRoad = [_randomPos, 1000] call BIS_fnc_nearestRoad;
    _roadPos = getPos _nearestRoad;
    _safePos = _roadPos;
    //_safePos = _randomPos;
    _group = createGroup west;
    _randomGroup = selectRandom bluforGroupsDesignation;
    {
      _group createUnit [_x,_safePos,[],0,"NONE"];
    }forEach _randomGroup;
    //_damagedUnit = _group createUnit ["rhsusf_army_ocp_rifleman",_safePos,[],0,"NONE"];
    _taskMarker = createMarker ["taskMarker", _safePos];
    _taskMarker setMarkerType "hd_dot";
    _taskMarker setMarkerText "Injured Friendly";
    //_damageAreas = ["head", "body", "hand_l", "hand_r", "leg_l", "leg_r"];
    //_amountOfDamage = random [0,0.5,0.9];
    //_locationOfDamage = selectRandom _damageAreas;
    //[_damagedUnit, true] call ace_medical_fnc_setUnconscious;
    //[_damagedUnit, _amountOfDamage, _locationOfDamage, "bullet"] call ace_medical_fnc_addDamageToUnit;
    //_unitsInArea = _damagedUnit nearEntities ["Man", 500];
    /*_enemiesInArea = [];
    {
      if (side _x isEqualTo east) then {
        _enemiesInArea pushBack _x;
      };
      uiSleep 0.1;
    }forEach _unitsInArea;
    _enemiesCount = count _enemiesInArea;
    systemChat format ["enemies in area: %1",_enemiesCount];
    */
    _randomEnemyPos = nil;
    while {isNil "_randomEnemyPos"} do {
      _randomPosTest = [[[_safePos,400]]] call BIS_fnc_randomPos;
      if ((_safePos distance2d _randomPosTest) > 250) then {
        _randomEnemyPos = _randomPosTest;
      };
      _randomEnemyPos;
    };
    _randomEnemyPos;
    _grp = createGroup east;
    _randomGroup = selectRandom groupsDesignation;
    {
      _grp createUnit [_x,_randomEnemyPos,[],0,"NONE"];
    }forEach _randomGroup;
    //_grp reveal (leader _group);
    //_group reveal (leader _grp);
    [_grp, _safePos, 1, "MOVE", "UNCHANGED", "UNCHANGED", "UNCHANGED", "UNCHANGED", ""] call CBA_fnc_addWaypoint;
    _grp setVariable ["zbe_cacheDisabled", true];
    _group setVariable ["zbe_cacheDisabled", true];
    //[_group, _randomEnemyPos, 1, "MOVE", "UNCHANGED", "UNCHANGED", "UNCHANGED", "UNCHANGED", ""] call CBA_fnc_addWaypoint;
    _taskMarker = createMarker ["enemyMarker", _randomEnemyPos];
    _taskMarker setMarkerType "hd_dot";
    _taskMarker setMarkerText "Enemy Marker";
    [Blufor,"task",["Provide Support for Blufor forces.","QRF Blufor forces",""],objNull,"ASSIGNED"] call BIS_fnc_taskCreate;
  };
};

vics_tsk_bluforSupport = {

};




vics_tsk_ruskiFob = {
  [] spawn {
    _ruskiFob = profileNameSpace getVariable (missionPrefix + "ruskiFob");
    if (isNil "_ruskiFob") then {
      _markerLocations = ["fobMrkr1","fobMrkr2"];
      _ruskiFobs = ["vics_opf_ruskiFob1"];
      _randomMarker = selectRandom _markerLocations;
      _randomPos = [[_randomMarker],["water"]] call bis_fnc_randomPos;
      _safePos = [_randomPos,0,1200,40,0,0.3,0,[],[]] call BIS_fnc_findSafePos;
      _safePos pushBack 0;
      _randomDir = random 359;
      _compSelected = selectRandom _ruskiFobs;
      _compReference = [_compSelected,_safePos,[0,0,0],_randomDir,True,false,False] call LARs_fnc_spawnComp;
      _ruskiFobSpawned = [_safePos,_compSelected,_randomDir];
      for "_i" from 0 to (ceil (random 5)) do {
        _grp = createGroup [east,true];
        _randomGroup = selectRandom groupsDesignation;
        _position = [[[_safePos,50]],["water"]] call bis_fnc_randomPos;
        {
          _grp createUnit [_x,_position,[],0,"NONE"];
        }forEach _randomGroup;
        [_safePos,_grp] call vics_opfor_defend;
      };
      profileNameSpace setVariable [(missionPrefix + "ruskiFob"),_ruskiFobSpawned];
    } else {
      _pos = _ruskiFob select 0;
      _comp = _ruskiFob select 1;
      _dir = _ruskiFob select 2;
      _compReference = [_comp,_pos,[0,0,0],_dir,True,false,False] call LARs_fnc_spawnComp;
      for "_i" from 0 to (ceil (random 5)) do {
        _grp = createGroup [east,true];
        _randomGroup = selectRandom groupsDesignation;
        _position = [[[_pos,50]],["water"]] call bis_fnc_randomPos;
        {
          _grp createUnit [_x,_position,[],0,"NONE"];
        }forEach _randomGroup;
        [_pos,_grp] call vics_opfor_defend;
      };
    };
  };
};

vics_tsk_forestLocationGen = {
  _centerposition = [worldSize / 2, worldsize / 2, 0];
  _bestPlacesArray = selectBestPlaces [_centerposition, 50000, "forest + trees + meadow - houses - (10 * sea)", 50, 350];
  _locationArray = [_bestPlacesArray,[]];
  profileNameSpace setVariable [(missionPrefix + "forestLocationArray"),_locationArray];
};

vics_tsk_drugProduction = {
  _forestLocations = profileNamespace getVariable (missionPrefix + "forestLocationArray");
  _drugProductionTasks = profileNameSpace getVariable [(missionPrefix + "drugProductionTasks"),[]];
  _blackListMarkers = objectiveOffwhiteList + objectiveSpawnBlacklist;
  if ((count _drugProductionTasks) < maxDrugLocations) then {
    _locationsAvailable = _forestLocations select 0;
    _locationsUsed = _forestLocations select 1;
    for "_i" from 1 to 10 do {
      _chanceToGen = random 100;
      if (_chanceToGen <= 15) then {
        //_randomColor = selectRandom ["colorRED","colorYELLOW","colorGREEN","colorBLUE","colorWHITE","colorBLACK"];
        _locationFound = false;
        _pos = nil;
        while {_locationFound isEqualTo false} do {
          _locationTried = selectRandom _locationsAvailable;
          _pos = _locationTried select 0;
          _inBlacklist = false;
          {
            _blackListMarker = _x;
            if (_pos inArea _blackListMarker) then {
              _inBlacklist = true;
            };
            if (_inBlacklist isEqualTo true) exitWith {};
          }forEach _blackListMarkers;
          _inBlacklist;
          if !(_inBlacklist) then {
            _playersClose = [_pos, 1200] call vics_sys_playersClose;
            if ((count _playersClose) isEqualTo 0) then {
              if !(_pos in _locationsUsed) exitWith {_locationFound = true};
            };
          };
        };
        if (_locationFound) then {
          _locationsUsed pushBack _pos;
          {
             hideObjectGlobal _x select 0;
          }forEach nearestTerrainObjects [_pos,[],25];
          _compString = selectRandom ["slumHouse01","slumHouse02","slumHouse03","slumHouse04","slumHouse05"];
          _randomDir = random 360;
          _compSpawned = [_compString,_pos,[0,0,0],_randomDir] call LARs_fnc_spawnComp;
          //_mrk = createMarker [(str _pos),_pos];
          //_mrk setMarkerType "HD_DOT";
          //_mrk setMarkerColor _randomColor;
          _drugProductionTaskCreated = [_compString,_pos,_randomDir];
          _logicGroup = createGroup sideLogic;
          _logic = _logicGroup createUnit ["Logic", _pos, [], 0, "NONE"];
          _logic setVariable ["taskInfo",[_drugProductionTaskCreated,_compSpawned,[]]];
          _drugProductionTasks pushBack _drugProductionTaskCreated;
        };
      };
    };
    _drugProductionTasks;
    _forestLocations set [1,_locationsUsed];
    profileNamespace setVariable [(missionPrefix + "forestLocationArray"),_forestLocations];
    profileNameSpace setVariable [(missionPrefix + "drugProductionTasks"),_drugProductionTasks];
  };
};

vics_tsk_drugProdLoad = {
  _drugProductionTasks = profileNameSpace getVariable [(missionPrefix + "drugProductionTasks"),[]];
  _productionTasksCreated = [];
  {
    _task = _x;
    _compString = _task select 0;
    _compPos = _task select 1;
    _compDir = _task select 2;
    {
       hideObjectGlobal _x select 0;
    }forEach nearestTerrainObjects [_compPos,[],25];
    _compSpawned = [_compString,_compPos,[0,0,0],_compDir] call LARs_fnc_spawnComp;
    _logicGroup = createGroup sideLogic;
    _logic = _logicGroup createUnit ["Logic", _compPos, [], 0, "NONE"];
    _logic setVariable ["taskInfo",[_task,_compSpawned,[]]];
    systemChat str _logic;
    _drugProductionTaskCreated = [_compString,_compPos,_compDir];
    _productionTasksCreated pushBack _drugProductionTaskCreated;
  }forEach _drugProductionTasks;
  _productionTasksCreated;
  profileNameSpace setVariable [(missionPrefix + "drugProductionTasks"),_productionTasksCreated];
};

vics_tsk_drugProdDisable = {
  params ["_object","_actionID"];
  _drugProductionTasks = profileNameSpace getVariable [(missionPrefix + "drugProductionTasks"),[]];
  _object removeAction _actionID;
  _objectPos = getPos _object;
  _nearLogic = _objectPos nearEntities ["Logic",30];
  _taskInfo = (_nearLogic select 0) getVariable "taskInfo";
  //systemChat str _taskInfo;
  //[(_taskInfo select 1)] call LARs_fnc_deleteComp;
  _index = _drugProductionTasks find (_taskInfo select 0);
  _drugProductionTasks deleteAt _index;
  [true,(str _objectPos + "taskCompleted"),["Objective Completed","Objective Completed",""],_objectPos,"SUCCEEDED"] call BIS_fnc_taskCreate;
  profileNameSpace setVariable [(missionPrefix + "drugProductionTasks"),_drugProductionTasks];
};

vics_tsk_drugProdPopulate = {
  _drugProductionTasks = profileNameSpace getVariable [(missionPrefix + "drugProductionTasks"),[]];
  {
    _task = _x;
    _taskPos = _task select 1;
    _taskEnemiesArray = [];
    _playersClose = [_taskPos, 1200] call vics_sys_playersClose;
    _nearLogic = _taskPos nearEntities ["Logic",50];
    systemChat str _nearLogic;
    _infoHelper = _nearLogic select 0;
    _taskInfo = _infoHelper getVariable "taskInfo";
    _taskEnemiesArray = _taskInfo select 2;
    if ((count _playersClose) > 0) then {
      if ((count _taskEnemiesArray) isEqualTo 0) then {
        for "_i" from 0 to (ceil (random 3)) do {
          _grp = createGroup [east,true];
          _randomGroup = selectRandom groupsDesignation;
          _position = [[[_taskPos,50]],["water"]] call bis_fnc_randomPos;
          {
            _unitCreated = _grp createUnit [_x,_position,[],0,"NONE"];
            _taskEnemiesArray pushBack _unitCreated;
          }forEach _randomGroup;
          [_taskPos,_grp] call vics_opfor_defend;
        };
        _infoHelper setVariable ["taskInfo",_taskInfo];
      };
    } else {
      {
        deleteVehicle _x;
      } forEach _taskEnemiesArray;
      _taskEnemiesArray = [];
      _taskInfo set [2,_taskEnemiesArray];
    };
  }forEach _drugProductionTasks;
};

vics_tsk_intelTurnIn = {
  params ["_playerObject"];
  //Unit to get inventory
  _selectedPlayerInventory = magazines [_playerObject, true];
  _intelItems = [];
 {
    _item = _x;
    // Is this item part of VEM
    if ("VEM" in _item) then {
        _intelItems pushback _item;
        _playerObject removeItem _item;
    };
    uiSleep 0.01;

 } foreach _selectedPlayerInventory;
 // _intelItems now contains list of all VEM items
 _intelItems;
 ["Alright we are going to process this right away."] remoteExec ["systemChat",_playerObject];
 // Now process each intel item
 {
      _item = _x;
      // We need a different result based on each intel item
      if ("FILE" in _item) then {
         // This is a file
          if ("T1" in _item) then {
            // Tier 1 File
            [10] call vics_tsk_intelProcess;
          };
          if ("T2" in _item) then {
            // Tier 2 File
            [20] call vics_tsk_intelProcess;
          };
          if("T3" in _item) then {
            // Tier 3 File
            [30] call vics_tsk_intelProcess;
          };
        };
        if ("PHONE" in _item) then {
          // This is a phone
          if ("T1" in _item) then {
              // Tier 1 phone
            [40] call vics_tsk_intelProcess;
          };
          if ("T2" in _item) then {
            // Tier 2 phone
            [50] call vics_tsk_intelProcess;
          };
          if ("T3" in _item) then {
            // Tier 3 phone
            [60] call vics_tsk_intelProcess;
          };
      };
      if ("LAPTOP" in _item) then {
        // This is a laptop
          if ("T1" in _item) then {
            // Tier 1 laptop
            [70] call vics_tsk_intelProcess;
          };
          if ("T2" in _item) then {
            // Tier 2 laptop
            [80] call vics_tsk_intelProcess;
          };
          if ("T3" in _item) then {
            // Tier 3 laptop
            [90] call vics_tsk_intelProcess;
          };
      };
      uiSleep 3;
  } foreach _intelItems;
  if (count _intelItems > 0) then {
    ["All done. Hopefully you can make some use of this."] remoteExec ["systemChat",_playerObject];
  } else {
    ["Did you forget what actionable intel looks like? We will cover this in the next seminar..."] remoteExec ["systemChat",_playerObject];
  };
};

vics_tsk_intelProcess = {
  params ["_chance"];
  _challengeValue = random 100;
  if (_chance > _challengeValue) then {
    _tasksOptions = ["drugDen","hvtHiding","baseAttack"];
    _taskSelected = selectRandom _tasksOptions;
    switch (_taskSelected) do {
      case "drugDen": {[] call vics_tsk_revealDrugDen};
      case "hvtHiding": {};
      case "baseAttack": {};
    };
  };
};

vics_tsk_revealDrugDen = {
  _challengeValue = random 100;
  if (_challengeValue < 10) then {
    _opforObjectivesArray = missionNameSpace getVariable "opforObjectivesArray";
    _randomObjective = selectRandom _opforObjectivesArray;
    _objectivePos = _randomObjective select 0;
    _randomPos = [[_objectivePos,1000]] call bis_fnc_randomPos;
    [true,(str _randomPos + "fakeCall"),["Cartel Site Reported in the area, investigate and remove it.","Cartel Site Reported.",""],_randomPos,"AUTOASSIGNED"] call BIS_fnc_taskCreate;
  } else {
    _drugProductionTasks = profileNameSpace getVariable [(missionPrefix + "drugProductionTasks"),[]];
    _randomTask = selectRandom _drugProductionTasks;
    _taskPos = _randomTask select 1;
    [true,(str _taskPos + "realCall"),["Cartel Site Reported in the area, investigate and remove it.","Cartel Site Reported.",""],_taskPos,"AUTOASSIGNED"] call BIS_fnc_taskCreate;
  };
};

vics_tsk_hospitalMission = {
  _hospitalPos = getMarkerPos "hospitalMarker";
  _nearBuildings = nearestObjects [_hospitalPos, ["House","Camp"], 55];
  for "_i" from 1 to 26 do {
    _buildingSelected = selectRandom _nearBuildings;
    _buildingPositions = _buildingSelected buildingPos -1;
    _randomPos = selectRandom _buildingPositions;
    _grp = createGroup [civilian, true];
    _unitToCreate = selectrandom civilians;
    _createdUnit = _grp createUnit [_unitToCreate,_randomPos,[],0,"NONE"];
    _createdUnit disableAI "all";
    _createdUnit enableAI "Anim";
    _injuryCount = round random [1,3,5];
    for "_j" from 1 to _injuryCount do {
      _selection = selectRandom ["body","head","hand_r","hand_l","leg_r","leg_l"];
      _damageType = selectRandom ["bullet","explosive","grenade","shell","stab","vehiclecrash"];
      _damageAmount = random [0.1,0.4,1];
      [_createdUnit, _damageAmount, _selection, _damageType] call ace_medical_fnc_addDamageToUnit;
    };
  };
  for "_k" from 1 to (random [3,7,12]) do {
    _buildingSelected = selectRandom _nearBuildings;
    _buildingPositions = _buildingSelected buildingPos -1;
    _randomPos = selectRandom _buildingPositions;
    _grp = createGroup [east, true];
    _unitToCreate = selectrandom cqb;
    _createdUnit = _grp createUnit [_unitToCreate,_randomPos,[],0,"NONE"];
    _createdUnit disableAI "MOVE";
  };
};
