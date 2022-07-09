
vics_econ_aiLimiter = {
  _aiLimit = profileNameSpace getVariable (missionPrefix + "aiLimit");
  if (isNil "_aiLimit") then {
    _aiLimit = 0;
    profileNameSpace setVariable [(missionPrefix +"aiLimit"),_aiLimit];
  };
  _aiLimit;
  _objectivesSaved = profileNameSpace getVariable (missionPrefix + "objectivesSaved");
  _objectiveCount = (count _objectivesSaved);
  _aiLimit = (_objectiveCount * aiLimitMultiplier);
  if (_aiLimit > maxGroups) then {
    _aiLimit = maxGroups;
  };
  profileNameSpace setVariable [(missionPrefix + "aiLimit"),_aiLimit];
  true;
};

vics_econ_cycleMain = {
  if (runOnLoad isEqualTo true) then {
    [] spawn {
      _cycleTimer = (60 * cycleMultiplier);
      _startOrder = profileNameSpace getVariable (missionPrefix + "startOrder");
      if (_startOrder == "new") then {
        _objGeneration = [] call vics_obj_generation;
        waitUntil {_objGeneration isEqualTo true};
        uisleep 0.1;
        _hotZonesDetection = [] call vics_obj_hotzones;
        waitUntil {_hotZonesDetection isEqualTo true};
        _fobGeneration = [] call vics_obj_fobCreation;
        waitUntil {_fobGeneration isEqualTo true};
        [] call vics_tsk_forestLocationGen;
        _aiGeneration = [] call vics_opfor_request;
        waitUntil {_aiGeneration isEqualTo true};
        uiSleep 4;
        _aiPersist = [] call vics_opfor_persist;
        waitUntil {_aiPersist isEqualTo true};
        _aiLimit = [] call vics_econ_aiLimiter;
        waitUntil {_aiLimit isEqualTo true};
        ["VICS First run Complete. Please save the game if you are happy with the results, and restart to start the session.", "VICS_Econ", true] call vics_sys_debug;
      };
      if (_startOrder == "load") then {
        _objLoad = [] call vics_obj_loadObjectives;
        waitUntil {_objLoad isEqualTo true};
        _fobBlacklist = [] call vics_bld_loadFobPoints;
        waitUntil {_fobBlacklist isEqualTo true};
        _aiLimit = [] call vics_econ_aiLimiter;
        waitUntil {_aiLimit isEqualTo true};
        _aiLoad = [] call vics_opfor_load;
        waitUntil {_aiLoad isEqualTo true};
        // Init intel
        _intelInit = [] call vem_intel_init;
        waitUntil {_intelInit isEqualTo true};
        //_sortedOBJs = [] call vics_obj_sortDistanceInit;
        //waitUntil {_sortedOBJs isEqualTo true};
        [] call vics_sys_userMarkersLoad;
        [] call vics_tsk_init;
        [] call vics_sys_timeLoad;
        //Delaying the secondary loading pieces to help with lag.
        _vehLoad = [] call vics_sys_vehLoadNew;
        waitUntil {_vehLoad isEqualTo true};
        [] call vics_sys_crateLoad;
        //[] call vics_obj_randomDoorLock;
        [] call vics_sys_buildingDamageLoad;
        [] call vics_tsk_load;
        [] call vics_econ_civInit;
        [] call vics_ied_load;
        [] call vics_ied_trashLoad;
        [] call vics_tsk_drugProdLoad;
        [] call vics_sys_loadBags;
        [] call vics_econ_supplyLoad;
        [] call RBD_fnc_loadObjects;
        [] call vics_bld_loadPBPoints;
        [] call vics_hvt_loadHVTs;
        [] call vics_support_processShipping;
        //[] call vics_sys_tentLoad;
        ["Session Loaded.", "VICS_Econ", true] call vics_sys_debug;
          [] spawn vics_loop_sixty;
          [] spawn vics_loop_thirty;
          ["Secondary loops initilized.", "VICS_Econ", true] call vics_sys_debug;
          _loopCount = 0;
        while {true} do {
          _loopCount = _loopCount + 1;
          ["Core loop Requested", "VICS_Econ", true] call vics_sys_debug;
          if (_loopCount > 1) then {
            [] remoteExec ["vics_ply_creditEarn",0];
          };
          _opforMorale = [] call vics_econ_opforMorale;
          waitUntil {_opforMorale isEqualTo True};
          _opforForcePool = [] call vics_econ_forcePool;
          waitUntil {_opforForcePool isEqualTo True};
          _opforHostility = [] call vics_econ_objHostilityValue;
          waitUntil {_opforHostility isEqualTo True};
          _opforCommander = [] call vics_opfor_commander;
          waitUntil {_opforCommander isEqualTo True};
          _opforTasking = [] call vics_opfor_tasking;
          waitUntil {_opforTasking isEqualTo True};
          _opforRequest = [] call vics_opfor_request;
          waitUntil {_opforRequest isEqualTo True};
          [] call vics_opfor_nvgs;
          [] call vics_ied_request;
          [] call vics_tsk_drugProduction;
          [] call vics_econ_resources;
          [] call vics_ied_trashSpawn;
          if ((_loopCount mod cleanupTime) isEqualTo 0) then {
            _cleanup = [] call vics_sys_cleanup;
            waitUntil {_cleanup isEqualTo True};
          };
          if (((_loopCount mod autoSaveTime) isEqualTo 0) && ((count allPlayers) > 1)) then {
            [] call vics_sys_save;
          };
          if ((_loopCount mod productionTime)isEqualTo 0) then {
            [] call vics_econ_productionLoop;
          };
          if (((_loopCount mod productionTime)isEqualTo 0) && (_loopCount > 1)) then {
            //[] call vics_intel_process;
          };

          ["Core Loop Finished.", "VICS_Econ", true] call vics_sys_debug;
          uiSleep _cycleTimer;
        };
      };
    };
  } else {
    ["System start on load is disabled.", "VICS_Econ", true] call vics_sys_debug;
  };
};

