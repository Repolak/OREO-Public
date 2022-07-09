// Intel initilized
vem_intel_init = {
  // On init, add all addActions
  //_intelAddActions = [] call vem_intel_addActions;
  //waitUntil{_intelAddActions isEqualTo true};
  // also analyze all existing intel
  _intelAnalyze = [] call vem_intel_analyzeAllIntel;
  waitUntil{_intelAnalyze isEqualTo true};
  true;
};

// Relevant addActions
vem_intel_addActions = {
  // Create turn in and check points for all intel interaction points
  [] spawn {
    {
      _interactionPoint = _x;
      [_interactionPoint, ["Turn in intel", {_selectedPlayer = _this select 1; [_selectedPlayer] remoteExec ["vem_intel_selectedPlayerSubmitIntel", 2];}]] remoteExec ["addAction", clientOwner];
      [_interactionPoint, ["Check intel status", {_selectedPlayer = _this select 1; [_selectedPlayer] remoteExec ["vem_intel_checkStatus", 2];}]] remoteExec ["addAction", clientOwner];
      [_interactionPoint, ["Receive intel updates", {_selectedPlayer = _this select 1; [_selectedPlayer] remoteExec ["vem_intel_receiveIntel", 2];}]] remoteExec ["addAction", clientOwner];
      [_interactionPoint, ["Purge all intel", {_selectedPlayer = _this select 1; [_selectedPlayer] remoteExec ["vem_intel_purgeIntel", 2];}]] remoteExec ["addAction", clientOwner];
      uiSleep 0.01;
    } foreach intelInteractPoint;
  };
  true;
};

// Method to take all active pieces of intel and assign them
// to the user
//Intel array = ["Tier",active]
vem_intel_receiveIntel = {
  Params ["_selectedPlayer"];
  // Store player's uid
  _selectedPlayerUid = getPlayerUID _selectedPlayer;

  // Define currentIntel - scope
  _currentIntel = [];

  // Determine if infantry or srt
  if (_selectedPlayerUid in srtPlayerUIDs) then {
    _currentIntel = profileNameSpace getVariable (missionPrefix + "srtcurrentIntel");
    ["Checking status of SRT intel..."] remoteExec ["systemChat", _selectedPlayer];
  } else {
    _currentIntel = profileNameSpace getVariable (missionPrefix + "infantrycurrentIntel");
    ["Checking status of intel..."] remoteExec ["systemChat", _selectedPlayer];
  };

  // Since we will be removing from active missions, define a new array
  // to hold changes
  _newcurrentIntel = [];
  // Iterate through each active mission  for this user's type
  {
    _thisIntel = _x;
    // If this mission is ready to be assigned

    if(_thisIntel select 1 isEqualTo 1) then {
      /*
      Redundant old test code, not to be removed yet
      // This is where we would assign the user a mission.
      // Insert new code here when ready
      _missionsOnMap = profileNameSpace getVariable (missionPrefix + "missionsOnMap");
          _missionSelected = selectRandom _missionsOnMap;
          _missionPos = _missionSelected select 0;
          _currentMarker = createMarker [((str _missionPos) + "objective"), _missionPos];
          _currentMarker setMarkerType "hd_dot";
          _currentMarker setMarkerSize [50,50];
          _currentMarker setMarkerBrush "Grid";
          _currentMarker setMarkerShape "ELLIPSE";
          _currentMarker setMarkerColor "ColorBlack";
          */
          if (_thisIntel select 0 isEqualTo "T1") then {
            //display intel for T1 mission
          };
          if (_thisIntel select 0 isEqualTo "T2") then {
            //display intel for T2 mission
          };
          if (_thisIntel select 0 isEqualTo "T3") then {
            //display intel for T3 mission
          };
          if (_thisIntel select 0 isEqualTo "T4") then {
            //display intel for T4 mission/HVT location
          };


      [format["%1 mission assigned", _thisIntel select 0]] remoteExec ["systemChat", _selectedPlayer];
    } else {
      // If the mission was not assigned, keep it in the array
      _newcurrentIntel pushBack _thisIntel;
    };

    uiSleep 0.01;
  } foreach _currentIntel;

  // Save to changes relevant array
  if (_selectedPlayerUid in srtPlayerUIDs) then {
    profileNameSpace setVariable [(missionPrefix + "srtcurrentIntel"), _newcurrentIntel ];
  } else {
    profileNameSpace setVariable [(missionPrefix + "infantrycurrentIntel"), _newcurrentIntel ];
  };

};

