//Groups Designation\\

_lightPatrol =
[
"UK3CB_TKM_O_TL",
"UK3CB_TKM_O_RIF_1"
];

_patrolGroup =
[
  "UK3CB_TKM_O_TL",
  "UK3CB_TKM_O_RIF_1",
  "UK3CB_TKM_O_AT",
  "UK3CB_TKM_O_MD",
  "UK3CB_TKM_O_IED",
  "UK3CB_TKM_O_RIF_1"
];

_patrolGroupTwo =
[
  "UK3CB_TKM_O_TL",
  "UK3CB_TKM_O_RIF_1",
  "UK3CB_TKM_O_AT",
  "UK3CB_TKM_O_MD",
  "UK3CB_TKM_O_AR",
  "UK3CB_TKM_O_SNI"
];

_patrolGroupThree =
[
  "UK3CB_TKM_O_TL",
  "UK3CB_TKM_O_RIF_1",
  "UK3CB_TKM_O_AT",
  "UK3CB_TKM_O_MG",
  "UK3CB_TKM_O_MG_ASST"
];


_patrolGroupFour =
[
"UK3CB_TKM_O_TL",
"UK3CB_TKM_O_RIF_1",
"UK3CB_TKM_O_AT",
"UK3CB_TKM_O_MD",
"UK3CB_TKM_O_RIF_1",
"UK3CB_TKM_O_MG",
"UK3CB_TKM_O_MG_ASST",
"UK3CB_TKM_O_TL",
"UK3CB_TKM_O_RIF_1",
"UK3CB_TKM_O_AT",
"UK3CB_TKM_O_MD",
"UK3CB_TKM_O_SNI",
"UK3CB_TKM_O_MG",
"UK3CB_TKM_O_MG_ASST"
];

cqb =
[
  "UK3CB_TKM_O_RIF_1",
  "UK3CB_TKM_O_MG",
  "UK3CB_TKM_O_AR"
];
_vehLight =
[
  ["UK3CB_NAP_O_Hilux_Closed",2],
  ["UK3CB_NAP_O_Hilux_Pkm",5],
  ["UK3CB_NAP_O_Hilux_Dshkm",5],
  ["UK3CB_NAP_O_Zil131_Covered",2],
  ["UK3CB_NAP_O_Zil131_Open",2],
  ["UK3CB_NAP_O_Kraz255_Flatbed",2]
];
_vehMed =
[
  ["UK3CB_NAP_O_Hilux_Closed",2],
  ["UK3CB_NAP_O_Hilux_Pkm",5],
  ["UK3CB_NAP_O_Hilux_Dshkm",5],
  ["UK3CB_NAP_O_Zil131_Covered",2],
  ["UK3CB_NAP_O_Zil131_Open",2],
  ["UK3CB_NAP_O_Kraz255_Flatbed",2]
];
_vehHeavy =
[
  ["UK3CB_NAP_O_Hilux_Closed",2],
  ["UK3CB_NAP_O_Hilux_Pkm",5],
  ["UK3CB_NAP_O_Hilux_Dshkm",5],
  ["UK3CB_NAP_O_Zil131_Covered",2],
  ["UK3CB_NAP_O_Zil131_Open",2],
  ["UK3CB_NAP_O_Kraz255_Flatbed",2]
];
groupsDesignation =
[
  _patrolGroup,
  _lightPatrol,
  _lightPatrol,
  _lightPatrol,
  _patrolGroup,
  _patrolGroupTwo,
  _patrolGroupThree,
  _patrolGroupFour
];

_groupLight =
[
  _patrolGroup
];

_groupMed =
[
  _patrolGroup,
  _patrolGroupTwo,
  _patrolGroupThree
];
_groupHeavy =
[
_patrolGroupTwo,
_patrolGroupThree,
  _patrolGroupFour
];

groupStrength =
[
  _groupLight,
  _groupMed,
  _groupHeavy
];

genUnitPool =
[
 "UK3CB_TKM_O_RIF_1"
];
vehs =
[
  _vehLight,
  _vehMed,
  _vehHeavy
];
civilians =
[
  "UK3CB_TKC_C_CIV"
];
civVehicles =
[
  "UK3CB_CHC_C_Hatchback",
  "UK3CB_C_Kamaz_Covered",
  "UK3CB_C_Hilux_Open",
  "UK3CB_C_LandRover_Closed",
  "UK3CB_C_Landcruiser",
  "UK3CB_C_YAVA"
];
_infantryTeam =
[
  "rhsusf_army_ocp_teamleader",
  "rhsusf_army_ocp_rifleman",
  "rhsusf_army_ocp_rifleman",
  "rhsusf_army_ocp_autorifleman"
];
_sfTeam =
[
  "rhsusf_socom_marsoc_teamchief",
  "rhsusf_socom_marsoc_cso",
  "rhsusf_socom_marsoc_cso",
  "rhsusf_socom_marsoc_marksman"
];
_infSquad =
[

];
bluforGroupsDesignation =
[
  _infantryTeam,
  _sfTeam
];

_lightInstallations = ["vics_opf_camp_small_01"];
_mediumInstallations = ["vics_opf_motorCamp_small_01"];
_heavyInstallations = ["vics_opf_motorCamp_small_01"];
vicsInstallations = [_lightInstallations,_mediumInstallations,_heavyInstallations];


//Groups Designation\\

vics_opfor_enemyWeaponsQuality = {

};






vics_opfor_request = {
  _opforForcePool = profileNameSpace getVariable (missionPrefix + "opforForcePool");
  if (isNil "_opforForcePool") then {
    _opforForcePool = ((count _objectivesSaved) / 5);
    profileNameSpace setVariable [(missionPrefix + "opforForcePool"),_opforForcePool];
  };
  _opforForcePool;
  _opforGroups = profileNameSpace getVariable (missionPrefix + "opforGroups");
  if (isNil "_opforGroups") then {
    _opforGroups = [];
    profileNameSpace setVariable [(missionPrefix + "opforGroups"),_opforGroups];
  };
  _opforGroups;
  _aiLimit = profileNameSpace getVariable (missionPrefix + "aiLimit");
  _opforGroupsCount = count _opforGroups;
  _opforFobs = profileNameSpace getVariable (missionPrefix + "opforFobs");
  _groupsToCreate = (3 * groupCycleMultiplier);
  for "_groups" from 1 to _groupsToCreate do {
    if ((_opforForcePool > 0) && ((count _opforGroups) < _aiLimit)) then {
      ["A group was created", "VICS_Opfor", true] call vics_sys_debug;
      _opforForcePool = _opforForcePool - 1;
      _fobSelected = selectRandom _opforFobs;
      [_fobSelected] call vics_opfor_create;
      } else {
        ["The force pool is empty, cannot create group", "VICS_Opfor", true] call vics_sys_debug;
    };
  };
  profileNameSpace setVariable [(missionPrefix + "opforForcePool"),_opforForcePool];
  true;
};