vics_econ_forcePool = {
  params [["_add",0],["_remove",0]];
  _opforForcePool = profileNameSpace getVariable (missionPrefix + "opforForcePool");
  _objectivesSaved = profileNameSpace getVariable (missionPrefix + "objectivesSaved");
  _opforMorale = profileNameSpace getVariable (missionPrefix + "opforMorale");
  if (isNil "_opforForcePool") then {
    _opforForcePool = ((count _objectivesSaved) / 5);
    profileNameSpace setVariable [(missionPrefix + "opforForcePool"),_opforForcePool];
  };
  _opforForcePool;
  if (_opforMorale > 50) then {
    _opforForcePool = _opforForcePool + (2 * forcePoolMultipler);
  } else {
    _opforForcePool = _opforForcePool + (1 * forcePoolMultipler);
  };
  _opforForcePool;
  _opforForcePool = _opforForcePool + _add;
  _opforForcePool = _opforForcePool - _remove;
  _opforForcePool = floor _opforForcePool;
  profileNameSpace setVariable [(missionPrefix + "opforForcePool"),_opforForcePool];
  true;
};

vics_econ_forcePoolAdjust = {
  params [["_add",0],["_remove",0]];
  _opforForcePool = profileNameSpace getVariable (missionPrefix + "opforForcePool");
  _objectivesSaved = profileNameSpace getVariable (missionPrefix + "objectivesSaved");
  if (isNil "_opforForcePool") then {
    _opforForcePool = ((count _objectivesSaved) / 5);
    profileNameSpace setVariable [(missionPrefix + "opforForcePool"),_opforForcePool];
  };
  _opforForcePool;
  _opforForcePool = _opforForcePool + _add;
  _opforForcePool = _opforForcePool - _remove;
  _opforForcePool = floor _opforForcePool;
  profileNameSpace setVariable [(missionPrefix + "opforForcePool"),_opforForcePool];
  true;
};


vics_econ_opforMorale = {
  _opforMorale = profileNameSpace getVariable [(missionPrefix + "opforMorale"),50];
  _civMorale = profileNameSpace getVariable [(missionPrefix + "civMorale"),0];
  _objectivesSaved = profileNameSpace getVariable (missionPrefix + "objectivesSaved");
  _opforObjectivesArray = missionNameSpace getVariable ["opforObjectivesArray",[]];
  _bluforObjectivesArray = missionNameSpace getVariable ["bluforObjectivesArray",[]];
  _moraleModifier = ((count _objectivesSaved) / 300);
    {
      _objective = _x;
      _objectiveWeight = _x select 1;
      _weightModifier = (_objectiveWeight / 2);
      _objectiveCaptured = _x select 2 select 0;
      _opforMorale = _opforMorale + (_moraleModifier * _weightModifier);
      _civMorale = _civMorale - (_moraleModifier * _weightModifier);
    }forEach _opforObjectivesArray;

    {
      _objective = _x;
      _objectiveWeight = _x select 1;
      _weightModifier = (_objectiveWeight / 2);
      _objectiveCaptured = _x select 2 select 0;
      _opforMorale = _opforMorale - (_moraleModifier * _weightModifier);
      _civMorale = _civMorale + (_moraleModifier * _weightModifier);
    }forEach _bluforObjectivesArray;

    if (_opforMorale < 0) then {
      _opforMorale = 0;
    };
    if (_opforMorale > 100) then {
      _opforMorale = 100;
    };
    _opforMorale;
    if (_civMorale < -100) then {
      _civMorale = -100;
    };
    if (_civMorale > 100) then {
      _civMorale = 100;
    };
  _civMorale;
  profileNameSpace setVariable [(missionPrefix + "opforMorale"),_opforMorale];
  profileNameSpace setVariable [(missionPrefix + "civMorale"),_civMorale];
  true;
};