// Method to take all intel user has submitted and set it to active
// Currently being done on server load to simulate intel processing time
vem_intel_analyzeAllIntel = {
  [] spawn {
    // First srt of course
    _srtcurrentIntel = profileNameSpace getVariable (missionPrefix + "srtcurrentIntel");
    // If the srtcurrentIntel var is nill, lets define it as an empty array
    if (isNil "_srtcurrentIntel") then {
      _srtcurrentIntel = [];
    };
    // Define new mission array as we will make changes
    _newsrtcurrentIntel = [];
    // Iterate through each mission in currentIntel
    {
      _thisIntel = _x;
      // If the mission is currently inactive
      if(_thisIntel select 1 isEqualTo 0) then {
        // Set the mission to active
        _thisIntel set [1, 1];
      };
      // Add modified mission to the array
      _newsrtcurrentIntel pushBack _thisIntel;
      uiSleep 0.01;
    } foreach _srtcurrentIntel;

    // Now infantry/plebs
    _infantrycurrentIntel = profileNameSpace getVariable (missionPrefix + "infantrycurrentIntel");
    // If the infantrycurrentIntel var is nill, lets define it as an empty array
    if (isNil "_infantrycurrentIntel") then {
      _infantrycurrentIntel = [];
    };
    // Define new mission array as we will make changes
    _newinfantrycurrentIntel = [];
    // Iterate through each mission in currentIntel
    {
      _thisIntel = _x;
      // If the mission is currently inactive
      if(_thisIntel select 1 isEqualTo 0) then {
        // Set the mission to active
        _thisIntel set [1, 1];
      };
      // Add modified mission to the array
      _newinfantrycurrentIntel pushBack _thisIntel;
      uiSleep 0.01;
    } foreach _infantrycurrentIntel;

    // Store changes to currentIntel
    profileNameSpace setVariable [(missionPrefix + "srtcurrentIntel"), _newsrtcurrentIntel ];
    profileNameSpace setVariable [(missionPrefix + "infantrycurrentIntel"), _newinfantrycurrentIntel ];

    // At this point, all intel obtained in previous sessions will be made active for this session
  };
     true;
};

// Function to purge all collected intel
// danger here lol - may want to confirm
// with user or not include in release
vem_intel_purgeIntel = {
    Params ["_selectedPlayer"];
    ["User purged all intel", "VEM_Intel", true] call vics_sys_debug;
    _currentIntel = [];
    // Store player's uid
    _selectedPlayerUid = getPlayerUID _selectedPlayer;
    // Determine if we should clear srt or infantry intel
    if (_selectedPlayerUid in srtPlayerUIDs) then {
      profileNameSpace setVariable [(missionPrefix + "srtcurrentIntel"), _currentIntel ];
      ["Purged srt intel..."] remoteExec ["systemChat", _selectedPlayer];
    } else {
      profileNameSpace setVariable [(missionPrefix + "infantrycurrentIntel"), _currentIntel ];
      ["Purged intel..."] remoteExec ["systemChat", _selectedPlayer];
    };
};