vics_opfor_create = {
  params ["_fob"];
  _opforGroups = profileNameSpace getVariable (missionPrefix + "opforGroups");
  if (isNil "_opforGroups") then {
    _opforGroups = [];
    profileNameSpace setVariable [(missionPrefix + "opforGroups"),_opforGroups];
  };
  _opforGroups;
  _fobPos = _fob select 0;
  _objective = _fob select 2;
  _objectiveOwner = _objective select 2 select 0;
    _playerClose = [];
    _position = [[[_fobPos,300]],["water"]] call bis_fnc_randomPos;
    _inBlacklist = false;
    _blackListMarkers = objectiveOffwhiteList + objectiveSpawnBlacklist;
    {
      _blackListMarker = _x;
      if (_position inArea _blackListMarker) then {
        _inBlacklist = true;
      };
      if (_inBlacklist isEqualTo true) exitWith {};
    }forEach _blackListMarkers;
    _inBlacklist;

    if (_inBlacklist isEqualTo false) then {
    {
    if ((_x distance _position) < 1000) then {
      _playerClose pushback _x;
    };
    } foreach allPlayers;
    _playerClose;
    if (((count _playerClose) == 0) && !(_objectiveOwner isEqualTo "blufor")) then {
      _grp = createGroup [east,true];
      _groupCreated = [_grp,[],["defend",_position,0]];
      _opforGroups pushBackUnique _groupCreated;
      profileNameSpace setVariable [(missionPrefix + "opforGroups"),_opforGroups];
      _randomGroup = selectRandom groupsDesignation;
      {
        _grp createUnit [_x,_position,[],0,"NONE"];
        uiSleep 0.1;
      }forEach _randomGroup;
      [_position,_grp] call vics_opfor_patrol;
      _leader = leader _grp;
      _leader addEventHandler ["Killed", {
        _qrfPos = ASLToAGL getPosASL (_this select 0);
        [_qrfPos] spawn vics_opfor_qrfCall;
      }];

    };
  };
};

vics_opfor_qrfCall = {
  params ["_qrfPos"];
  _qrfChance = 50;
  _random100 = random 100;
  if (_random100 < _qrfChance) then {
    _enemyGroups = [];
    _enemySides = [side player] call BIS_fnc_enemySides;
    _opforMorale = profileNameSpace getVariable (missionPrefix + "opforMorale");
    _moraleEffect = (_opforMorale / 100);
    _radiusMin = 250;
    _radiusMax = 1500 * _moraleEffect;
    if (_radiusMax < 500) then {
      _radiusMax = 500;
    };
    _enemyFaction = allGroups select {side _x isEqualTo east};
    _nearEnemies = _enemyFaction select {(leader _x) distance _qrfPos > _radiusMin AND (leader _x) distance _qrfPos < _radiusMax AND side _x in _enemySides};
    {
      _selectedGroup = _x;
      _enemyGroups pushBackUnique _selectedGroup;
    } forEach _nearEnemies;
    if ((count _enemyGroups) > 0) then {
      _qrfGroup = selectRandom _enemyGroups;
      [_qrfGroup] call CBA_fnc_clearWaypoints;
      _qrfWaypoint = _qrfGroup addWaypoint [_qrfPos, 0];
      [_qrfGroup, _qrfPos, 200] call bis_fnc_taskPatrol;
      [_qrfGroup, 0] setWaypointBehaviour "AWARE";
      [_qrfGroup, 0] setWaypointSpeed "FULL";
    };
  };
};

vics_opfor_civConvert = {
  [] spawn {
    if (insurgencyMode isEqualTo true) then {
      _civGroups = allGroups select {side _x isEqualTo civilian};
      _radiusMin = 30;
      _radiusMax = 300;
      _nearCivsArray = [];
      for "_i" from civConvertMin to civConvertMax do {
        _randomChance = random 100;
        _numberToBeat = 0;
        if (civConvertSimple isEqualTo true) then {
          _numberToBeat = civConvertChance;
        } else {
          _opforMorale = profileNameSpace getVariable (missionPrefix + "opforMorale");
          _numberToBeat = (_opforMorale / 2);
        };
        _numberToBeat;
        if (_randomChance < _numberToBeat) then {
          {
            _player = _x;
            _playerPos = getPos _player;
            _nearCivs = _civGroups select {(leader _x) distance _playerPos > _radiusMin AND (leader _x) distance _playerPos < _radiusMax};
            {
              _civGroup = _x;
              _nearCivsArray pushBackUnique _civGroup;
            }forEach _nearCivs;
          }forEach allPlayers;
          if ((count _nearCivsArray) > 0) then {
            _civGroup = selectRandom _nearCivsArray;
            _grp = createGroup east;
            _leader = leader _civGroup;
            [_leader] call vics_econ_moraleSync;
            _civMoraleClient = _leader getVariable "objHostility";
            _civMoraleClient = 100 - _civMoraleClient;
            if (_civMoraleClient > 50) then {
              [_leader] joinSilent _grp;
              _nearestBuilding = nearestBuilding (position _leader);
              _buildingPositions = _nearestBuilding buildingPos -1;
              _movePos = selectRandom _buildingPositions;
              _leader enableAI "TARGET";
              _leader enableAI "AUTOTARGET";
              _leader enableAI "WEAPONAIM";
              _leader enableAI "CHECKVISIBLE";
              _leader enableAI "MOVE";
              [_grp, _movePos, 0, "MOVE", "UNCHANGED", "UNCHANGED", "UNCHANGED", "UNCHANGED", "[this] spawn vics_opfor_civActivate",[15,30,90],5] call CBA_fnc_addWaypoint;
            };
          };
        };
        uiSleep smoothSpawn;
      };
    };
  };
};

vics_opfor_civActivate = {
  params ["_unit"];
  [_unit, "rhs_weap_AKMS", 3] call BIS_fnc_addWeapon;
  _nearestPlayer = [(getPos _unit)] call vics_sys_nearestPlayer;
  if !(isNil "_nearestPlayer") then {
    _playerPos = getPos _nearestPlayer;
    [(group _unit), _playerPos, 15, "SAD"] call CBA_fnc_addWaypoint;
  };
};

vics_opfor_load = {
  _opforGroupsSaved = profileNameSpace getVariable (missionPrefix + "opforGroupsSaved");
  if (isNil "_opforGroupsSaved") then {
    _opforGroupsSaved = [];
    profileNameSpace setVariable [(missionPrefix + "opforGroupsSaved"),_opforGroupsSaved];
  };
  _opforGroupsSaved;
  _opforGroupsCreated = [];
  {
    _group = _x;
    _position = _group select 0;
    _units = _group select 1;
    _taskObj = _group select 2;
    _grp = createGroup [east,true];
    _groupCreated = [_grp,_units,_taskObj];
    _groupHasIntel = false; // Variable only affected when VEM is enabled
    if(vemEnabled) then {
      // Determine if this group should have intel
      _randomNumGen = random 100; // Betw 0-100
      if(intelSpawnChances select 0 > _randomNumGen) then {
        _groupHasIntel = True;
      }
    };

    _opforGroupsCreated pushBackUnique _groupCreated;
    {
      _unit = _x;
      _createdUnit = _grp createUnit [_unit,_position,[],0,"NONE"];

      // Determine if this unit should have intel
      if(vemEnabled && _groupHasIntel) then {
        _randomNum = random 100; // Betw 0-100
        if(intelSpawnChances select 1 > _randomNum) then {
          // If so, determine drop and add it
          [_createdUnit] call vem_intel_unitAddRandomIntelItem;
          //_itemToAdd = call vem_intel_calculateDrop;
          //_createdUnit addItem _itemToAdd;
        };
      };

    } forEach _units;

    [_position, _grp] call vics_opfor_patrol;
    _leader = leader _grp;
    _leader addEventHandler ["Killed", {
      _qrfPos = ASLToAGL getPosASL (_this select 0);
      //publicVariable "qrfPos";
      [_qrfPos] spawn vics_opfor_qrfCall;
    }];
  } forEach _opforGroupsSaved;
  _opforGroupsCreated;
  profileNameSpace setVariable [(missionPrefix + "opforGroups"),_opforGroupsCreated];
  true;
};


