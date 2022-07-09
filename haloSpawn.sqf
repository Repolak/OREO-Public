[] spawn {
  _planeSpawned = profileNameSpace getVariable "planeSpawned";
  if (_planeSpawned isEqualTo 0) then {
  openMap [true, false];
  _randomHeight = random [19800,20000,20200];
  onMapSingleClick "hint format ['POS: %1',_pos]; openMap false;plane = ['C130',_pos,[0,0,20000],0,false,false,true] remoteExec ['LARs_fnc_spawnComp',2]; onMapSingleClick ''";
  profileNameSpace setVariable ["planeSpawned",1];
  uiSleep 300;
  [ plane ] call LARs_fnc_deleteComp;
  profileNameSpace setVariable ["planeSpawned",0];
  } else {
  hint "Plane already busy!";
  };
};