vics_econ_objOwner = {
  _objectivesSaved = profileNameSpace getVariable (missionPrefix + "objectivesSaved");
  _objectivesSavedUpdated = [];
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
  _bluforObjectivesArray = [];
  _opforObjectivesArray = [];
  _uncappedObjectiesArray = [];

  {
    _opForInArea = [];
    _BluforInArea = [];
    _objPos = _x select 0;
    _objWeight = _x select 1;
    _objCaptured = _x select 2 select 0;
    _objTicks = _x select 2 select 1;
    _objective = _x select 3;
    _cqbArray = _x select 4;
    _fillerArray = _x select 5;
    _civArray = _x select 6;
    _extrasArray = _x select 7;
    _objHostilityValue = _x select 7 select 2;
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
    _objCaptured = "opfor";
    _objTicks = objCapturedTicks;
    _opforObjectivesArray pushBack _x;
    [_x] call vics_obj_alert;
  } else {
    if ((count _BluforInArea) > (count _opForInArea)) then {
      _objCaptured = "blufor";
      _objTicks = objCapturedTicks;
      _bluforObjectivesArray pushBack _x;
      [0.05] call vics_support_creditChange;
    } else {
      if (((count _BluforInArea) + (count _opForInArea)) == 0) then {
        if !(_objCaptured isEqualTo "none") then {
          if (_objTicks isEqualTo 0) then {
            _objCaptured = "none";
          };
          if (_objTicks > 0) then {
            _objTicks = _objTicks - 1;
          };
        };
        if (_objCaptured isEqualTo "none") then {
          _objTicks = objCapturedTicks;
          _uncappedObjectiesArray pushBack _x;
        };
      };
    };
  };
  _objCaptured;
  _objTicks;
  _objectiveToSave = [_objPos,_objWeight,[_objCaptured,_objTicks],_objective,_cqbArray,_fillerArray,_civArray,_extrasArray];
  _objectivesSavedUpdated pushBackUnique _objectiveToSave;
  uiSleep 0.05;
  }forEach _objectivesSaved;
  _bluforObjectivesArray;
  _opforObjectivesArray;
  _uncappedObjectiesArray;
  profileNameSpace setVariable [(missionPrefix + "objectivesSaved"),_objectivesSavedUpdated];
  missionNameSpace setVariable ["bluforObjectivesArray",_bluforObjectivesArray];
  missionNameSpace setVariable ["opforObjectivesArray",_opforObjectivesArray];
  missionNameSpace setVariable ["UncappedObjectivesArray",_uncappedObjectiesArray];
  ["Objectives Updated","VICS_ECON",true] call vics_sys_debug;
true;
};

vics_econ_objHostilityValue = {
  //Opfor morale for for interaction system
  _objectivesSaved = profileNameSpace getVariable (missionPrefix + "objectivesSaved");
  _opforObjectivesArray = missionNameSpace getVariable ["opforObjectivesArray",[]];
  _bluforObjectivesArray = missionNameSpace getVariable ["bluforObjectivesArray",[]];
  {
    _objArray = _x;
    _objOwner = _objArray select 2 select 0;
    _objExtrasArray = _objArray select 7;
    _objHostilityValue = _objExtrasArray select 2;
    //systemChat format ["%1 %2 %3",_objOwner,_objExtrasArray,_objHostilityValue];
    if (isNil "_objHostilityValue") then {
      _objHostilityValue = 50;
    };
    if (_objOwner isEqualTo "opfor") then {
      //Opfor Owned Objective
      _objHostilityValue = _objHostilityValue + 0.5;
    } else {
      if (_objOwner isEqualTo "blufor") then {
        //Blufor Owned Objective
        _objHostilityValue = _objHostilityValue - 6;
      } else {
        //Empty Objective
        _objHostilityValue = _objHostilityValue - 1;
      };
    };
    if (_objHostilityValue > 100) then {
      _objHostilityValue = 100;
    };
    if (_objHostilityValue < 0) then {
      _objHostilityValue = 0;
    };
    if (_objHostilityValue <= 15) then {
      [0.05] call vics_support_creditChange;
    };
    _objExtrasArray set [2,_objHostilityValue];
    _objArray set [7,_objExtrasArray];
    _objectivesSaved set [_forEachIndex,_objArray];

  }forEach _objectivesSaved;
  profileNameSpace setVariable [(missionPrefix + "objectivesSaved"),_objectivesSaved];
  true;
};