vics_opfor_persist = {
  _opforGroups = profileNameSpace getVariable (missionPrefix + "opforGroups");
  _opforGroupsSaved = [];
  {
    _group = _x select 0;
    _unitsAlive = [];
    _units = units _group;
    _unitsPassed = [];
    _taskObj = _x select 2;
    {
      if (alive _x) then {
        _unitsPassed pushBackUnique _x;
      };
    }forEach _units;
    _unitsPassed;
      if ((count _unitsPassed) > 0) then {
        {
          if (alive _x) exitWith {leaderUnit = _x;};
        }forEach _units;
        _leader = leaderUnit;
        if (alive _leader) then {
          _leaderPos = getPos _leader;
          {
            _unit = _x;
            if (alive _unit) then {
              _unitStr = typeOf _unit;
                _unitsAlive pushBack _unitStr;
            };
          }forEach _unitsPassed;
          _unitsAlive;
          _grpSaved = [_leaderPos,_unitsAlive,_taskObj];
          _opforGroupsSaved pushBackUnique _grpSaved;
        };
      };
  }forEach _opforGroups;
  _opforGroupsSaved;
  profileNameSpace setVariable [(missionPrefix + "opforGroupsSaved"),_opforGroupsSaved];
  true;
};


vics_opfor_tasking = {
_opforGroups = profileNameSpace getVariable (missionPrefix + "opforGroups");
_opforMissionPlan = profileNamespace getVariable (missionPrefix + "opforMissionPlan");
_objectivesSaved = profileNameSpace getVariable (missionPrefix + "objectivesSaved");
_taskTypes = switch (_opforMissionPlan) do {
  case "defend": { ["defend","patrol"]};
  case "static": {["defend","patrol","recon"]};
  case "attack": {["patrol","recon","attack"]};
  default {["patrol","defend"]};
};
_attackObjs = [];
_defendObjs = [];
  {
    _objectiveOwner = _x select 2 select 0;
    if (_objectiveOwner == "blufor") then {
      _attackObjs pushBackUnique _x;
    };
    if (_objectiveOwner == "opfor") then {
      _defendObjs pushBackUnique _x;
    };
  }forEach _objectivesSaved;
  {
    _grp = _x select 0;
    _units = _x select 1;
    _taskObj = _x select 2;
    _taskType = _taskObj select 0;
    _taskLoc = _taskObj select 1;
    _taskTicks = _taskObj select 2;
    _index = _opforGroups find _x;
    if (_taskTicks == 0) then {
      [_grp, true, false] call lambs_wp_fnc_taskReset;
      _taskTypeUpdate = "";
      _taskSelected = selectRandom _taskTypes;
      _objectivePos = nil;
      if (_taskSelected == "defend") then {
        if (count _defendObjs == 0) then {
          _objSelected = selectRandom _objectivesSaved;
          _objectivePos = _objSelected select 0;
        } else {
          _objSelected = selectRandom _defendObjs;
          _objectivePos = _objSelected select 0;
        };
        _objectivePos;
        _subTasks = ["defencePatrol","defenceCamp"];
        _isDay = call vics_sys_isDay;
        _selectedSubTask = _subTasks selectRandomWeighted [0.5,0.5];
        if (_isDay) then {
          _selectedSubTask = _subTasks selectRandomWeighted [0.7,0.3];
        } else {
          _selectedSubTask = _subTasks selectRandomWeighted [0.1,0.9];
        };
        switch (_selectedSubTask) do {
          case "defencePatrol": {[_objectivePos,_grp] call vics_opfor_perimeterPatrol;};
          case "defenceCamp": {[_objectivePos,_grp] call vics_opfor_camp;};
          default {[_objectivePos,_grp] call vics_opfor_camp;};
        };
        _taskTypeUpdate = "defend";
      };
      if (_taskSelected == "patrol") then {
        _objSelected = selectRandom _objectivesSaved;
        _objectivePos = _objSelected select 0;
        [_objectivePos,_grp] call vics_opfor_patrol;
        _taskTypeUpdate = "patrol";
      };
      if (_taskSelected == "recon") then {
        if (count _attackObjs == 0) then {
          _objSelected = selectRandom _objectivesSaved;
          _objectivePos = _objSelected select 0;
        } else {
          _objSelected = selectRandom _attackObjs;
          _objectivePos = _objSelected select 0;
        };
        _objectivePos;
        [_objectivePos,_grp] call vics_opfor_recon;
        _taskTypeUpdate = "recon";
      };
      if (_taskSelected == "attack") then {
        if (count _attackObjs == 0) then {
          _objSelected = selectRandom _objectivesSaved;
          _objectivePos = _objSelected select 0;
        } else {
          _objSelected = selectRandom _attackObjs;
          _objectivePos = _objSelected select 0;
        };
        _objectivePos;
        [_objectivePos,_grp] call vics_opfor_attack;
        _taskTypeUpdate = "attack";
      };
      _objectivePos;
      _taskTypeUpdate;
      _ticksUpdate = groupTaskingTicks;
      _taskLocUpdate = _objectivePos;
      _groupUpdate = [_grp,_units,[_taskTypeUpdate,_taskLocUpdate,_ticksUpdate]];
      _opforGroups set [_index, _groupUpdate];
    };
    if (_taskTicks > 0) then {
      _ticksUpdate = _taskTicks - 1;
      _groupUpdate = [_grp,_units,[_taskType,_taskLoc,_ticksUpdate]];
      _opforGroups set [_index, _groupUpdate];
    };
    if (_taskTicks == -1) then {
    };
    uiSleep smoothSpawn;
  }forEach _opforGroups;
  _opforGroups;
  profileNameSpace setVariable [(missionPrefix + "opforGroups"),_opforGroups];
  true;
};