// Function to be ran when player uses addAction to
// check status of turned in intel
vem_intel_checkStatus = {
  Params [["_selectedPlayer", player]];
  ["User checked intel status", "VEM_Intel", true] call vics_sys_debug;

   // Store player's uid
   _selectedPlayerUid = getPlayerUID _selectedPlayer;

   // Define currentIntel - scope
   _currentIntel = [];

   // Determine if infantry or srt
   if (_selectedPlayerUid in srtPlayerUIDs) then {
     _currentIntel = profileNameSpace getVariable (missionPrefix + "srtcurrentIntel");
     ["Checking status of srt intel..."] remoteExec ["systemChat", _selectedPlayer];
   } else {
     _currentIntel = profileNameSpace getVariable (missionPrefix + "infantrycurrentIntel");
     ["Checking status of intel..."] remoteExec ["systemChat", _selectedPlayer];
   };


   // If the currentIntel var is nill, lets define it as an empty array
   if (isNil "_currentIntel") then {
     _currentIntel = [];
   };

   // Iterate through each mission in currentIntel
   {
     // Store this mission locally
     _thisIntel = _x;
     // If this mission is ready, give user a mission
     if (_thisIntel select 1 isEqualTo 1) then {
       // Mission is ready
       if(_thisIntel select 0 isEqualTo "T1") then {
         ["T1 mission ready to be assigned"] remoteExec ["systemChat", _selectedPlayer];
       };
       if(_thisIntel select 0 isEqualTo "T2") then {
         ["T2 mission ready to be assigned"] remoteExec ["systemChat", _selectedPlayer];
       };
       if(_thisIntel select 0 isEqualTo "T3") then {
         ["T3 mission ready to be assigned"] remoteExec ["systemChat", _selectedPlayer];
       };
     } else {
       // Mission is not ready
       if(_thisIntel select 0 isEqualTo "T1") then {
         ["T1 intel not yet processed"] remoteExec ["systemChat", _selectedPlayer];
       };
       if(_thisIntel select 0 isEqualTo "T2") then {
         ["T2 intel not yet processed"] remoteExec ["systemChat", _selectedPlayer];
       };
       if(_thisIntel select 0 isEqualTo "T3") then {
         ["T3 intel not yet processed"] remoteExec ["systemChat", _selectedPlayer];
       };
     };
   } foreach _currentIntel;

   // Debugging - take this out before release
   //_srtcurrentIntel = profileNameSpace getVariable (missionPrefix + "srtcurrentIntel");
   //_infantrycurrentIntel = profileNameSpace getVariable (missionPrefix + "infantrycurrentIntel");
   //systemChat format ["%1", _srtcurrentIntel];
   //systemChat format ["%1", _infantrycurrentIntel];
   // End debug
   systemChat "Done!";
};


// Function to be ran when player uses addAction to
// turn in intel
vem_intel_selectedPlayerSubmitIntel = {
  Params ["_selectedPlayer"];
  _selectedPlayerInventory = magazines _selectedPlayer;
 [_selectedPlayer,_selectedPlayerInventory] remoteExec ["vem_intel_turnin",2];
 ["All intel turned in"] remoteExec ["systemChat", _selectedPlayer];
};


// Handles when user turns in piece of intel
// Naming convention:
// VEM_PHONE_T1, VEM_LAPTOP_T1, VEM_FILE_T1, ETC
// Essentially, item and tier make up "chance"
vem_intel_turnin = {
    Params ["_selectedPlayer","_selectedPlayerInventory"];
    // Iterate through all items in player’s inventory
    _intelItems = [];
   {
      _item = _x;
      // Is this item part of VEM
      if ("VEM" in _item) then {
          _intelItems pushback _item;
          _selectedPlayer removeItem _item;
      };
      uiSleep 0.01;

   } foreach _selectedPlayerInventory;
   // _intelItems now contains list of all VEM items
   _intelItems;
   // Now process each intel item
   {
        _item = _x;
        // We need a different result based on each intel item
        if ("FILE" in _item) then {
	         // This is a file
            if ("T1" in _item) then {
              // Tier 1 File
              ["FILE", "T1", 10, _selectedPlayer] call vem_intel_process;
            };
            if ("T2" in _item) then {
              // Tier 2 File
              ["FILE", "T2", 15, _selectedPlayer] call vem_intel_process;
            };
            if("T3" in _item) then {
              // Tier 3 File
              ["FILE", "T3", 20, _selectedPlayer] call vem_intel_process;
            };
          };
          if ("PHONE" in _item) then {
            // This is a phone
            if ("T1" in _item) then {
                // Tier 1 phone
	               ["PHONE", "T1", 20, _selectedPlayer] call vem_intel_process;
            };
            if ("T2" in _item) then {
              // Tier 2 phone
               ["PHONE", "T2", 30, _selectedPlayer] call vem_intel_process;
            };
            if ("T3" in _item) then {
              // Tier 3 phone
                ["PHONE", "T3", 40, _selectedPlayer] call vem_intel_process;
            };
        };
        if ("LAPTOP" in _item) then {
          // This is a laptop
            if ("T1" in _item) then {
              // Tier 1 laptop
              ["LAPTOP", "T1", 40, _selectedPlayer] call vem_intel_process;
            };
            if ("T2" in _item) then {
              // Tier 2 laptop
              ["LAPTOP", "T2", 50, _selectedPlayer] call vem_intel_process;
            };
            if ("T3" in _item) then {
              // Tier 3 laptop
              ["LAPTOP", "T3", 60, _selectedPlayer] call vem_intel_process;
            };
        };
        uiSleep 0.01;
    } foreach _intelItems;
};