vics_econ_civInit = {
  //civilian Morale for interaction system
  _civMorale = profileNameSpace getVariable [(missionPrefix + "civMorale"),nil];
  if (isNil "_civMorale") then {
    _civMorale = 0;
    profileNameSpace setVariable [(missionPrefix + "civMorale"),_civMorale];
  };
};

vics_econ_moraleSync = {
  params ["_unit"];
  _objectivesSaved = profileNameSpace getVariable (missionPrefix + "objectivesSaved");
  _civObjective = _unit getVariable "objectiveIndex";
  _selectedObj = _objectivesSaved select _civObjective;
  _objHostility = _selectedObj select 7 select 2;
  _unit setVariable ["objHostility",_objHostility,true];
  _civMoraleClient = profileNameSpace getVariable [(missionPrefix + "civMorale"),0];
  _opforMoraleClient = profileNameSpace getVariable (missionPrefix + "opforMorale");
  missionNameSpace setVariable ["civMoraleClient",_civMoraleClient,true];
  missionNameSpace setVariable ["opforMoraleClient",_opforMoraleClient,true];
};

/*
vics_econ_moraleSync = {
  _civMoraleClient = profileNameSpace getVariable [(missionPrefix + "civMorale"),50];
  _opforMoraleClient = profileNameSpace getVariable (missionPrefix + "opforMorale");
  missionNameSpace setVariable ["civMoraleClient",_civMoraleClient,true];
  missionNameSpace setVariable ["opforMoraleClient",_opforMoraleClient,true];
};
*/
vics_econ_opforMoraleAdjust = {
  params [["_add",0],["_remove",0]];
  _opforMorale = profileNameSpace getVariable (missionPrefix + "opforMorale");
  _opforMorale = _opforMorale + _add;
  _opforMorale = _opforMorale - _remove;
  if (_opforMorale < 0) then {
    _opforMorale = 0;
  };
  if (_opforMorale > 100) then {
    _opforMorale = 100;
  };
  _opforMorale;
  profileNameSpace setVariable [(missionPrefix + "opforMorale"),_opforMorale];
  true;
};

vics_econ_civMoraleAdjust = {
  params [["_add",0],["_remove",0]];
  _civMorale = profileNameSpace getVariable [(missionPrefix + "civMorale"),0];
  _civMorale = _civMorale + _add;
  _civMorale = _civMorale - _remove;
  if (_civMorale < -100) then {
    _civMorale = -100;
  };
  if (_civMorale > 100) then {
    _civMorale = 100;
  };
  _civMorale;
  profileNameSpace setVariable [(missionPrefix + "civMorale"),_civMorale];
  call vics_econ_moraleSync;
  true;
};


vics_econ_weaponsProductionLoop = {
  _opforWeaponsProduction = profileNameSpace getVariable (missionPrefix + "opforWeaponsProduction");
  _cratesProduced = 0;
  {
    _cratesProduced = _cratesProduced + 1;
  }forEach _opforWeaponsProduction;
  _cratesProduced;
  [_cratesProduced,0] call vics_econ_weaponsAdjust;
};

vics_econ_moneyProductionLoop = {
  _drugProductionTasks = profileNameSpace getVariable [(missionPrefix + "drugProductionTasks"),[]];
  _opforMoneyProduction = _drugProductionTasks;
  _moneyProduced = 0;
  {
    _moneyProduced = _moneyProduced + 1000;
  }forEach _opforMoneyProduction;
  _moneyProduced;
  [_moneyProduced,0] call vics_econ_moneyAdjust;
};

vics_econ_weaponsAdjust = {
  params [["_add",0],["_remove",0]];
  _opforWeaponsCount = profileNameSpace getVariable (missionPrefix + "opforWeaponsCount");
  _opforWeaponsCount = _opforWeaponsCount + _add;
  _opforWeaponsCount = _opforWeaponsCount - _remove;
  if (_opforWeaponsCount < 0) then {
    _opforWeaponsCount = 0;
  };
  _opforWeaponsCount;
  profileNameSpace setVariable [(missionPrefix + "opforWeaponsCount"),_opforWeaponsCount];
  true;
};