//The commander is in charge of the majority of large decisions made for the forces of their faction
vics_opfor_commander = {
  _objectivesSaved = profileNameSpace getVariable (missionPrefix + "objectivesSaved");
  _opforForcePool = profileNameSpace getVariable (missionPrefix + "opforForcePool");
  _opforMorale = profileNameSpace getVariable (missionPrefix + "opforMorale");
  _opforObjectives = [];
  _bluforObjectives = [];
  _emptyObjectives = [];
  {
    _objective = _x;
    _objectivePos = _x select 0;
    _objectiveWeight = _x select 1;
    _objectiveLastCatpured = _x select 2 select 0;
    _objectiveTicksLeft = _x select 2 select 1;
    if (_objectiveLastCatpured == "opfor") then {
      _opforObjectives pushBackUnique _objective;
    };
    if (_objectiveLastCatpured == "blufor") then {
      _bluforObjectives pushBackUnique _objective;
    };
    if (_objectiveLastCatpured == "none") then {
      _emptyObjectives pushBackUnique _objective;
    };
  }forEach _objectivesSaved;
  _opforCount = (count _opforObjectives);
  _bluforCount = (count _bluforObjectives);
  _emptyCount = (count _emptyObjectives);
  _majorityOwner = "none";
  _emptyOwner = "none";
  _opforMissionPlan = "static";

  if (_opforCount > _bluforCount) then {
    _majorityOwner = "opfor";
  } else {
    _majorityOwner = "blufor";
  };

  if (_opforCount > _emptyCount) then {
    _emptyOwner = "opfor";
  };
  if ((_majorityOwner == "opfor") && (_emptyOwner == "opfor")) then {
    _opforMissionPlan = "defend";
  };
  if ((_majorityOwner == "opfor") && (_emptyOwner == "none")) then {
    _opforMissionPlan = "static";
  };
  if ((_majorityOwner == "blufor") && (_emptyOwner == "none")) then {
    _opforMissionPlan = "attack";
  };
  _opforMissionPlan;
  profileNameSpace setVariable [(missionPrefix + "opforMissionPlan"),_opforMissionPlan];
  _vehPool = [];
  if (_opforForcePool < 150) then {
    _vehPool = ["light"];
  };
  if (_opforForcePool > 150) then {
    _vehPool = ["light"];
  };
  if (_opforForcePool > 300) then {
      _vehPool = ["light","medium"];
  };
  if (_opforForcePool > 600) then {
    _vehPool = ["light","medium","heavy"];
  };
  _vehPool;
  profileNameSpace setVariable [(missionPrefix + "opforVehPool"),_vehPool];
  true;
};

vics_opfor_patrol = {
  params ["_objectivePos","_grp"];
  _formations = ["COLUMN","STAG COLUMN","WEDGE","ECH LEFT","ECH RIGHT","VEE","LINE","FILE","DIAMOND"];
  _selectedFormation = selectRandom _formations;
  [_grp] call CBA_fnc_clearWaypoints;

  [_grp, _objectivePos, 500, 7, "MOVE", "SAFE", "UNCHANGED", "LIMITED",_selectedFormation] call CBA_fnc_taskPatrol;
};
vics_opfor_attack = {
  params ["_objectivePos","_grp"];
  [_grp] call CBA_fnc_clearWaypoints;
  [_grp, _objectivePos, 400] call CBA_fnc_taskAttack;
};
vics_opfor_defend = {
  params ["_objectivePos","_grp"];
  _formations = ["COLUMN","STAG COLUMN","WEDGE","ECH LEFT","ECH RIGHT","VEE","LINE","FILE","DIAMOND"];
  _selectedFormation = selectRandom _formations;
  [_grp] call CBA_fnc_clearWaypoints;
  [_grp, _objectivePos, 200, 7, "MOVE", "SAFE", "UNCHANGED", "LIMITED",_selectedFormation] call CBA_fnc_taskPatrol;
};
vics_opfor_recon = {
  params ["_objectivePos","_grp"];
  _formations = ["COLUMN","STAG COLUMN","WEDGE","ECH LEFT","ECH RIGHT","VEE","LINE","FILE","DIAMOND"];
  _selectedFormation = selectRandom _formations;
  [_grp] call CBA_fnc_clearWaypoints;
  [_grp, _objectivePos, 1200, 7, "MOVE", "SAFE", "UNCHANGED", "LIMITED",_selectedFormation] call CBA_fnc_taskPatrol;
};

vics_opfor_camp = {
  params ["_objectivePos","_grp"];
  [_grp] call CBA_fnc_clearWaypoints;
  [_grp, _objectivePos, 10, "MOVE", "SAFE", "UNCHANGED", "LIMITED", "COLUMN", "[this,getPos this,50,[],false,false] call lambs_wp_fnc_taskCamp;"] call CBA_fnc_addWaypoint;
/*
  _patrolRange = round (random [30,80,180]);
  _patrolChance = random 100;
  _groupDoPatrol = false;
  if (_patrolChance > 101) then {
    _groupDoPatrol = true;
  };
  [_grp,_objectivePos,_patrolRange,[],false,_groupDoPatrol] call lambs_wp_fnc_taskCamp;
  */
  systemChat "Group is going camping!";
};

vics_opfor_perimeterPatrol = {
  params ["_objectivePos","_grp",["_radius",300]];
  [_grp] call CBA_fnc_clearWaypoints;
  _degEach = 360/10;
  for "_i" from 1 to 10 do {
    _degChange = _degEach * _i;
    _posGot = _objectivePos getPos [_radius,_degChange];
    if ((random 100) > 50) then {
      [_grp,_posGot,0,"MOVE","SAFE","YELLOW","LIMITED","COLUMN","",[15,35,120]] call CBA_fnc_addWaypoint;
    } else {
      [_grp,_posGot,0,"MOVE","SAFE","YELLOW","LIMITED","COLUMN","",[0,0,0]] call CBA_fnc_addWaypoint;
    };
  };
  _wps = waypoints _grp;
  _lastWP = _wps select ((count _wps) - 1);
  _lastWP setWaypointType "CYCLE";
};


vics_opfor_fillerGroups = {
  _objectivesSaved = profileNameSpace getVariable (missionPrefix + "objectivesSaved");
  _objectivesSavedUpdated = [];
  {
    _selectedOBJ = _x;
    _selectedPos = _selectedOBJ select 0;
    _objectiveWeight = _selectedOBJ select 1;
    _fillerArray = _selectedOBJ select 5;
    _objHostility = _selectedObj select 7 select 2;
    _playerClose = [_selectedPos,fillerDistance] call vics_sys_playersNearPos;
    _inBlacklist = false;
    _blackListMarkers = objectiveOffwhiteList + objectiveSpawnBlacklist;
    _inBlacklist = [_selectedPos,_blackListMarkers] call vics_sys_posInBlacklist;

    if (_inBlacklist isEqualTo false) then {
      if (count _playerClose == 0) then {
        {
          deleteVehicle _x;
        } forEach _fillerArray;
        _fillerArray = [];
        _selectedOBJ set [5,_fillerArray];
      } else {
        _capturedStatus = _selectedOBJ select 2 select 0;
        _currentMarker = _selectedOBJ select 3;
        _markerPos = getMarkerPos _currentMarker;
        //_nearBuildings = nearestObjects [_selectedPos, ["House","Camp"], 200];
        //_buildingsUsed = [];
        _objIndex = _objectivesSaved find _selectedOBJ;
        _chanceToPopulate = random 100;
        _numberToBeat = ((_objectiveWeight * fillerGroupWeightMultiplier) * fillerGroupsChance);
          if ((count _fillerArray == 0) && (_capturedStatus == "opfor") && (_chanceToPopulate < _numberToBeat)) then {
          _selectedRandomPos = [[_currentMarker]] call bis_fnc_randomPos;
          //If players are too close to objective
          _playerNear = [];
          {
          if ((_x distance _selectedRandomPos) < fillerDistanceMinimum) then {
            _playerNear pushback _x;
          };
          } foreach allPlayers;
          _playerNear;
          if (count _playerNear == 0) then {
            _fillerArray = [_selectedRandomPos,_objHostility] call vics_opfor_fillerGroupsPopulate;
            waitUntil {!(isNil "_fillerArray")};
            _selectedOBJ set [5,_fillerArray];
            _objectivesSaved set [_objIndex, _selectedOBJ];
          };
        } else {
        };
      };
    };
  } forEach _objectivesSaved;
  profileNameSpace setVariable [(missionPrefix + "objectivesSaved"),_objectivesSaved];
  true;
};

