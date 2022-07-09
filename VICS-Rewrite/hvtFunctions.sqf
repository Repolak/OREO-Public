//HVT Functions - This will be a framework for providing a new dynamic to arma gameplay
/*
HVT Types params:
THIS IS NOT UPDATED!!!!!!!!!!!!!
Name of HVT - String - required
Naturally hostile towards blufor - bool - required
Skill level, 0 = random, 1 = low, 2 = medium, 3 = high - integer - optional
Group skill level, 0 = random, 1 = low, 2 = medium, 3 = high - integer - optional
Native, effects skill of group - bool - optional
Combat trait - wether or not wants to fight or flee - integer - optional
group size - [min,max] - array - optional
subSkillRange - array - optional
THIS IS NOT UPDATED!!!!!!!!!!!!!
example:
[["name","className"], hostility personSkill[weapon skill, perception, leadership], groupSkill[weapon skill, perception, leadership], native, combat, [groupsizeMin, groupsizeMax],isLeader]

[["Local leader", "localLeader"], false, [1,1,2], [1,2,1], true, 0.2, [3,8], false]
[["Mercenary", "pmc"], true, [3,2,3], [2,2,2], false, 1, [5,9,14], true],
[["Local warlord", "localWarlord"], true, [2,1,2], [1,2,1], true, 0.7, [5,9,14], true],
[["Scholar", "localScholar"], false, [1,1,1], [1,2,1], true, 0.1, [3,5,8], false],
[["Trainer", "localTrainer"], true, [1,2,3], [1,2,2], true, 0.4, [5,7,10], true],
[["Arms dealer", "localArmsDealer"], false, [1,2,1], [2,2,2], true, 0.2, [10,13,16], true],
[["Royal","localRoyal"]. false, [1,1,1], [2,2,3], true, 0.1, [12,15,18], false],
[["Informant", "localInformant"], false, [1,1,1], [2,2,3], true, 0.1, [12,14,18], false],
*/

hvtTypes = [
    [["Local leader", "localLeader"], false, [1,1,2], [1,2,1], true, 0.2, [3,5,8], false],
    [["Mercenary", "localLeader"], true, [3,2,3], [2,2,2], false, 1, [5,9,14], true],
    [["Local warlord", "localLeader"], true, [2,1,2], [1,2,1], true, 0.7, [5,9,14], true],
    [["Scholar", "localLeader"], false, [1,1,1], [1,2,1], true, 0.1, [3,5,8], false],
    [["Trainer", "localLeader"], true, [1,2,3], [1,2,2], true, 0.4, [5,7,10], true],
    [["Arms dealer", "localLeader"], false, [1,2,1], [2,2,2], true, 0.2, [10,13,16], true],
    [["Royal","localLeader"], false, [1,1,1], [2,2,3], true, 0.1, [12,15,18], false],
    [["Informant", "localLeader"], false, [1,1,1], [2,2,3], true, 0.1, [12,14,18], false]];

hvtFirstNames = ["Coman", "Amit", "Sofian", "Masud", "Sadiq", "Rahul", "Muhammad",
                "Waleed", "Dameer", "Hasan", "Rahman", "Hussien", "Jimell", "Zimraan",
                "Mahir", "Hasan", "Hakim", "Tabari", "Abdullahi", "Siraj", "Jawhar",
                "Azhar", "Nadir", "Harb", "Jimell", "Asadel", "Sayyid", "Najib", "Suhail",
                "Zakariyya", "Sofian", "Haroon", "Ghazi", "Ziyad", "Omar", "Dameer",
                "Rakim"];

hvtLastNames = ["Samaan", "Hakim", "Noori", "Tahir", "Soliman", "Yousef", "Qadir",
                "Zaher", "Laham", "Shaer", "Amen", "Omar", "Siddique", "Jabbar", "Alam",
                "Fayad", "Mahmoud", "Bangura", "Hamed", "Gaber", "Farha", "Hatem",
                "Mohammed", "Jabara", "Youssef", "Abed", "Naderi", "Mattar", "Sadri",
                "Mohammadi", "Koroma", "Atallah", "Hariri", "Hasen", "Idris", "Pirani",
                "Mannan", "Bagheri", "Shehata"];

// Ayatollah - very high religious authority, Emir - "Commander of the faithful"
// Imam - "prayer leader", Mufti - Law scholar, Shah - A monarch
// Sheikh - Elder, wise person
hvtEsteemedTitles = ["Ayatollah", "Emir", "Imam", "Mufti", "Mullah", "Shah", "Sheikh"];
hvtPossibleTitles = [["localLeader",["Sheikh","Imam"]]];

