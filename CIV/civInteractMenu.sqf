target = _this select 0;
interactor = _this select 1;
//Get ACE awake state of civilian
_awake = target getVariable ["ACE_isUnconscious",false];
//If alive and awake, allow interaction
if ((alive target) && !(_awake)) then {
  //Open Dialog for interaction
  createDialog "civInteractMain";
  //Sync Morale values to all clients on interaction
  //[] remoteExec ["vics_econ_moraleSync",2];
  [target] remoteExec ["vics_econ_moraleSync",2];
} else {
  //Not alive or awake, shouldnt be able to interact
  systemChat "...It's a dead body...";
};