vics_opfor_fillerGroupsPopulate = {
  params ["_position","_hostility"];
  // Determine if this group should have chance of having intel
  // if vem is enabled
  _cqbHasIntel = false;
  if (vemEnabled) then {
    _cqbIntelRandomNum = random 100; // Betw 0-1000
    if(intelSpawnChances select 2 > _cqbIntelRandomNum) then {
      _cqbHasIntel = true;
    };
  };
  _fillerArray = [];
    for "_i" from 1 to (random fillerGroupsValues) do {
      _groupsAllowed = [];
      if (_hostility > 10) then {
        _grps = groupStrength select 0;
        _groupsAllowed = _grps;
      };
      if (_hostility > 50) then {
        _grps = groupStrength select 1;
        _groupsAllowed = _grps;
      };
      if (_hostility > 80) then {
        _grps = groupStrength select 2;
        _groupsAllowed = _grps;
      };
      _groupsAllowed;
      _selectedGroup = selectRandom _groupsAllowed;
      _group = createGroup [east, true];

      {
        _unitToSpawn = _x;
         _createdUnit = _group createUnit [_unitToSpawn,_position,[],0,"NONE"];
         if(vemEnabled && _cqbHasIntel) then {
           // This unit can have intel - see if they do
           _randomUnitHasIntel = random 100;
           if(intelSpawnChances select 3 > _randomUnitHasIntel) then {
             // This unit will have a piece of intel
             [_createdUnit] call vem_intel_unitAddRandomIntelItem;
            };
         };
         _fillerArray pushBackUnique _createdUnit;
         uiSleep 0.1;
       }forEach _selectedGroup;
       [_position,_group] call vics_opfor_perimeterPatrol;
       _leader = leader _group;
       _leader addEventHandler ["Killed", {
         _qrfPos = ASLToAGL getPosASL (_this select 0);
         [_qrfPos] spawn vics_opfor_qrfCall;
       }];
     };
  _fillerArray;
};


vics_opfor_cqb = {
  _objectivesSaved = profileNameSpace getVariable (missionPrefix + "objectivesSaved");
  _objectivesSavedUpdated = [];
  {
    _selectedOBJ = _x;
    _selectedPos = _selectedOBJ select 0;
    _cqbArray = _selectedOBJ select 4;
    _objHostility = _selectedObj select 7 select 2;
    _playerClose = [];
    {
    if ((_x distance _selectedPos) < cqbDistance) then {
      _playerClose pushback _x;
    };
    } foreach allPlayers;
    _playerClose;
    _inBlacklist = false;
    _blackListMarkers = objectiveOffwhiteList + objectiveSpawnBlacklist;
    _inBlacklist = [_selectedPos,_blackListMarkers] call vics_sys_posInBlacklist;

    if (_inBlacklist isEqualTo false) then {
      if (count _playerClose == 0) then {
        {
          deleteVehicle _x;
        } forEach _cqbArray;
        _cqbArray = [];
        _selectedOBJ set [4,_cqbArray];
      } else {
        _capturedStatus = _selectedOBJ select 2 select 0;
        _nearBuildings = nearestObjects [_selectedPos, ["House","Camp"], 450];
        if ((count _nearBuildings) > 0) then {
          _buildingsUsed = [];
          _objIndex = _objectivesSaved find _selectedOBJ;
            if ((count _cqbArray == 0) && (_capturedStatus == "opfor")) then {
              _amountToSpawn = 0;
              if (_objHostility > 10) then {
                _amountToSpawn = random [0,1,2];
              };
              if (_objHostility > 50) then {
                _amountToSpawn = random [2,4,7];
              };
              if (_objHostility > 80) then {
                _amountToSpawn = random [4,8,14];
              };
            for "_i" from 1 to _amountToSpawn do {
              _selectedBuilding = selectRandom _nearBuildings;
              if (_selectedBuilding in _buildingsUsed) then {
              } else {
                _buildingsUsed pushBackUnique _selectedBuilding;
                //If players are too close to objective
                _playerNearTest = [];
                {
                if ((_x distance (getPos _selectedBuilding)) < cqbDistanceMinimum) then {
                  _playerNearTest pushback _x;
                };
                } foreach allPlayers;
                _playerNearTest;
                if (count _playerNearTest == 0) then {
                  _cqbArray = [_selectedBuilding] call vics_opfor_cqbPopulate;
                  waitUntil {!(isNil "_cqbArray")};
                  _selectedOBJ set [4,_cqbArray];
                  _objectivesSaved set [_objIndex, _selectedOBJ];
                } else {
                };
              };
            };
          };
        };
      };
    };
  } forEach _objectivesSaved;
  profileNameSpace setVariable [(missionPrefix + "objectivesSaved"),_objectivesSaved];
  true;
};

vics_opfor_cqbPopulate = {
  params ["_building",["_cqbArrayCheck",false],["_amount",nil]];
  _chosenPos = [];
  _selectedInteriorPos = _building buildingPos -1;
  _randomNumber = ceil (random [1,2,6]);
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
        //systemChat "Trying to create unit";
        _group = createGroup [east, true];
        _unitToSpawn = selectRandom cqb;
         _createdUnit = _group createUnit [_unitToSpawn,_randomlySelectedInteriorPos,[],0,"CAN_COLLIDE"];
         _createdUnit setFormDir (random 360);
         if(vemEnabled && _cqbHasIntel) then {
           // This unit can have intel - see if they do
           _randomUnitHasIntel = random 100;
           if(intelSpawnChances select 3 > _randomUnitHasIntel) then {
             // This unit will have a piece of intel
             [_createdUnit] call vem_intel_unitAddRandomIntelItem;
           };
         };
        _chosenPos pushBackUnique _randomlySelectedInteriorPos;
        _randomPathNum = random 100;
      if (_randomPathNum < cqbHoldChance) then {
        _createdUnit disableAI "PATH";
      };
      _cqbArray pushBackUnique _createdUnit;
      };
    };
    uiSleep smoothSpawn;
  };
  _cqbArray;
};