vics_econ_moneyAdjust = {
  params [["_add",0],["_remove",0]];
  _opforMoneyCount = profileNameSpace getVariable (missionPrefix + "opforMoneyCount");
  _opforMoneyCount = _opforMoneyCount + _add;
  _opforMoneyCount = _opforMoneyCount - _remove;
  if (_opforMoneyCount < 0) then {
    _opforMoneyCount = 0;
  };
  _opforMoneyCount;
  profileNameSpace setVariable [(missionPrefix + "opforMoneyCount"),_opforMoneyCount];
  true;
};

vics_econ_resources = {
  _opforFunds = profileNameSpace getVariable (missionPrefix + "opforFunds");
  _opforResources = profileNameSpace getVariable (missionPrefix + "opforResources");
  _totalFundsSpent = profileNameSpace getVariable [(missionPrefix + "opforTotalFundsSpent"),0];
  _totalCost = 0;
  //Resources array list = "general supplies", Arms, ammo, food, fuel, vehicle repair parts, explosives, building materials, luxary goods, entertainment goods, Industry goods
  if (isNil "_opforResources") then {
    _opforResources = [[1000,1],[1000,1],[1000,1],[1000,1],[1000,1],[1000,1],[1000,1],[1000,1],[1000,1],[1000,1],[1000,1]];
  };
  _opforResources;
  if (isNil("_opforFunds")) then {
    _opforFunds = 100000 * opforFundingLevel;
  };
  _opforFunds;
  /*income = (base income * (funding level * support modifier) + ((income locations * flat rate) * profit multiplier))
  Base income is a flat rate they will recieve every main loop
  Funding level is based on support from government/sponsor etc
  support modifier is based on morale/any determining factor for performance in campaign
  income locations is count of any income spots generated on map that are active
  flat rate is a flat number provided by each income location
  profit multiplier is used to give more income per location
  */
  _income = (10000 * opforFundingLevel);
  _opforFunds = _opforFunds + _income;
  {
    //Supply Type iteration
    _supplyType = _x;
    //Amount of supplies remaining
    _supplyCount = _supplyType select 0;
    //Price multiplier of supply
    _supplyPrice = _supplyType select 1;
    if (_supplyCount < 300) then {
      _suppliesMissing = 300 - _supplyCount;
      _costToRefill = ((100 * _supplyPrice) * _suppliesMissing);
      if (_opforFunds > _costToRefill) then {
        _totalCost = _totalCost + _costToRefill;
        //Set specific resource back to full
        _supplyType set [0,300];
        //Set resource back into resource array
        _opforResources set [_forEachIndex,_supplyType];
        //Remove cost from remaining OPFOR funds
        _opforFunds = _opforFunds - _costToRefill;
      };
    };
  }forEach _opforResources;
  _opforFunds;
  _opforResources;
  _totalCost;
  _totalFundsSpent = _totalFundsSpent + _totalCost;
  profileNameSpace setVariable [(missionPrefix + "opforFunds"),_opforFunds];
  profileNameSpace setVariable [(missionPrefix + "opforResources"),_opforResources];
  profileNameSpace setVariable [(missionPrefix + "totalFundsSpent"),_totalFundsSpent];
};