hvtPrimaryWeapons = ["rhs_weap_MP44","rhs_weap_pp2000","UK3CB_ACR_Crew","rhs_weap_savz61","uk3cb_sks_02","UK3CB_G3A3"];
hvtUniforms = ["UK3CB_TKM_B_U_06_C","UK3CB_TKM_I_U_06_C","UK3CB_B_U_CombatUniform_01_WDL","UK3CB_MEI_B_U_CombatUniform_WDL_03_JEANS_WHITE"];
hvtVests = ["UK3CB_TKA_O_V_6b23_ml_Oli","UK3CB_V_Belt_Rig_KHK","rhs_chicom_khk","V_CarrierRigKBT_01_Olive_F"];
hvtHeadgear = ["rhssaf_helmet_m97_woodland","rhs_headband","UK3CB_H_Beanie_02_GRY","UK3CB_H_Bandanna_Red_Check"];
hvtFacewear = ["VSM_beard_2","VSM_FaceMask_black","G_Aviator","UK3CB_G_Bandanna_aviator_brown_check","immersion_cigs_cigar0"];

/*
 * Author: Repo
 * Checks if should spawn HVT at objective and saves HVT to objective.
 *
 * Arguments:
 * None
 *
 * Return Value:
 * None
 *
 * Example:
 * [] call vics_hvt_generate
 */

vics_hvt_generate = {
  _objectivesSaved = profileNameSpace getVariable (missionPrefix + "objectivesSaved");
  _hvtsAlive = 0;
  {
    private _random100 = random 100;
    if (_random100 < 10) then {
      _selectedOBJ = _x;
      _selectedPos = _selectedOBJ select 0;
      _objectiveWeight = _selectedOBJ select 1;
      _objExtrasArray = _selectedOBJ select 7;
      _objHostility = _objExtrasArray select 2;
      _objHVTs = _objExtrasArray select 9;
      diag_log format ["%1 HVTs: %2",_selectedPos,_objHVTs];
      if ((count _objHVTs) > 0) then {
        _hvtsAlive = _hvtsAlive + 1;
      };
      if (_hvtsAlive < chanceOfHVT) then {
        if ((count _objHVTs) isEqualTo 0) then {
          _safePos = [_selectedPos,0,100,5] call BIS_fnc_findSafePos;
          _blackListMarkers = objectiveOffwhiteList + objectiveSpawnBlacklist;
          _inBlacklist = [_selectedPos,_blackListMarkers] call vics_sys_posInBlacklist;
          if (_inBlacklist isEqualTo false) then {
            _capturedStatus = _selectedOBJ select 2 select 0;
            _currentMarker = _selectedOBJ select 3;
            _objIndex = _objectivesSaved find _selectedOBJ;
            _chanceToPopulate = random 100;
            if (true) then {
              _playerClose = [_safePos,fillerDistanceMinimum] call vics_sys_playersNearPos;
              if (count _playerClose isEqualTo 0) then {
                _createdHVT = [_safePos,_objHostility,_selectedOBJ] call vics_hvt_hvtPopulate;
                _objHVTs pushBack _createdHVT;
                //_name = [_target] call ace_common_fnc_getName;
                _hvtsAlive = _hvtsAlive + 1;
                _objExtrasArray set [9,_objHVTs];
                _selectedOBJ set [7,_objExtrasArray];
                _objectivesSaved set [_objIndex, _selectedOBJ];
              };
            } else {
              //Not valid to spawn Filler Groups
              systemChat "VICS-HVT: Cant spawn filler groups";
            };
          } else {
            systemChat "VICS-HVT: Spawn in blacklist";
          };
        } else {
          //OBJ already has an HVT
          systemChat "VICS-HVT: OBJ has HVTs already";
        };
      } else {
        //HVTs alive is at maximum
        systemChat "VICS-HVT: HVTs are at maximum";
      };
    } else {
      //OBJ Didnt pass random chance
      systemChat "VICS-HVT: OBJ did not pass random check";
    };
    uiSleep 0.05;
  } forEach _objectivesSaved;
  profileNameSpace setVariable [(missionPrefix + "objectivesSaved"),_objectivesSaved];
};

/*
 * Author: Repo
 * Creates HVT unit and group in specified position and assigns a job.
 *
 * Arguments:
 * 0: Position to spawn units <array>
 * 1: Objective to attach HVT to <Array>
 *
 *
 * Return Value:
 * HVT Data <Array>
 *
 * Example:
 * [[0,0,0],[Objective Array]] call vics_hvt_hvtPopulate
 */