vics_opfor_vehicleCreate = {
  _opforVehs = profileNameSpace getVariable (missionPrefix + "opforVehs");
  _opforVehPool = profileNameSpace getVariable (missionPrefix + "opforVehPool");
  _opforForcePool = profileNameSpace getVariable (missionPrefix + "opforForcePool");
  if (_opforVehPool isEqualTo []) exitWith {};
  if (isNil "_opforVehs") then {
    _opforVehs = [];
  };
  _opforVehs;
  if ((count _opforVehs) < vehLimit) then {
    _objectivesSaved = profileNameSpace getVariable (missionPrefix + "objectivesSaved");
    _randomChance = random 100;
    if (_randomChance > 0) then {
      _randomNum = random [1,3,4];
      for "_i" from 1 to _randomNum do {
        _selectedOBJ = selectRandom _objectivesSaved;
        _objPos = _selectedOBJ select 0;
        _playerClose = [];
        {
        if ((_x distance _objPos) < 1000) then {
          _playerClose pushback _x;
        };
        }foreach allPlayers;
        _playerClose;
        _objMarker = _selectedOBJ select 3;
        _objSelect = 0;
        _objsSelected = [];
        while {_objSelect < 4} do {
          _obj = selectRandom _objectivesSaved;
          _objsSelected pushBackUnique _obj;
          _objSelect = _objSelect + 1;
        };
        _capturedStatus = _selectedOBJ select 2 select 0;
        if ((_capturedStatus isEqualTo "opfor") && ((count _playerClose) isEqualTo 0)) then {
            //_selectedSafePos = [_objPos,0,40,7] call BIS_fnc_findSafePos;
            _roadsNearPos = _objPos nearRoads 1200;
            _selectedSafePos = getPosATL (selectRandom _roadsNearPos);
            if !(isNil "_selectedSafePos") then {
            _vehAllowed = [];
            if ("light" in _opforVehPool) then {
              _vehs = vehs select 0;
              _vehAllowed pushback _vehs;
            };
            if ("medium" in _opforVehPool) then {
              _vehs = vehs select 1;
              _vehAllowed pushback _vehs;
            };
            if ("heavy" in _opforVehPool) then {
              _vehs = vehs select 2;
              _vehAllowed pushback _vehs;
            };
            _vehAllowed;
            _selectedVicCtg = selectRandom _vehAllowed;
            _selectedVic = selectRandom _selectedVicCtg;
            _vicSpawn = _selectedVic select 0;
            _vicCost = _selectedVic select 1;
            if (_vicCost < _opforForcePool) then {
              _vehSpawned = createVehicle [_vicSpawn,_selectedSafePos];
              [0,_vicCost] call vics_econ_forcePoolAdjust;
              _selectedGroup = selectRandom groupsDesignation;
              // If vem is enabled, group has a chance of having intel
              _groupHasIntel = false;
              if (vemEnabled) then {
                _randomGroupHasIntel = random 100;
                if (intelSpawnChances select 6 > _randomGroupHasIntel) then {
                  _groupHasIntel = true;
                };
              };
              // Add each unit to to group
              _seatCount = [_vicSpawn, true] call bis_fnc_crewCount;
              _randomAmountToAdd = round (random [2,(_seatCount/2),_seatCount]);
              _grp = createGroup east;
              for "_i" from 1 to _randomAmountToAdd do {
                _unitToCreate = selectrandom genUnitPool;
              _createdUnit = _grp createUnit [_unitToCreate,[0,0],[],0,"NONE"];
              };
              _units = units _grp;
              {
                _x moveInAny _vehSpawned;
                // Move units in group to vehicle,
                // check intel if relevant
                if (vemEnabled && _groupHasIntel) then {
                  _randomUnitHasIntel = random 100;
                  if (intelSpawnChances select 7 > _randomUnitHasIntel) then {
                    // This unit has intel
                    [_x] call vem_intel_unitAddRandomIntelItem;
                  };
                };
              } forEach _units;
              _leader = leader _grp;
              _leader moveInDriver _vehSpawned;
              {
                _selectedWPT = _x select 0;
                _nearestRoad = [_selectedWPT, 1000] call BIS_fnc_nearestRoad;
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
            } else {
            };
          };
        } else {
        };
      };
    };
  } else {
  };
};

vics_opfor_nvgs = {
  _opforGroups = profileNameSpace getVariable (missionPrefix + "opforGroups");
  _dayTime = dayTime;
  if ((_dayTime > 19) or (_dayTime < 5)) then {
    {
      _unit = _x;
      _nvgCheck = [_unit, "rhs_1PN138"] call BIS_fnc_hasItem;
      if (_nvgCheck) then {
        _unit assignItem "rhs_1PN138";
      };
    }forEach (units east);
  };
};

vics_opfor_roadblockGen = {
  _objectivesSaved = profileNameSpace getVariable (missionPrefix + "objectivesSaved");
  for "_i" from 1 to (random[2,5,12]) do {
    _selectedOBJ = selectRandom _objectivesSaved;
    _objectivePos = _selectedOBJ select 0;
    _objExtrasArray = _selectedOBJ select 7;
    _objRoadblocks = _objExtrasArray select 11;
    if ((count _objRoadblocks) < 2) then {
      _blackListMarkers = objectiveOffwhiteList + objectiveSpawnBlacklist;
      _inBlacklist = [_objectivePos,_blackListMarkers] call vics_sys_posInBlacklist;
      if !(_inBlacklist) then {
        _objectiveMarker = _selectedOBJ select 3;
        _randomPos = [[_objectiveMarker]] call BIS_fnc_randomPos;
        _nearestRoad = [_randomPos, 1000] call BIS_fnc_nearestRoad;
        _roadPos = getPos _nearestRoad;
        _connectingRoad = roadsConnectedTo _nearestRoad;
        _selectedRoad = _connectingRoad select 0;
        _roadblockDir = _selectedRoad getDir _nearestRoad;
        if (_roadblockDir >= 270) then {
          _roadblockDir = _roadblockDir - 90;
        } else {
          _roadblockDir = _roadblockDir + 90;
        };
        _roadBlockComp = ["roadblock1",_roadPos,[0,0,-0.1],_roadblockDir,true,true,true] call LARs_fnc_spawnComp;
        _roadblockCreated = ["roadblock1",_roadPos,_roadblockDir];
        _objRoadblocks pushBack _roadblockCreated;
        _taskMarker = createMarker [_roadBlockComp, _roadPos];
        //_taskMarker setMarkerType "hd_dot";
        //_taskMarker setMarkerText "Roadblock";
        _objIndex = _objectivesSaved find _selectedOBJ;
        _objExtrasArray set [11,_objRoadblocks];
        _selectedOBJ set [7,_objExtrasArray];
        _objectivesSaved set [_objIndex, _selectedOBJ];
      } else {
        //In blacklist of markers
      };
    };
  };
  profileNameSpace setVariable [(missionPrefix + "objectivesSaved"),_objectivesSaved];
  true;
};

vics_opfor_installations = {
  _opforObjectives = missionNameSpace getVariable "opforObjectivesArray";
  _opforInstallations = profileNameSpace getVariable (missionPrefix + "opforInstallations");
  if (isNil "_opforInstallations") then {
    _opforInstallations = [];
    profileNameSpace setVariable [(missionprefix + "opforInstallations"),_opforInstallations];
  };
  _opforInstallations;
  _installationCount = count _opforInstallations;
  if (_installationCount < opforInstallationLimit) then {
    _objectiveSelected = selectRandom _opforObjectives;
    _objPos = _objectiveSelected select 0;
    _objWeight = _objectiveSelected select 1;
    _objTicks = _objectiveSelected select 2 select 1;
    _installationsAllowed = [];
    if (_objWeight > 4) then {
      _installationsAllowed = vicsInstallations;
    };
    if ((_objWeight >= 2) &&( _objWeight <= 4)) then {
      _installationsAllowed = [(vicsInstallations select 0),(vicsInstallations select 1)];
    };
    if (_objWeight isEqualTo 1) then {
      _installationsAllowed = [(vicsInstallations select 0)];
    };
  _installationsAllowed;
  _randomPos = [[[_objPos,1200]]] call BIS_fnc_randomPos;
  _randomCompSize = selectRandom _installationsAllowed;
  systemChat str _randomCompSize;
  _randomComp = selectRandom _randomCompSize;
  systemChat str _randomComp;
  _randomDir = random 359;
  _compSpawned = [_randomComp,_randomPos,[0,0,0],_randomDir,true,true,true] call LARs_fnc_spawnComp;
  _compArray = [_compSpawned,_randomComp,_randomPos,_randomDir];
  systemChat str _compArray;
  _opforInstallations pushBack _compArray;
  _mrk = createMarker [(str _randomPos),_randomPos];
  _mrk setMarkerType "hd_dot";
  profileNameSpace setVariable [(missionprefix + "opforInstallations"),_opforInstallations];
  };
};

vics_opfor_saveInstallations = {

};

vics_opfor_loadInstallations = {

};

vics_opfor_iedSpawn = {
  params [["_position",nil],["_iedType","ACE_IEDLandBig_Range_Ammo"]];
  if !(isNil "_position") then {
    _iedCreated = createVehicle [_iedType,_position,[],3,"CAN_COLLIDE"];
    east revealMine _iedCreated; //Red force
    civilian revealMine _iedCreated; //Civ population
  };
};

//Must be spawned not called
vics_opfor_SimpleConvoy = {
	params ["_convoyGroup",["_convoySpeed",50],["_convoySeparation",50],["_pushThrough", true]];
	if (_pushThrough) then {
		_convoyGroup enableAttack !(_pushThrough);
		{(vehicle _x) setUnloadInCombat [false, false];} forEach (units _convoyGroup);
	};
	_convoyGroup setFormation "COLUMN";
	{
    	(vehicle _x) limitSpeed _convoySpeed*1.15;
        (vehicle _x) setConvoySeparation _convoySeparation;
    } forEach (units _convoyGroup);
	(vehicle leader _convoyGroup) limitSpeed _convoySpeed;
	while {!isNull _convoyGroup} do {
		{
			if ((speed vehicle _x < 5) && (_pushThrough || (behaviour _x != "COMBAT"))) then {
				(vehicle _x) doFollow (leader _convoyGroup);
			};
		} forEach (units _convoyGroup)-(crew (vehicle (leader _convoyGroup)))-allPlayers;
        {(vehicle _x) setConvoySeparation _convoySeparation;} forEach (units _convoyGroup);
        sleep 5;
	};
};

vics_opfor_spawnConvoy = {
  _opforVehs = profileNameSpace getVariable (missionPrefix + "opforVehs");
  _opforVehPool = profileNameSpace getVariable (missionPrefix + "opforVehPool");
  _opforForcePool = profileNameSpace getVariable (missionPrefix + "opforForcePool");
  _convoyLength = round random [2,3,4];
  if (_opforVehPool isEqualTo []) exitWith {};
  if (isNil "_opforVehs") then {
    _opforVehs = [];
  };
  _opforVehs;
  if ((count _opforVehs + _convoyLength) < vehLimit) then {
    _objectivesSaved = profileNameSpace getVariable (missionPrefix + "objectivesSaved");
    _randomChance = random 100;
    if (_randomChance > 70) then {
      _randomNum = random [2,3,4];
      for "_i" from 1 to _randomNum do {
        _selectedOBJ = selectRandom _objectivesSaved;
        _objPos = _selectedOBJ select 0;
        _playerClose = [];
        {
        if ((_x distance _objPos) < 1000) then {
          _playerClose pushback _x;
        };
        }foreach allPlayers;
        _playerClose;
        _objMarker = _selectedOBJ select 3;
        _objSelect = 0;
        _objsSelected = [];
        while {_objSelect < 4} do {
          _obj = selectRandom _objectivesSaved;
          _objsSelected pushBackUnique _obj;
          _objSelect = _objSelect + 1;
        };
        _capturedStatus = _selectedOBJ select 2 select 0;
        if ((_capturedStatus isEqualTo "opfor") && ((count _playerClose) isEqualTo 0)) then {
            //_selectedSafePos = [_objPos,0,40,7] call BIS_fnc_findSafePos;
            _roadsNearPos = _objPos nearRoads 1200;
            _selectedSpawnRoad = getPosATL (selectRandom _roadsNearPos);
            if !(isNil "_selectedSpawnRoad") then {
            _vehAllowed = [];
            if ("light" in _opforVehPool) then {
              _vehs = vehs select 0;
              _vehAllowed pushback _vehs;
            };
            if ("medium" in _opforVehPool) then {
              _vehs = vehs select 1;
              _vehAllowed pushback _vehs;
            };
            if ("heavy" in _opforVehPool) then {
              _vehs = vehs select 2;
              _vehAllowed pushback _vehs;
            };
            _vehAllowed;
            _convoyGrp = createGroup [East, true];
            for "_j" from 1 to _convoyLength do {
              _selectedSafePos = [_selectedSpawnRoad,0,40,12] call BIS_fnc_findSafePos;
              _nearRoads = _selectedSpawnRoad nearRoads 20;
              _selectedVicCtg = selectRandom _vehAllowed;
              _selectedVic = selectRandom _selectedVicCtg;
              _vicSpawn = _selectedVic select 0;
              _vicCost = _selectedVic select 1;
              if (_vicCost < _opforForcePool) then {
                _randomRoad = selectRandom _nearRoads;
                _roadDir = getDir _randomRoad;
                _vehSpawned = createVehicle [_vicSpawn,_randomRoad];
                _vehSpawned setDir _roadDir;
                //_vehSpawned setPos _selectedSafePos;
                [0,_vicCost] call vics_econ_forcePoolAdjust;
                _selectedGroup = selectRandom groupsDesignation;
                // If vem is enabled, group has a chance of having intel
                _groupHasIntel = false;
                if (vemEnabled) then {
                  _randomGroupHasIntel = random 100;
                  if (intelSpawnChances select 6 > _randomGroupHasIntel) then {
                    _groupHasIntel = true;
                  };
                };
                // Add each unit to to group
                _seatCount = [_vicSpawn, true] call bis_fnc_crewCount;
                _randomAmountToAdd = round (random [2,(_seatCount/2),_seatCount]);
                _grp = createGroup east;
                for "_i" from 1 to _randomAmountToAdd do {
                  _unitToCreate = selectrandom genUnitPool;
                _createdUnit = _grp createUnit [_unitToCreate,[0,0],[],0,"NONE"];
                };

                _units = units _grp;
                {
                  _x moveInAny _vehSpawned;
                  // Move units in group to vehicle,
                  // check intel if relevant
                  if (vemEnabled && _groupHasIntel) then {
                    _randomUnitHasIntel = random 100;
                    if (intelSpawnChances select 7 > _randomUnitHasIntel) then {
                      // This unit has intel
                      [_createdUnit] call vem_intel_unitAddRandomIntelItem;
                    };
                  };
                } forEach _units;
                _leader = leader _grp;
                _leader moveInDriver _vehSpawned;
                {
                  [_x] joinSilent _convoyGrp;
                }forEach units _grp;

              } else {

              };
            };
            {
              _selectedWPT = _x select 0;
              _nearestRoad = [_selectedWPT, 1000] call BIS_fnc_nearestRoad;
              _roadPos = getPos _nearestRoad;
              _waypoint = _convoyGrp addWaypoint [_roadPos,-1];
              _waypoint setWaypointType "MOVE";
            } forEach _objsSelected;
            _waypointCycle = _convoyGrp addWaypoint [_selectedSpawnRoad, -1];
            _waypointCycle setWaypointType "CYCLE";
            _wpIndex = currentWaypoint _convoyGrp;
            [_convoyGrp,_wpIndex] setWaypointBehaviour "SAFE";
            _randomPushThrough = random 100;
            _pushThrough = true;
            //Random chance for group to push through contact or stop and engage
            if (_randomPushThrough < 50) then {
              _pushThrough = false;
            };
            //set convoy behavior to group
            [_convoyGrp, 45, 30, _pushThrough] spawn vics_opfor_SimpleConvoy;
          };
        } else {

        };
      };
    };
  } else {

  };
};

vics_opfor_artyRequest = {
  _artyChanceChallenge = random 100;
  if (_artyChanceChallenge < opforArtyChance) then {
    _amountToCall = round random opforArtyAmount;
    for "_i" from 1 to _amountToCall do {
      _objectivesSaved = profileNameSpace getVariable (missionPrefix + "objectivesSaved");
      _objectiveSelected = selectRandom _objectivesSaved;
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
        //Objective not in blacklist
        _ordnanceTypes = ["Sh_82mm_AMOS","Sh_120mm_HE","Sh_155mm_AMOS","Sh_120mm_HE_Tracer_Red"];
        _ordnanceChances = [0.8,0.4,0.2,0.3];
        _ordnanceRandomType = _ordnanceTypes selectRandomWeighted _ordnanceChances;
        _radius = random [100,150,400];
        _rounds = random [3,7,14];
        _delayLowerBound = random [1,3,5];
        _delayUpperBound = random [4,7,10];
        _delay = [_delayLowerBound,_delayUpperBound];
        [_objPos,_ordnanceRandomType,_radius,_rounds,_delay] spawn vics_opfor_artyEngage;


      } else {
        //Objective in blacklist
      };
    };
  } else {
    //Did not pass random chance challenge
  };
};

