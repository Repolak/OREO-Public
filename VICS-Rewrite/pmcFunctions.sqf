vics_pmc_checkBal = {
  if (isNil "pmcUnitBalance") then {
    systemChat "Tell Repo that the balance thing probably doesn't work. Seriously learn to code";
  } else {
    systemChat format ["Current unit balance $%1",pmcUnitBalance];
  };
};

vics_pmc_balSave = {
  profileNameSpace setVariable [(missionPrefix + "pmcUnitBalance"), pmcUnitBalance];
};

vics_pmc_balLoad = {
  pmcUnitBalance = profileNameSpace getVariable (missionPrefix + "pmcUnitBalance");
  if (isNil "pmcUnitBalance") then {
    pmcUnitBalance = 0;
  };
  publicVariable "pmcUnitBalance";
};

vics_pmc_balChange = {
  params ["_value"];
  if (_value > 0) then {
    pmcUnitBalance = pmcUnitBalance + _value;
  };
  if (_value < 0) then {
    pmcUnitBalance = pmcUnitBalance - _value;
  };
  publicVariable "pmcUnitBalance";
};


vics_pmc_addBalCheckToPlayer = {
  _balanceCheck = ["pmcBalance","Check Balance","",{call vics_pmc_checkBal},{true}] call ace_interact_menu_fnc_createAction;
  [player,1,["ACE_SelfActions"],_balanceCheck] call ace_interact_menu_fnc_addActionToObject;
};


vics_pmc_missionRequest = {

};

vics_pmc_missionGen = {

};

vics_pmc_interrogateInit = {
 params ["_objects"];
 _unitsToAdd = [];
 {
   _object = _x;
   if ((captive _object) isEqualTo true) then {
     _unitsToAdd pushBackUnique _object;
     [_object, "SIT", "NONE"] call BIS_fnc_ambientAnim;
   };
 }forEach _objects;
 missionNamespace setVariable ["interrogateUnits",_unitsToAdd];
};

vics_pmc_interrogateEnd = {
  _units = missionNameSpace getVariable "interrogateUnits";
  {
    _unit = _x;
    _unit call BIS_fnc_ambientAnim__terminate;
  }forEach _units;
};


vics_pmc_interrogate = {

};