vics_econ_createSupply = {
  params ["_supplyType","_amount","_objective","_objectiveIndex"];
  _objectivesSaved = profileNameSpace getVariable (missionPrefix + "objectivesSaved");
  _smallCrates = ["Box_Syndicate_Wps_F"];
  _medCrates = ["Box_Syndicate_Ammo_F"];
  _crateStr = "";
  switch (_supplyType) do {
    case "arms": {_crateStr = selectRandom _smallCrates};
    case "ammo": {_crateStr = selectRandom _smallCrates};
    default {_crateStr = nil};
  };
  diag_log _crateStr;
  if (true) then {
    _objPos = _objective select 0;
    _objExtrasArray = _objective select 7;
    _objectiveStructures = [];
    _nearBuildings = nearestObjects [_objPos, ["House","Camp"], objectiveSizeMultiplier];
    {
      _buildingPositions = _x buildingPos -1;
      if ((count _buildingPositions) > 3) then {
        _objectiveStructures pushBackUnique _x;
      };
    }forEach _nearBuildings;
    _objectiveProduction = _objExtrasArray select 7;
    diag_log str _objectiveProduction;
    if ((count _objectiveProduction) < 4) then {
      _selectedStructure = selectRandom _objectiveStructures;
      diag_log str _objectiveStructures;
      _buildingPositions = ((_selectedStructure buildingPos -1) select {lineIntersects [AGLToASL _x, (AGLToASL _x) vectorAdd [0,0,10]]});
      _selectedPos = selectRandom _buildingPositions;
      diag_log str _buildingPositions;
      if !(isNil "_selectedPos") then {
        hint format ["%1 %2",_buildingPositions,_selectedPos];
        _crate = createVehicle [_crateStr,_selectedPos,[],0,"CAN_COLLIDE"];
        clearItemCargoGlobal _crate;
        clearMagazineCargoGlobal _crate;
        clearWeaponCargoGlobal _crate;
        clearBackpackCargoGlobal _crate;
        _crate enableSimulationGlobal false;
        _crate addEventHandler ["Hit", {
	         params ["_unit", "_source", "_damage", "_instigator"];
           _unit enableSimulationGlobal true;
        }];
        [_crate,"rhs_weap_akms",10,2] call vics_econ_fillSupplies;
        _crateToSave = [_crate,_crateStr,_selectedPos,"",_supplyType];
        // Crate object, Crate class, building Position, Building object, supply type
        _objectiveProduction pushBack _crateToSave;
        _objExtrasArray set [7,_objectiveProduction];
        diag_log ("Production Array: " + str _objectiveProduction);
        _objective set [7,_objExtrasArray];
        _objectivesSaved set [_objectiveIndex,_objective];
        profileNameSpace setVariable [(missionPrefix + "objectivesSaved"),_objectivesSaved];
      } else {
        diag_log "Econ_createSupply _selectedPos is nil";
      };
    } else {
      diag_log "Econ_createSupply Crates at maximum";
    };
  } else {
    diag_log "Econ_createSupply _crateStr is nil";
  };
};

vics_econ_supplyLoad = {
  _objectivesSaved = profileNameSpace getVariable (missionPrefix + "objectivesSaved");
  {
    _objective = _x;
    _objExtrasArray = _objective select 7;
    _objProduction = _objExtrasArray select 7;
    _objProductionUpdated = [];
    {
      // Crate object, Crate class, building Position, Building object, supply type
      _crateClass = _x select 1;
      _cratePos = _x select 2;
      _crateBuilding = "";
      _crateType = _x select 4;
      _crate = createVehicle [_crateClass,_cratePos,[],0,"CAN_COLLIDE"];
      clearItemCargoGlobal _crate;
      clearMagazineCargoGlobal _crate;
      clearWeaponCargoGlobal _crate;
      clearBackpackCargoGlobal _crate;
      _crate enableSimulationGlobal false;
      _crate addEventHandler ["Hit", {
         params ["_unit", "_source", "_damage", "_instigator"];
         _unit enableSimulationGlobal true;
      }];
      [_crate,"rhs_weap_akms",10,2] call vics_econ_fillSupplies;
      _crateToSave = [_crate,_crateClass,_cratePos,_crateBuilding,_crateType];
      _objProductionUpdated pushBack _crateToSave;
    }forEach _objProduction;
    _objExtrasArray set [7,_objProductionUpdated];
    _objective set [7,_objExtrasArray];
    _objectivesSaved set [_forEachIndex,_objective];
  }forEach _objectivesSaved;
  profileNameSpace setVariable [(missionPrefix + "objectivesSaved"),_objectivesSaved];
};

vics_econ_productionLoop = {
  _objectivesSaved = profileNameSpace getVariable (missionPrefix + "objectivesSaved");
  {
    _objectiveLastCatpured = _x select 2 select 0;
    _objHostilityValue = _x select 7 select 2;
    if (_objectiveLastCatpured isEqualTo "opfor") then {
      if (_objHostilityValue > 60) then {
        _chanceToCreate = random 100;
        if (_chanceToCreate < 50) then {
          ["arms",1,_x,_forEachIndex] spawn vics_econ_createSupply;
          uiSleep smoothSpawn;
        };
      };
    };
  }forEach _objectivesSaved;
};