vics_opfor_artyEngage = {
  params ["_pos",["_ordnance","	Sh_82mm_AMOS"],["_radius",100],["_rounds",12],["_delay",[2,9]]];
  systemChat "Arty request recieved";
  _velocity = 150;
  if (_ordnance isEqualTo "R_230mm_HE") then {
    _velocity = 2000
  };
  [_pos, _ordnance, _radius, _rounds, _delay,{false},0,500,_velocity] spawn BIS_fnc_fireSupportVirtual;
  /*
  _mrkrName = ("arty" + str _ordnance);
  _mrkr = createMarker [_mrkrName,_pos];
  _mrkr setMarkerType "hd_dot";
  _mrkr setMarkerText _mrkrName;
  */
};

vics_opfor_getState = {
  params ["_unit"];
  _state = _unit getVariable ["unitCombatState","none"];
  switch (_state) do {
    case "none";
    case "flee": {[_unit] call vics_opfor_stateFlee};
  };
};

vics_opfor_stateAttack = {
  params ["_unit"];
};

vics_opfor_stateFlee = {
  params ["_unit"];
  _group = group _unit;
  _unitPos = getPos _unit;
  _nearestPlayer = [_unitPos] call vics_sys_nearestPlayer;
  if !(isNil "_nearestPlayer") then {
    _playerDir = _unitPos getDir _nearestPlayer;
    _fleePosition = _unitPos getPos [2000,(_playerDir + 180)];
    [_group, _fleePosition, 50, "MOVE", "CARELESS", "YELLOW", "FULL", "COLUMN", "", [0,0,0]] call CBA_fnc_addWaypoint;
  } else {
    //Nearest Player is nil
  };
};