// Method to process intel once it is turned in
// Takes params relevant to a single intel item
// called for each intel item turned in
// param value is the probability a mission will be generated at all
vem_intel_process = {
     Params ["_item", "_tier", "_value", ["_selectedPlayer", player]];
     _randomNum = random 100; // Betw 0-100

     // Define currentIntel - scope
     _currentIntel = [];

     // Store player's uid
     _selectedPlayerUid = getPlayerUID _selectedPlayer;

     // Determine if infantry or srt
     if (_selectedPlayerUid in srtPlayerUIDs) then {
       _currentIntel = profileNameSpace getVariable (missionPrefix + "srtcurrentIntel");
     } else {
       _currentIntel = profileNameSpace getVariable (missionPrefix + "infantrycurrentIntel");
     };

     //If the currentIntel var is nill, lets define it as an empty array
     if (isNil "_currentIntel") then {
       _currentIntel = [];
     };
     // Determine if we received anything from intel
     // using random number generation & percentages
     if (_value > _randomNum) then {
        // Intel will return a mission in due time
        // Now determine what type of intel should be generated
        _randomNum = random 100; // New random Betw 0-100
        if (_tier isEqualTo "T1") then {
          // A tier one piece of intel was turned in and something was recovered
          // Tier 1 - %70 t1, %20 t2, %10 t3
          if(_randomNum <= 70) then {
            // Intel gave a tier 1 mission
            ["T1 mission generated", "VEM_Intel", true] call vics_sys_debug;
            _currentIntel pushback ["T1", 0];
          };
          if(_randomNum > 70 && _randomNum < 90) then {
            // Intel gave a tier 2 mission
            ["T2 mission generated", "VEM_Intel", true] call vics_sys_debug;
            _currentIntel pushback ["T2", 0];
          };
          if(_randomNum >=90) then {
            // Intel gave a tier 3 mission
            ["T3 mission generated", "VEM_Intel", true] call vics_sys_debug;
            _currentIntel pushback ["T3", 0];
          };
        };
        if (_tier isEqualTo "T2") then {
          // A tier two piece of intel was turned in and something was recovered
          // Tier 2 - %40 t1, %40 t2, %20 t3
          if(_randomNum <= 40) then {
            // Intel gave a tier 1 mission
            ["T1 mission generated", "VEM_Intel", true] call vics_sys_debug;
            _currentIntel pushback ["T1", 0];
          };
          if(_randomNum > 40 && _randomNum < 80) then {
            // Intel gave a tier 2 mission
            ["T2 mission generated", "VEM_Intel", true] call vics_sys_debug;
            _currentIntel pushback ["T2", 0];
          };
          if(_randomNum >=80) then {
            // Intel gave a tier 3 mission
            ["T3 mission generated", "VEM_Intel", true] call vics_sys_debug;
            _currentIntel pushback ["T3", 0];
          };
        };
        if (_tier isEqualTo "T3") then {
          // A tier three piece of intel was turned in and something was recovered
          // Tier 3 - %20 t1, %30 t2, %40 t3, %10 t4
          if(_randomNum <= 20) then {
            // Intel gave a tier 1 mission
            ["T1 mission generated", "VEM_Intel", true] call vics_sys_debug;
            _currentIntel pushback ["T1", 0];
          };
          if(_randomNum > 20 && _randomNum < 50) then {
            // Intel gave a tier 2 mission
            ["T2 mission generated", "VEM_Intel", true] call vics_sys_debug;
            _currentIntel pushback ["T2", 0];
          };
          if(_randomNum >= 50 && _randomNum < 90) then {
            // Intel gave a tier 3 mission
            ["T3 mission generated", "VEM_Intel", true] call vics_sys_debug;
            _currentIntel pushback ["T3", 0];
          };
          if(_randomNum >= 90) then {
            // Intel gave a tier 4 mission
            // Woohoo!!!
            ["T4 mission generated", "VEM_Intel", true] call vics_sys_debug;
            _currentIntel pushback ["T4", 0];
          };
        };
      } else {
        // Intel will return nothing
        ["Nothing gotten from intel", "VEM_Intel", true] call vics_sys_debug;
     };

     // Debugging
     // systemChat format ["%1", _currentIntel];
     // Store changes to currentIntel
     // Determine if infantry or srt
     //systemChat format ["%1", _selectedPlayerUid];
     if (_selectedPlayerUid in srtPlayerUIDs) then {
       profileNameSpace setVariable [(missionPrefix + "srtcurrentIntel"), _currentIntel ];
       //systemChat format ["%1 %2 submitted for processing (SRT)...", _tier, _item];
       [format ["%1 %2 submitted for processing (SRT)...", _tier, _item]] remoteExec ["systemChat", _selectedPlayer];


     } else {
       profileNameSpace setVariable [(missionPrefix + "infantrycurrentIntel"), _currentIntel ];
       //systemChat format ["%1 %2 submitted for processing...", _tier, _item];
       [format ["%1 %2 submitted for processing...", _tier, _item]] remoteExec ["systemChat", _selectedPlayer];
     };
};