vics_hvt_hvtPopulate = {
  params ["_position","_objective"];
  //diag_log "Tried to spawn";
  _cqbHasIntel = false;
  if (vemEnabled) then {
    _cqbIntelRandomNum = random 100; // Betw 0-1000
    if(intelSpawnChances select 2 > _cqbIntelRandomNum) then {
      _cqbHasIntel = true;
    };
  };
  _hvtGroupArray = [];
  _selectedGroup = selectRandom groupsDesignation;
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
     _hvtGroupArray pushBackUnique _createdUnit;
     //diag_log "Spawning unit";
   }forEach _selectedGroup;
   //[_position,_group] call vics_opfor_patrol;
   _leader = leader _group;
   _leader addEventHandler ["Killed", {
     _qrfPos = ASLToAGL getPosASL (_this select 0);
     [_qrfPos] spawn vics_opfor_qrfCall;
   }];
   _units = units _group;
   _hvtUnit = selectRandom _units;
   _hvtUnitIndex = _units find _hvtUnit;
   _random100 = random 100;
   if (_random100 > 50) then {
     removeHeadgear _hvtUnit;
     _hvtUnit addHeadgear (selectRandom hvtHeadgear);
   };

   _random100 = random 100;
   if (_random100 > 50) then {
     _vestItems = vestItems _hvtUnit;
     removeVest _hvtUnit;
     _hvtUnit addVest (selectRandom hvtVests);
     {
       _hvtUnit addItemToVest _x;
     }forEach _vestItems;
   };

   _random100 = random 100;
   if (_random100 > 50) then {
     _rifle = primaryWeapon _hvtUnit;
     _hvtUnit removeWeaponGlobal _rifle;
     [_hvtUnit, (selectRandom hvtPrimaryWeapons), (round(random [2,4,6]))] call BIS_fnc_addWeapon;
   };
   _hvtLoadout = getUnitLoadout _hvtUnit;
   _hvtName = name _hvtUnit;
   _hvtFace = face _hvtUnit;
   _hvtIdentity = [_hvtName,_hvtFace];
   _hvtPersonality = [_position]call vics_hvt_personalityGen;
   [_position,_group] call vics_opfor_defend;
   //Unit, group array, position in group, loadout, Identity array
   _hvtArray = [_hvtUnit,_selectedGroup,_hvtUnitIndex,_hvtLoadout,_hvtIdentity,_hvtPersonality];
   _hvtUnit setVariable ["objectiveHome",_objective];
   _hvtUnit setVariable ["HVTArray",_hvtArray];
   //diag_log format ["VICS-HVT: Spawned: %1 Group: %2",_hvtGroupArray,_selectedGroup];
  _hvtArray;
};

/*
 * Author: Repo
 * Reads Checks all HVT units to make sure they are still alive.
 * If they are alive, add them to a new array and save it to the objective.
 *
 * Arguments:
 * None
 *
 * Return Value:
 * None
 *
 * Example:
 * [] call vics_hvt_saveHVTs
 */

vics_hvt_saveHVTs = {
  _objectivesSaved = profileNameSpace getVariable (missionPrefix + "objectivesSaved");
  {
    _objHVTsUpdated = [];
    _selectedOBJ = _x;
    _objExtrasArray = _selectedOBJ select 7;
    _objHVTs = _objExtrasArray select 9;
    _objIndex = _objectivesSaved find _selectedOBJ;
    {
      _hvtArray = _x;
      _hvtUnit = _hvtArray select 0;

      if !(alive _hvtUnit) then {
        systemChat "HVT is dead";
      } else {
        systemChat "HVT is still alive";
        _objHVTsUpdated pushBack _hvtArray;
      };
    }forEach _objHVTs;
    _objHVTsUpdated;
    _objExtrasArray set [9,_objHVTsUpdated];
    _selectedOBJ set [7,_objExtrasArray];
    _objectivesSaved set [_objIndex, _selectedOBJ];
  } forEach _objectivesSaved;
  profileNameSpace setVariable [(missionPrefix + "objectivesSaved"),_objectivesSaved];
};

/*
 * Author: Repo
 * Reads all HVT arrays in save game and spawns corrisponding units.
 *
 * Arguments:
 * None
 *
 * Return Value:
 * None
 *
 * Example:
 * [] call vics_hvt_loadHVTs
 */