vics_econ_supplyTransport = {
  params [["_grp",nil]];
  _grp;
  diag_log str _grp;
  _objectivesSaved = profileNameSpace getVariable (missionPrefix + "objectivesSaved");
  _foundSupplies = false;
  _selectedObj = nil;
  While {_foundSupplies isEqualTo false} do {
    _randomObj = selectRandom _objectivesSaved;
    _objProduction = _randomObj select 7 select 7;
    if ((count _objProduction) > 0) then {
      _selectedObj = _randomObj;
      _foundSupplies = true;
    };
  };
  _selectedObj;
  if (true) then {
    _dropOffPoints = ["opforSellPoint_0"];
    _objProduction = _selectedObj select 7 select 7;
    diag_log str _objProduction;
    _randomSupply = selectRandom _objProduction;
    _supplyPos = _randomSupply select 2;
    _randomDropPoint = selectRandom _dropOffPoints;
    _randomNum = random 100;
    _vehicleToSpawn = nil;
    _vehicleCreated = nil;
    if (isNil "_grp") then {
      _vehicleToSpawn = selectRandom civVehicles;
      _vehicleCreated = createVehicle [_vehicleToSpawn,(getMarkerPos _randomDropPoint)];
    };
    if (_randomNum > 50) then {
      if (isNil "_grp") then {
        _grp = createGroup [civilian,true];
        _seatCount = [_vehicleToSpawn, true] call bis_fnc_crewCount;
        diag_log str _seatCount;
        _midNum = (_seatCount/2);
        _randomAmountToAdd = round (random [2,(_seatCount/2),_seatCount]);
        for "_i" from 1 to _randomAmountToAdd do {
          _unitToCreate = selectrandom civilians;
        _createdUnit = _grp createUnit [_unitToCreate,[0,0],[],0,"NONE"];
        _createdUnit addEventHandler ["Killed", {
           params ["_unit", "_killer", "_instigator", "_useEffects"];
           [_unit,_killer] call vics_civ_civKilled;
        }];
        };
        _units = units _grp;
        {
          _x moveInAny _vehicleCreated;
        } forEach _units;
      };
      _leader = leader _grp;
      _leader moveInDriver _vehicleCreated;
      [_grp,_supplyPos,10,"MOVE","SAFE","YELLOW","LIMITED","COLUMN","[this] call vics_econ_supplyPickup;",[3,6,9],70] call CBA_fnc_addWaypoint;
    } else {
      if (isNil "_grp") then {
        _grp = createGroup [east,true];
        _seatCount = [_vehicleToSpawn, true] call bis_fnc_crewCount;
        _randomAmountToAdd = round (random [2,(_seatCount/2),_seatCount]);
        for "_i" from 1 to _randomAmountToAdd do {
          _unitToCreate = selectrandom genUnitPool;
        _createdUnit = _grp createUnit [_unitToCreate,[0,0],[],0,"NONE"];
        };
        _units = units _grp;
        {
          _x moveInAny _vehicleCreated;
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
      };
      _leader = leader _grp;
      _leader moveInDriver _vehicleCreated;
      _leader setVariable ["deliveryObjective",[_selectedObj,_vehicleCreated]];
      diag_log str _supplyPos;
      [_grp,_supplyPos,10,"MOVE","SAFE","YELLOW","LIMITED","COLUMN","[this] call vics_econ_supplyPickup;",[3,6,9],30] call CBA_fnc_addWaypoint;

    };

  } else {
    diag_log "econ_supplyTransport _selectedObj is nil";
  };
};

vics_econ_supplyPickup = {
  params ["_grp"];
  _objectivesSaved = profileNameSpace getVariable (missionPrefix + "objectivesSaved");
  _dropOffPoints = ["opforSellPoint_0"];
  _randomDropPoint = selectRandom _dropOffPoints;
  _leader = leader _grp;
  _supplyObjective = _leader getVariable "deliveryObjective";
  _objective = _supplyObjective select 0;
  _objectiveIndex = _objectivesSaved find _objective;
  _vehicle = _supplyObjective select 1;
  _objExtrasArray = _objective select 7;
  _objProduction = _objExtrasArray select 7;
  _supplySelected = selectRandom _objProduction;
  _supplyIndex = _objProduction find _supplySelected;
  _supplyObject = _supplySelected select 0;
  _driver = driver _vehicle;
  _vehicle setVariable ["cratesLoaded",[_supplySelected]];
  [_supplyObject,_vehicle,true] call ace_cargo_fnc_loadItem;
  diag_log format ["%1 %2 %3",_objective,_vehicle,_grp];
  _objProduction deleteAt _supplyIndex;
  _objExtrasArray set [7,_objProduction];
  _objective set [7,_objExtrasArray];
  _objectivesSaved set [_objectiveIndex,_objective];
  profileNameSpace setVariable [(missionPrefix + "objectivesSaved"),_objectivesSaved];
  [_grp,(getMarkerPos _randomDropPoint),10,"MOVE","SAFE","YELLOW","LIMITED","COLUMN","[this] call vics_econ_supplyDropOff;",[3,6,9],30] call CBA_fnc_addWaypoint;
};

vics_econ_supplyDropOff = {
  params ["_grp"];
  _dropOffPoints = ["opforSellPoint_0"];
  _leader = leader _grp;
  _supplyObjective = _leader getVariable "deliveryObjective";
  _objective = _supplyObjective select 0;
  _vehicle = _supplyObjective select 1;
  _objProduction = _objective select 7 select 7;
  _suppliesTransported = _vehicle getVariable ["cratesLoaded",[]];
  {
    _supplyObject = _x select 0;
    _supplyType = _x select 4;
    _objectUnloaded = [_supplyObject,_vehicle] call ace_cargo_fnc_unLoadItem;
    deleteVehicle _supplyObject;
    [_supplyType] call vics_econ_supplySell;
  }forEach _suppliesTransported;
  [_grp] call vics_econ_supplyTransport;
};


vics_econ_supplySell = {
  params ["_supplyType"];
  _profit = 100;
};

vics_econ_fillSupplies = {
  params ["_crate","_item",["_amount",1],["_type",0]];
  switch (_type) do {
    case 0: {_crate addItemCargoGlobal [_item,_amount]; systemChat "Item Added"};
    case 1: {_crate addMagazineCargoGlobal [_item,_amount]; systemChat "Mag Added"};
    case 2: {_crate addWeaponCargoGlobal [_item,_amount]};
    case 3: {_crate addBackpackCargoGlobal [_item,_amount]};
  };
};

vics_econ_supplyVerify = {
  _objectivesSaved = profileNameSpace getVariable (missionPrefix + "objectivesSaved");
  {
    _objective = _x;
    _objPos = _objective select 0;
    _objExtrasArray = _objective select 7;
    _objProduction = _objExtrasArray select 7;
    _objProductionUpdated = [];
    {
      // Crate object, Crate class, building Position, Building object, supply type
      _crateArray = _x;
      _crateObject = _crateArray select 0;
      if ((alive _crateObject) && ((_crateObject distance2D _objPos) < objectiveSizeMultiplier)) then {
        _objProductionUpdated pushBack _crateArray;
      };
    }forEach _objProduction;
    _objExtrasArray set [7,_objProductionUpdated];
    _objective set [7,_objExtrasArray];
    _objectivesSaved set [_forEachIndex,_objective];
  }forEach _objectivesSaved;
  profileNameSpace setVariable [(missionPrefix + "objectivesSaved"),_objectivesSaved];
};

/*
vics_econ_loop = {
  [] spawn {
    _objectivesSaved = profileNameSpace getVariable (missionPrefix + "objectivesSaved");
    _opforMorale = profileNameSpace getVariable (missionPrefix + "opforMorale");
    if (isNil "_opforMorale") then {
      _opforMorale = 50;
      profileNameSpace setVariable [(missionPrefix + "opforMorale"),_opforMorale];
    };
    _opforMorale;
    _moraleModifier = ((count _objectivesSaved) / 300);
    opforControlledObjs = [];
    bluforControlledObjs = [];
    {
      _objective = _x;
      _objectiveWeight = _x select 1;
      _weightModifier = (_objectiveWeight / 2);
      _objectiveCaptured = _x select 2 select 0;
      if (_objectiveCaptured == "opfor") then {
        _opforMorale = _opforMorale + (_moraleModifier * _weightModifier);
        opforControlledObjs pushBackUnique _objective;
      };
      if (_objectiveCaptured == "blufor") then {
        _opforMorale = _opforMorale - (_moraleModifier * _weightModifier);
        bluforControlledObjs pushBackUnique _objective;
      };
      if (_opforMorale < 0) then {
        _opforMorale = 0;
      };
      if (_opforMorale > 100) then {
        _opforMorale = 100;
      };
      _opforMorale;

    }forEach _objectivesSaved;
    _opforForcePool = profileNameSpace getVariable (missionPrefix + "opforForcePool");
    if (isNil "_opforForcePool") then {
      _opforForcePool = ((count _objectivesSaved) / 5);
      profileNameSpace setVariable [(missionPrefix + "opforForcePool"),_opforForcePool];
    };
    _opforForcePool;
    if (_opforMorale > 50) then {
      _opforForcePool = _opforForcePool + (2 * forcePoolMultipler);
    } else {
      _opforForcePool = _opforForcePool + (1 * forcePoolMultipler);
    };
    _opforForcePool;
    _opforForcePool = _opforForcePool + _add;
    _opforForcePool = _opforForcePool - _remove;
    _opforForcePool = floor _opforForcePool;
    profileNameSpace setVariable [(missionPrefix + "opforMorale"),_opforMorale];
    profileNameSpace setVariable [(missionPrefix + "opforForcePool"),_opforForcePool];
  };
};

*/