// Function to handle taking PID
// Will be called by ace interact
// with a dead body
vem_intel_takePID = {
  systemChat "Not yet implemented";
};

// Function to take unit and
// add random piece of intel
//param is unit to add piece of intel to
vem_intel_unitAddRandomIntelItem = {
  Params [["_unit", player]];
  _randomNum = random 100; // Betw 0-100
  //[format["%1",_randomNum], "VEM_Intel", true] call vics_sys_debug;
  _intel = "";
  // First calculate item type
  // File
  //[chanceUnitHasFile,chanceUnitHasPhone,chanceUnitHasLaptop]
  _chanceUnitHasFile = intelItemChance select 0;
  _chanceUnitHasPhone = intelItemChance select 1;
  _chanceUnitHasLaptop = intelItemChance select 2;
  if (_randomNum < _chanceUnitHasFile) then {
    // Get tier
    _intel = format ["VEM_FILE_%1", call vem_intel_calculateDropTier];
  };
  // Phone
  if (_randomNum > _chanceUnitHasFile && _randomNum <= _chanceUnitHasFile + _chanceUnitHasPhone) then {
    _intel = format ["VEM_PHONE_%1", call vem_intel_calculateDropTier];
  };
  // Laptop
  if(_randomNum > _chanceUnitHasFile + _chanceUnitHasPhone) then {
    _intel = format ["VEM_LAPTOP_%1", call vem_intel_calculateDropTier];
  };

  // Now add piece of intel to unit
  _unit addItem _intel;

  // Returns intel item given to unit
  _intel;
};

// Returns a random item tier weighted by the
// intel tier chance variables
vem_intel_calculateDropTier = {
  _randomNumber = random 100;  // Betw 0-100
  //[format["%1",_randomNum], "VEM_Intel", true] call vics_sys_debug;
  _chanceUnitHasT1 = intelTierChance select 0;
  _chanceUnitHasT2 = intelTierChance select 1;
  _chanceUnitHasT3 = intelTierChance select 2;
  _tier = "";
  if (_randomNumber <= _chanceUnitHasT1) then {
    // return T1
    _tier = "T1";
  };
   if (_randomNumber > _chanceUnitHasT1 && _randomNumber < _chanceUnitHasT1 + _chanceUnitHasT2) then {
    // return T2
    _tier = "T2";
  };
  if (_randomNumber >= (_chanceUnitHasT1 + _chanceUnitHasT2)) then {
     // return T3
    _tier = "T3";
  };
  _tier;
};