vics_hvt_loadHVTs = {
  _objectivesSaved = profileNameSpace getVariable (missionPrefix + "objectivesSaved");
  {
    _objHVTsUpdated = [];
    _selectedOBJ = _x;
    _objPos = _selectedOBJ select 0;
    _objExtrasArray = _selectedOBJ select 7;
    _objHVTs = _objExtrasArray select 9;
    _objIndex = _objectivesSaved find _selectedOBJ;
    {
      _hvtArray = _x;
      _hvtGroup = _hvtArray select 1;
      _hvtUnitIndex = _hvtArray select 2;
      _hvtUnitLoadout = _hvtArray select 3;
      _hvtIdentity = _hvtArray select 4;
      _hvtPersonality = _hvtArray select 5;
      //Get a safe position to spawn group near objective
      _safePos = [_objPos,0,100,5] call BIS_fnc_findSafePos;
      if (isNil "_hvtPersonality") then {
        _hvtPersonality = [_safePos] call vics_hvt_personalityGen;
      };
      _hvtValues = _hvtPersonality select 0;
      _hvtDetails = _hvtPersonality select 1;
      _hvtHome = _hvtDetails select 0;
      _hvtWork = _hvtDetails select 1;
      //_homeMrkr = createMarker [(str _hvtHome),_hvtHome];
      _homeMrkr setMarkerType "HD_DOT";
      _homeMrkr setMarkerText "Home";
      //_workMrkr = createMarker [(str _hvtWork),_hvtWork];
      _workMrkr setMarkerType "HD_DOT";
      _workMrkr setMarkerText "Work";
      _cqbHasIntel = false;
      if (vemEnabled) then {
        _cqbIntelRandomNum = random 100; // Betw 0-100
        if(intelSpawnChances select 2 > _cqbIntelRandomNum) then {
          _cqbHasIntel = true;
        };
      };
      _hvtGroupArray = [];
      _group = createGroup [east, true];
      {
        _unitToSpawn = _x;
         _createdUnit = _group createUnit [_unitToSpawn,_safePos,[],0,"NONE"];
         if(vemEnabled && _cqbHasIntel) then {
           // This unit can have intel - see if they do
           _randomUnitHasIntel = random 100;
           if(intelSpawnChances select 3 > _randomUnitHasIntel) then {
             // This unit will have a piece of intel
             [_createdUnit] call vem_intel_unitAddRandomIntelItem;
            };
         };
         _hvtGroupArray pushBackUnique _createdUnit;
         //diag_log "Spawning unit";
       }forEach _hvtGroup;
       //[_position,_group] call vics_opfor_patrol;
       _leader = leader _group;
       //Add QRF call on killed leader
       _leader addEventHandler ["Killed", {
         _qrfPos = ASLToAGL getPosASL (_this select 0);
         [_qrfPos] spawn vics_opfor_qrfCall;
       }];
       _units = units _group;
       //Get HVT in group
       _hvtUnit = _units select _hvtUnitIndex;
       //Set Loadout of HVT
       _hvtUnit setUnitLoadout _hvtUnitLoadout;
       //Unit, group array, position in group, loadout
       //Create a new array with updated data
       //[_safePos,_group] call vics_opfor_defend;

       _hvtArrayUpdated = [_hvtUnit,_hvtGroup,_hvtUnitIndex,_hvtUnitLoadout,_hvtIdentity,_hvtPersonality];
       //Set variables to HVT unit
       [_hvtArrayUpdated] call vics_hvt_routine;
       _hvtUnit setVariable ["objectiveHome",_selectedOBJ];
       _hvtUnit setVariable ["HVTArray",_hvtArrayUpdated];
       //Set HVT name and face
       [_hvtUnit, (_hvtIdentity select 0)] remoteExec ["setName",0];
       [_hvtUnit, (_hvtIdentity select 1)] remoteExec ["setFace",0];
       //diag_log format ["VICS-HVT: Spawned: %1 Group: %2",_hvtGroupArray,_selectedGroup];
      _hvtArrayUpdated;
      _objHVTsUpdated pushBack _hvtArrayUpdated;
      uiSleep 0.05;
    }forEach _objHVTs;
    _objExtrasArray set [9,_objHVTsUpdated];
    _selectedOBJ set [7,_objExtrasArray];
    _objectivesSaved set [_objIndex, _selectedOBJ];
    uiSleep 0.05;
  } forEach _objectivesSaved;
  profileNameSpace setVariable [(missionPrefix + "objectivesSaved"),_objectivesSaved];
};


/*
 * Author: Repo
 * Replaces HVT array with a empty array on each objective saved.
 *
 * Arguments:
 * None
 *
 * Return Value:
 * None
 *
 * Example:
 * [] call vics_hvt_cleanup
 */
vics_hvt_cleanup = {
  _objectivesSaved = profileNameSpace getVariable (missionPrefix + "objectivesSaved");
  {
    _selectedOBJ = _x;
    _selectedPos = _selectedOBJ select 0;
    _objectiveWeight = _selectedOBJ select 1;
    _objExtrasArray = _selectedOBJ select 7;
    _objHostility = _objExtrasArray select 2;
    _objHVTs = _objExtrasArray select 9;
    _objIndex = _objectivesSaved find _selectedOBJ;
    _objExtrasArray set [9,[]];
    _selectedOBJ set [7,_objExtrasArray];
    _objectivesSaved set [_objIndex, _selectedOBJ];
  } forEach _objectivesSaved;
  profileNameSpace setVariable [(missionPrefix + "objectivesSaved"),_objectivesSaved];
};