vics_opfor_spotter = {
  _objectivesSaved = profileNameSpace getVariable (missionPrefix + "objectivesSaved");
  {
    _selectedOBJ = _x;
    _objPos = _selectedOBJ select 0;
    _civArray = _selectedOBJ select 6;
    _extrasArray = _selectedOBJ select 7;
    _objHostility = _extrasArray select 2;
    {
      _civ = _x;
      _spotterBool = _civ getVariable ["spotterBool",false];
      _playersKnown = [];
      if (_spotterBool) then {
        {
          systemChat "Is Spotter";
          _player = _x;
          _knowsAbout = _civ knowsAbout _player;
          systemChat str _knowsAbout;
          diag_log str _knowsAbout;
          if (_knowsAbout >= 1) then {
            systemChat "Civilian Knows about a player.";
            _playersKnown pushBack _player;
          };
        }forEach allPlayers;
        if ((count _playersKnown) > 0) then {
          //Chance for civ to follow players
          if ((random 100) < 30) then {
            _target = selectRandom _playersKnown;
            [_civ] call CBA_fnc_clearWaypoints;
            //If civilian is still near town then follow player
            if ((_civ distance2D _objPos) < 450) then {
              [_civ,(getPos _target), 50, "MOVE", "SAFE", "GREEN", "LIMITED"] call CBA_fnc_addWaypoint;
            };
          };
          //Call nearby opfor to player location
          [(getPos _target)] call vics_opfor_qrfCall;
          systemChat "You were reported to OPFOR by a civilian spotter.";
        };
      };
    }forEach _civArray;
  } forEach _objectivesSaved;
};

//Waiting until 2.10 release to use below code
/*
vics_opfor_spotter = {
  params ["_group","_target","_value"];
  SystemChat "Civilian knows about blufor target.";
  if (isPlayer _target) then {
    systemChat "It is a player.";
  };
};
*/

vics_opfor_circle = {
  _posStart = getPos player;
  _grp = createGroup civilian;
  _unit = _grp createUnit ["UK3CB_TKC_C_CIV",_posStart,[],0,"NONE"];
  for "_i" from 1 to 20 do {
    _degEach = 360/20;
    _degChange = _degEach * _i;
    _posGot = _posStart getPos [300,_degChange];
    _mrkr = createMarker [(str _posGot),_posGot];
    _mrkr setMarkerType "HD_DOT";
    [_grp,_posGot] call CBA_fnc_addWaypoint;
  };
};
