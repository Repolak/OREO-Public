execVM "VICS-Rewrite\declares.sqf";
execVM "VICS-Rewrite\initalization.sqf";
addMissionEventHandler ["BuildingChanged", {
	params ["_previousObject", "_newObject", "_isRuin"];
  [_previousObject,_newObject,_isRuin] call vics_sys_buildingChanged;
}];