vics_hvt_missionDisplay = {
  _objectivesSaved = profileNameSpace getVariable (missionPrefix + "objectivesSaved");
  _hvtSelected = nil;
  for "_i" from 1 to (count _objectivesSaved) do {
    _selectedOBJ = selectRandom _objectivesSaved;
    //_selectedPos = _selectedOBJ select 0;
    //_objectiveWeight = _selectedOBJ select 1;
    _objExtrasArray = _selectedOBJ select 7;
    //_objHostility = _objExtrasArray select 2;
    _objHVTs = _objExtrasArray select 9;
    if ((count _objHVTs) > 0) then {
      _hvtSelected = selectRandom _objHVTs;
    };
    if ((count _objHVTs) > 0) exitWith {systemChat "HVT Found."};
  };
  if !(isNil "_hvtSelected") then {
    _hvtUnit = _hvtSelected select 0;
    _hvtGroup = _hvtSelected select 1;
    _hvtUnitIndex = _hvtSelected select 2;
    _name = [_hvtUnit] call ace_common_fnc_getName;
    _age =  round random [29,43,86];
    _sizeOfGroup = count _hvtGroup;
    _hostilityOfHVT = "Unknown";
    if (_sizeOfGroup < 4) then {
      _hostilityOfHVT = "Low";
    };
    if (_sizeOfGroup < 8) then {
      _hostilityOfHVT = "Medium";
    };
    if (_sizeOfGroup >= 8) then {
      _hostilityOfHVT = "High";
    };
    _posOfHVT = getPosATL _hvtUnit;
    _randomPos = [[[(position _hvtUnit),500]]] call BIS_fnc_randomPos;
    _taskDescription = format ["An HVT location has been discovered in our intel. This is a Charlie Kilo FRAGO. <br/> Name: %1<br/> Age: %2<br/> Hostility: %3",_name,_age,_hostilityOfHVT];
    [
    true,
    ("hvtTsk" + str (round(random 100))),
    [_taskDescription,"FRAGO: HVT","hvtMarker"],
    _randomPos,
    "AUTOASSIGNED"
    ] call BIS_fnc_taskCreate;
  };
};

vics_hvt_personalityGen = {
  params ["_position"];
  _nearBuildings = nearestObjects [_position, ["House","Camp"], (objectiveSizeMultiplier/2)];
  _homeObject = selectRandom _nearBuildings;
  _homePosition = getPos _homeObject;
  _workObject = selectRandom _nearBuildings;
  _workPosition = getPos _workObject;
  //Values to generate [Hostility(Chance to go offensive),intelligence(skill level for hvt/suboridnates),insperation(group skill/size),political influence(Chance for high end units)]
  //Details about HVT [Home location,Work location,Job,affiliation,side,wealth,background]
  _hostility = random 100;
  _intelligence = random 100;
  _insperation = random 100;
  _influence = random 100;
  _hvtPersonality = [[_hostility,_intelligence,_insperation,_influence],[_homePosition,_workPosition,"Job","Affiliation","Side","Wealth","Background"]];
  _hvtPersonality;
};


vics_hvt_routine = {
  params ["_hvtArray"];
  _hvtUnit = _hvtArray select 0;
  _hvtGroup = group _hvtUnit;
  _hvtUnitIndex = _hvtArray select 2;
  _hvtUnitLoadout = _hvtArray select 3;
  _hvtIdentity = _hvtArray select 4;
  _hvtPersonality = _hvtArray select 5;
  _hvtGroup setVariable ["HVTIndex",_hvtUnitIndex];
  _hvtGroup setVariable ["hvtArray",_hvtArray];
  _isDay = call vics_sys_isDay;
  if (_isDay) then {
    [_hvtGroup] call CBA_fnc_clearWaypoints;
    _hvtWorkPos = _hvtPersonality select 1 select 1;
    _workBld = nearestBuilding _hvtWorkPos;
    systemChat str _workBld;
    _wp = _hvtGroup addWaypoint [getPos _workBld, -1];
    _wp setWaypointType "MOVE";
    _wp setWaypointBehaviour "SAFE";
    _wp setWaypointSpeed "NORMAL";
    //_wp setWaypointStatements ["true","_hvtUnitIndex = (group this) getVariable 'HVTIndex';_hvtUnit = thisList select _hvtUnitIndex; [_hvtUnit] join grpNull;"];
    _wp setWaypointStatements ["true","[this] call vics_hvt_goHome;"];
  } else {

  };
};

vics_hvt_goHome = {
  params ["_leader"];
  _hvtGroup = group _leader;
  _hvtArray = _hvtGroup getVariable "hvtArray";
  _hvtUnit = _hvtArray select 0;
  _hvtUnitIndex = _hvtArray select 2;
  _hvtUnitLoadout = _hvtArray select 3;
  _hvtIdentity = _hvtArray select 4;
  _hvtPersonality = _hvtArray select 5;
  _hvtWorkPos = _hvtPersonality select 1 select 1;
  _workBld = nearestBuilding _hvtWorkPos;
  _buildingPositions = _workBld buildingPos -1;
  _indoorPositions = [];
  {
    _isIndoor = [_x] call vics_sys_indoors;
    if (_isIndoor) then {
      _indoorPositions pushBack _forEachIndex;
    };
  }forEach _buildingPositions;
  [_hvtUnit] join grpNull;
  [[_hvtUnit]] call vics_sys_uncache;
  _newHvtGroup = group _hvtUnit;
  _wp = _newHvtGroup addWaypoint [getPos _workBld, -1];
  _wp waypointAttachObject _workBld;
  _wp setWaypointType "MOVE";
  _wp setWaypointBehaviour "SAFE";
  _wp setWaypointSpeed "NORMAL";
  _wp setWaypointHousePosition (selectRandom _indoorPositions);
  [getPos _workBld,_hvtGroup,150] call vics_opfor_perimeterPatrol;
  _securityLead = leader _hvtGroup;
  [[_securityLead]] call vics_sys_uncache;
};














