vics_loop_sixty = {
  while {true} do {
    _startTime = diag_tickTime;
    ["Secondary Loop Started","VICS_ECON",true] call vics_sys_debug;
    _objOwnerDecay = [] call vics_econ_objOwner;
    _cqb = [] call vics_opfor_cqb;
    _fillerGroups = [] call vics_opfor_fillerGroups;
    _civilian = [] call vics_civ_generate;
    [] call vics_sys_debugEconValues;
    [] call vics_opfor_civConvert;
    [] call vics_tsk_drugProdPopulate;
    [] call vics_opfor_artyRequest;
    [] call vics_civ_trafficGenerate;
    [] call vics_civ_parkedCarGenerate;
    [] call vics_civ_animals;
    [] call vics_opfor_spotter;
    [] call vics_civ_ambientSounds;
    ["Secondary Loop Finished","VICS_ECON",true] call vics_sys_debug;
    _endTime = diag_tickTime;
    //systemChat ("It took " + (str (_endTime - _startTime)) + " Seconds to complete.");
    //uiSleep (60 - (_endTime - _startTime));
    uiSleep 60;
  };
};

vics_loop_thirty = {
  while {true} do {
    [] call vics_civ_callToPrayer;
    uiSleep 30;
  };
};