// Danger - this will now fill your inv with items
vem_intel_runRandomTest = {
  // Run 1k iterations
  _totals = [0,0,0,0,0,0,0,0,0,0];
  for "_i" from 1 to 10000 do {
    _thisDrop = call vem_intel_unitAddRandomIntelItem;


    if(_thisDrop isEqualTo "VEM_FILE_T1") then{
      _totals set [0, (_totals select 0) + 1];
    };
    if(_thisDrop isEqualTo "VEM_FILE_T2") then{
      _totals set [1, (_totals select 1) + 1];
    };
    if(_thisDrop isEqualTo "VEM_FILE_T3") then{
      _totals set [2, (_totals select 2) + 1];
    };

    if(_thisDrop isEqualTo "VEM_PHONE_T1") then{
      _totals set [3, (_totals select 3) + 1];
    };
    if(_thisDrop isEqualTo "VEM_PHONE_T2") then{
      _totals set [4, (_totals select 4) + 1];
    };
    if(_thisDrop isEqualTo "VEM_PHONE_T3") then{
      _totals set [5, (_totals select 5) + 1];
    };

    if(_thisDrop isEqualTo "VEM_LAPTOP_T1") then{
      _totals set [6, (_totals select 6) + 1];
    };
    if(_thisDrop isEqualTo "VEM_LAPTOP_T2") then{
      _totals set [7, (_totals select 7) + 1];
    };
    if(_thisDrop isEqualTo "VEM_LAPTOP_T3") then{
      _totals set [8, (_totals select 8) + 1];
    };
  };
  systemChat format ["%1", _totals];
};

vics_intel_turnIn = {
  params ["_unit","_inventoryArray"];
  _intelValue = profileNameSpace getVariable [(missionPrefix + "intelValue"),0];

  _intelItems = [];
  {
    _item = _x;
    // Is this item part of VEM
    if ("VEM" in _item) then {
        _intelItems pushback _item;
        _unit removeItem _item;
    };
  } foreach _inventoryArray;
 // _intelItems now contains list of all VEM items
 _intelItems;
 // Now process each intel item
 {
    _item = _x;
    // We need a different result based on each intel item
    if ("FILE" in _item) then {
       // This is a file
        if ("T1" in _item) then {
          // Tier 1 File
          _intelValue = _intelValue + 1;
        };
        if ("T2" in _item) then {
          // Tier 2 File
          _intelValue = _intelValue + 3;
        };
        if("T3" in _item) then {
          // Tier 3 File
          _intelValue = _intelValue + 5;
        };
      };
      if ("PHONE" in _item) then {
        // This is a phone
        if ("T1" in _item) then {
            // Tier 1 phone
             _intelValue = _intelValue + 5;
        };
        if ("T2" in _item) then {
          // Tier 2 phone
           _intelValue = _intelValue + 8;
        };
        if ("T3" in _item) then {
          // Tier 3 phone
            _intelValue = _intelValue + 12;
        };
    };
    if ("LAPTOP" in _item) then {
      // This is a laptop
        if ("T1" in _item) then {
          // Tier 1 laptop
          _intelValue = _intelValue + 15;
        };
        if ("T2" in _item) then {
          // Tier 2 laptop
          _intelValue = _intelValue + 28;
        };
        if ("T3" in _item) then {
          // Tier 3 laptop
          _intelValue = _intelValue + 45;
        };
      };
      uiSleep 0.01;
  } foreach _intelItems;
  profileNameSpace setVariable [(missionPrefix + "intelValue"),_intelValue];
  ["Give us a minute to process this..."] remoteExec ["systemChat",_unit];
  ["We will send an email to your inbox with our estimates. Cpl. Casey Kline"] remoteExec ["systemChat",_unit];
};

vics_intel_process = {
  _intelValue = profileNameSpace getVariable [(missionPrefix + "intelValue"),0];
  _missionTypes = ["HVTKill"];
  if ((random 100) < _intelValue) then {
    _selectedMission = selectRandom _missionTypes;
    switch (_selectedMission) do {
      case "HVTKill": {[] call vics_hvt_missionDisplay};
    };
  } else {
    //Intel value wasnt high enough to generate a mission
  };
};