/*

vem_hvt_arrayGen = {
  _hvtArrayGenerated = [];
  _hvtsToGen = hvtCount;
  //Checking if there are enough HVT types to have a different one for each hvt requested - Fun fact, < is different than >
    if ((count hvtTypes) > _hvtsToGen) then {
      for "_i" from 1 to _hvtsToGen do {
        _hvtSelected = selectRandom hvtTypes;
        if (_hvtSelected in _hvtArrayGenerated) then {

        } else {
          _hvtArrayGenerated pushback _hvtSelected;
        };
      };

    } else {

      for "_i" from 1 to _hvtsToGen do {
        _hvtSelected = selectRandom hvtTypes;
        _hvtArrayGenerated pushback _hvtSelected;
      };
    };
    _hvtArrayGenerated;
    [_hvtArrayGenerated] call vem_hvt_generate;
    //systemChat format ["%1",_hvtArrayGenerated];
    //systemChat format ["%1 - %2",(count _hvtArrayGenerated),_hvtsToGen];
};


vem_hvt_init = {
  systemchat "1";
 [hvtTypes] spawn vem_hvt_arrayGen;

};

vem_hvt_generate = {
  params ["_hvtArray"];
  systemchat "2";
  _count = 0;
  //params ["_hvtName","_hvtHostility","_hvtSkill",["_groupSkill",nil],["_native",false],["_combat",0.5],["_groupSize",[4,8]],[_hvtLeader,true]];
  _generatedHvtArray = [];
  _lowRating = [0.1,0.23,0.35];
  _medRating = [0.35,0.47,0.5];
  _highRating = [0.5,0.63,0.75];
  _hvtSkills = [];
  _groupSkills = [];
  {
    systemchat "loop1";
    _selectedHVT = _x;
    _hvtName = _selectedHVT select 0;
    _hvtHostility = _selectedHVT select 1;
    _hvtSkill = _selectedHVT select 2;
    _groupSkill = _selectedHVT select 3;
    _hvtNative = _selectedHVT select 4;
    _hvtCombatVal = _selectedHVT select 5;
    _hvtGroupSize = _selectedHVT select 6;
    _hvtLeader = _selectedHVT select 7;
    if (isNil "_groupSkill") then {
      _groupskill = _hvtSkill;
    };
    _groupSkill;
    _hvtWeapSkill = _hvtSkill select 0;
    _hvtPercepSkill = _hvtSkill select 1;
    _hvtLeadSkill = _hvtSkill select 2;
    //SubSkills index: [aimingAccuracy,aimingShake,aimingSpeed,reloadSpeed,spotDistance,spotTime,commanding,courage]
    if (_hvtWeapSkill == 0) then {
      for "_i" from 0 to 3 do {
        _rNum = random [0.1,0.4,0.7];
        _hvtSkills pushback _rNum;
      };
    };

    if (_hvtWeapSkill == 1) then {
      for "_i" from 0 to 3 do {
        _rNum = random _lowRating;
        _hvtSkills pushback _rNum;
      };
    };

    if (_hvtWeapSkill == 2) then {
      for "_i" from 0 to 3 do {
        _rNum = random _medRating;
        _hvtSkills pushback _rNum;
      };
    };

    if (_hvtWeapSkill == 3) then {
      for "_i" from 0 to 3 do {
        _rNum = random _highRating;
        _hvtSkills pushback _rNum;
      };
    };

    if (_hvtPercepSkill == 0) then {
      for "_i" from 0 to 2 do {
        _rNum = random [0.1,0.4,0.7];
        _hvtSkills pushback _rNum;
      };
    };

    if (_hvtPercepSkill == 1) then {
      for "_i" from 0 to 2 do {
        _rNum = random _lowRating;
        _hvtSkills pushback _rNum;
      };
    };

    if (_hvtPercepSkill == 2) then {
      for "_i" from 0 to 2 do {
        _rNum = random _medRating;
        _hvtSkills pushback _rNum;
      };
    };

    if (_hvtPercepSkill == 3) then {
      for "_i" from 0 to 2 do {
        _rNum = random _highRating;
        _hvtSkills pushback _rNum;
      };
    };

    if (_hvtLeadSkill == 0) then {
      _rNum = random [0.1,0.4,0.7];
      _hvtSkills pushback _rNum;
    };

    if (_hvtLeadSkill == 1) then {
      _rNum = random _lowRating;
      _hvtSkills pushback _rNum;
    };

    if (_hvtLeadSkill == 2) then {
      _rNum = random _medRating;
      _hvtSkills pushback _rNum;
    };

    if (_hvtLeadSkill == 3) then {
      _rNum = random _highRating;
      _hvtSkills pushback _rNum;
    };
    _hvtSkills;

    _groupWeapSkill = _groupSkill select 0;
    _groupPercepSkill = _groupSkill select 1;
    _groupLeadSkill = _groupSkill select 2;
    //SubSkills index: [aimingAccuracy,aimingShake,aimingSpeed,reloadSpeed,spotDistance,spotTime,commanding,courage]
    if (_groupWeapSkill == 0) then {
      for "_i" from 0 to 3 do {
        _rNum = random [0.1,0.4,0.7];
        _groupSkills pushback _rNum;
      };
    };

    if (_groupWeapSkill == 1) then {
      for "_i" from 0 to 3 do {
        _rNum = random _lowRating;
        _groupSkills pushback _rNum;
      };
    };

    if (_groupWeapSkill == 2) then {
      for "_i" from 0 to 3 do {
        _rNum = random _medRating;
        _groupSkills pushback _rNum;
      };
    };

    if (_groupWeapSkill == 3) then {
      for "_i" from 0 to 3 do {
        _rNum = random _highRating;
        _groupSkills pushback _rNum;
      };
    };

    if (_groupPercepSkill == 0) then {
      for "_i" from 0 to 2 do {
        _rNum = random [0.1,0.4,0.7];
        _groupSkills pushback _rNum;
      };
    };

    if (_groupPercepSkill == 1) then {
      for "_i" from 0 to 2 do {
        _rNum = random _lowRating;
        _groupSkills pushback _rNum;
      };
    };

    if (_groupPercepSkill == 2) then {
      for "_i" from 0 to 2 do {
        _rNum = random _medRating;
        _groupSkills pushback _rNum;
      };
    };

    if (_groupPercepSkill == 3) then {
      for "_i" from 0 to 2 do {
        _rNum = random _highRating;
        _groupSkills pushback _rNum;
      };
    };

    if (_groupLeadSkill == 0) then {
      _rNum = random [0.1,0.4,0.7];
      _groupSkills pushback _rNum;
    };

    if (_groupLeadSkill == 1) then {
      _rNum = random _lowRating;
      _groupSkills pushback _rNum;
    };

    if (_groupLeadSkill == 2) then {
      _rNum = random _medRating;
      _groupSkills pushback _rNum;
    };

    if (_groupLeadSkill == 3) then {
      _rNum = random _highRating;
      _groupSkills pushback _rNum;
    };
    _groupSkills;
    _hvtDisplayName = _hvtName select 0;
    _hvtSubClass = _hvtName select 1;
    _hvtSelectionIndex = _hvtSubClass find _hvtSubClass;
    _hvtPossibleClasses = hvtClassNames select _hvtSelectionIndex select 1;
    _hvtSelectedClass = selectRandom _hvtPossibleClasses;
    systemChat format ["HVT selected: %1",_hvtSelectedClass];
    _hvtGroupSizeSet = floor random _hvtGroupSize;

    _hvtGenerated = [_hvtName,_hvtSelectedClass,_hvtHostility,_hvtSkills,_groupSkills,_hvtNative,_hvtCombatVal,_hvtGroupSizeSet,_hvtLeader];
    _generatedHvtArray pushBack _hvtGenerated;
    systemChat format ["gen: %1",_hvtGenerated];
    _count = _count + 1;
    uiSleep 0.01;
  } forEach _hvtArray;
  systemChat format ["all: %1",_generatedHvtArray];
  copyToClipboard (str _generatedHvtArray);
  _count;
  systemChat format ["Total gen: %1",_count];
  systemChat format ["array: %1 - %2",_generatedHvtArray,(count _generatedHvtArray)];
  [_generatedHvtArray] call vem_hvt_request;
};


vem_hvt_request = {
  params ["_hvtArray"];
  _opforFobs = profileNameSpace getVariable (missionPrefix + "opforFobs");
  _enterableBuildings = [];
  {
    _hvtSelected = _x;
    _fobSelected = selectRandom _opforFobs;
    _fobPos = _fobSelected select 0;
    _nearBuildings = nearestObjects [_fobPos, ["House","Camp"], 1000];
    {
      _building = _x;
      _buildingPositions = _building buildingPos -1;
      if ((count _buildingPositions) > 0) then {
        //_marker = createMarker [(str _x), (getPos _x)];
        //_marker setMarkerType "mil_dot";
        _enterableBuildings pushBackUnique _building;
      };
    }forEach _nearBuildings;
    _hvtHome = selectRandom _enterableBuildings;
    _homePos = getPos _hvtHome;
    _hvtSelected pushback _fobPos;
    _hvtSelected pushback _hvtHome;
    _marker = createMarker [(str _homePos),_homePos];
    _marker setMarkerType "hd_dot";
    uiSleep 0.01;
  }forEach _hvtArray;
  //systemChat format ["House: %1",_hvtArray];
  _hvtArray;
  [_hvtArray] call vem_hvt_create;
};
hvtTestArray = [];
vem_hvt_create = {
  params ["_hvtArray"];
  {
    _hvtSelected = _x;
    _hvtSubClass = _hvtSelected select 0 select 1;
    _hvtComp = _hvtSelected select 1;
    _hvtSkills = _hvtSelected select 3;
    _groupSkills = _hvtSelected select 4;
    _hvtGroupSize = _hvtSelected select 7;
    _hvtLeader = _hvtSelected select 8;
    _hvtSpawnPoint = _hvtSelected select 10;
    _hvtGroupArray = [];
    _hvtCompSpawned = [_hvtComp,_hvtSpawnPoint,[0,0,0],0,True,false,False] call LARs_fnc_spawnComp;
    _hvtCompObjects = [_hvtCompSpawned] call LARs_fnc_getCompObjects;
    //systemChat format ["Objects:%1",_hvtCompObjects];
    _hvtObject = _hvtCompObjects select 1;
    hvtTestArray pushBack _hvtObject;
    _grp = createGroup [east,true];
    for "_i" from 1 to _hvtGroupSize do {
      _unitToCreate = selectRandom genUnitPool;
      _unit = _grp createUnit [_unitToCreate,_hvtSpawnPoint,[],0,"NONE"];
      // Determine if this group member should have intel
      _randomChanceUnitHasIntel = random 100;
      if(intelSpawnChances select 4 > _randomChanceUnitHasIntel) then {
        // Add intel to this unit
        [_unit] call vem_intel_unitAddRandomIntelItem;
      };
      _hvtGroupArray pushBackUnique _unit;
    };
    {
      _unit = _x;
      [_unit, _groupSkills] call vem_hvt_skillSet;
    }forEach _hvtGroupArray;
    // Determine if HVT themself should have intel
    _randomChanceHVThasIntel = random 100;
    if(intelSpawnChances select 5 > _randomChanceHVThasIntel) then {
      [_hvtObject] call vem_intel_unitAddRandomIntelItem;
    };
    // Set name of hvt to random
    // NOTE: Need to change this to pass class name
    // like localLeader, etc
    _hvtTypeName = _hvtArray select 0 select 1;
    [_hvtObject, _hvtSubClass] call vem_hvt_randomname;
    // Make HVT join group
    [_hvtObject] join _grp;
    if (_hvtLeader isEqualTo true) then {
      _grp selectLeader _hvtObject;
    };
    _hvtGroup = group _hvtObject;
    [(getPos _hvtObject), _hvtGroup] call vics_opfor_patrol;
    [_hvtObject, _hvtSkills] call vem_hvt_skillSet;




    uiSleep 0.01;
  }forEach _hvtArray;
};


vem_hvt_skillSet = {
  params ["_unit","_skillsArray"];
  //SubSkills index: [aimingAccuracy,aimingShake,aimingSpeed,reloadSpeed,spotDistance,spotTime,commanding,courage]
  _subSkills = ["aimingAccuracy","aimingShake","aimingSpeed","reloadSpeed","spotDistance","spotTime","commanding","courage"];
  {
    _index = _forEachIndex;
    _skillsArraySelected = _skillsArray select _index;
    _subSkillSelected = _subSKills select _index;
    _unit setSkill [_subSkillSelected,_skillsArraySelected];
    //systemChat format ["Skill: %1 Value: %2",_subSkillSelected,_skillsArraySelected];
    diag_log format ["Skill: %1 Value: %2 Unit: %3",_subSkillSelected,_skillsArraySelected,_unit];
  }forEach _subSkills;
};


// Takes a unit, assigns it a random name
// from the pools defined herein
// May want to implement title selection
// here at some point
vem_hvt_randomname = {
  params [["_target", player],["_unitSubClass", nil]];
  // Grab random first and last name
  _thisFirstName = selectRandom hvtFirstNames;
  _thisLastName = selectRandom hvtLastNames;
  _thisTitle = "";
  systemChat format ["%1", _unitSubClass];
  // Iterate through each group of possible titles
  {
    _thisTitleGroup = _x;
    if (_thisTitleGroup select 0 isEqualTo _unitSubClass) then {
      // This is desired class
      _thisTitleList = _thisTitleGroup select 1;
      _newTitle = selectRandom _thisTitleList;
      _thisTitle = _newTitle;
      systemChat format ["%1",_thisTitle];
    };
  } foreach hvtPossibleTitles;

  // Set targets name, call ace function to update
  _thisFullName = format ["%1 %2 %3", _thisTitle, _thisFirstName, _thisLastName];
  _target setName [_thisFullName, _thisFirstName, _thisLastName];
  _target call ace_common_fnc_setName;
  // Return name set to unit
  _thisFullName;
};

*/
