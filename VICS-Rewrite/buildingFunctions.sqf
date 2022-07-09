objectPlacing = 0;
objectsPlaced = 0;
smallObjects = ["Land_BagFence_01_Short_green_F","Land_Plank_01_4m_F","Land_BagFence_Long_green_F","Land_BagFence_01_round_green_F","Land_BagFence_01_corner_green_F"];
mediumObjects = ["Land_HBarrier_3_f","Land_HBarrier_5_f"];
largeObjects = ["Land_HBarrierWall_corridor_F"];
boxes = ["Box_NATO_Ammo_F"];
RBD_fnc_object = {
  params ["_chosenObject","_itemUsed","_amount"];
  if (isNil "_chosenObject") then {
    objectSelected = objectSelected
  } else {
  objectSelected = _chosenObject;
  };

  [_itemUsed,_amount] spawn {
    params ["_itemUsed","_amount"];
    if (objectPlacing == 1) exitWith {hint "Object already being placed!"};
    _placeOptions = player getVariable ["placeOptions",[0,0,0,0]];
    objectPlacing = 1;
    numMod = 1;
    place = 0;
    freeze = 0;
    distanceMod = 3;
    if (objectSelected in smallObjects) then {
      distanceMod = 3;
    };
    if (objectSelected in mediumObjects) then {
      distanceMod = 5;
    };
    if (objectSelected in largeObjects) then {
      distanceMod = 8;
    };
    heightMod = _placeOptions select 0;
    rotateMod = _placeOptions select 1;
    pitchMod = _placeOptions select 2;
    bankMod = _placeOptions select 3;

    player addAction ["Place Object",{place = 1;},nil,8.1,true,false];
    freezeID = player addAction ["Freeze Object",{call RBD_fnc_freezeTrue;},nil,8,true,false];
    heightMenuID = player addAction ["-=Height=-",{call RBD_fnc_objectHeightOpen;},nil,7.9,true,false];
    rotateMenuID = player addAction ["-=Rotate=-",{call RBD_fnc_objectRotateOpen;},nil,7.8,true,false];
    pitchMenuID = player addAction ["-=Pitch=-",{call RBD_fnc_objectPitchOpen;},nil,7.7,true,false];
    numMenuID = player addAction ["-=Values=-",{call RBD_fnc_objectNumOpen;},nil,7.6,true,false];
    resetMenuID = player addAction ["Reset Saved Values",{call RBD_fnc_resetValues;},nil,7.5,true,false];
    player addAction ["Cancel Placement",{place = -1;},nil,7.4];
    worldPos = player modelToWorld [3,0,0];
    _object = objectSelected createVehicleLocal [0,0,0];
    systemChat format ["%1",_object];
    while { place isEqualTo 0} do {
      if (vehicle player != player) then {
        place = -1;
      };
      if (Freeze isEqualTo 0) then {
    uiSleep 0.05;
    if (heightMod > 3) then {
      heightMod = heightMod - numMod;
      hint "You can't build that high!";
    };
    if (heightMod < -3) then {
      heightMod = heightMod + numMod;
      hint "you can't build that low!";
    };
    worldPos = player modelToWorld [0,distanceMod,heightMod];
    objectDir = getDir player;
    objectDir = objectDir + rotateMod;
    _object setDir objectDir;
    _object setPos worldPos;
    [_object, pitchMod, bankMod] call BIS_fnc_setPitchBank;
      };
    if (place isEqualTo 1) then {
      if (objectSelected in boxes) then {
      };
      deleteVehicle _object;
      _objectSave = [objectSelected,worldPos,objectDir,pitchMod,bankMod,nil];
      player setVariable ["placeOptions",[heightMod,rotateMod,pitchMod,bankMod]];
        [_objectSave] call vics_bld_addDigAction;
      objectPlacing = 0;
      objectsPlaced = objectsPlaced + 1;
      [_itemUsed,_amount] call vics_ply_removeItems;
      };
    if (place < 0) then {
      deleteVehicle _object;
    };
    if (place < 0) exitWith {removeAllActions player;objectPlacing = 0;};
    };
    removeAllActions player;
  };
};

RBD_fnc_resetValues = {
  player setVariable ["placeOptions",[0,0,0,0]];
  heightMod = 0;
  rotateMod = 0;
  pitchMod = 0;
  bankMod = 0;
};

RBD_fnc_freezeTrue = {
  freeze = 1;
 player removeAction freezeID;
 freezeID = player addAction ["Unfreeze Object",{call RBD_fnc_freezeFalse;},nil,8,true,false];
};
RBD_fnc_freezeFalse = {
 freeze = 0;
 player removeAction freezeID;
 freezeID = player addAction ["Freeze Object",{call RBD_fnc_freezeTrue;},nil,8,true,false];
};
RBD_fnc_objectRotateOpen = {
    player removeAction rotateMenuID;
    rotateMenuID = player addAction ["-=Rotate=-",{call RBD_fnc_objectRotateClose;},nil,7.8,true,false];
    clockwiseID = player addAction ["Rotate Clockwise",{rotateMod = rotateMod + numMod;},nil,7.8,true,false];
    CClockwiseID = player addAction ["Rotate Counter Clockwise",{rotateMod = rotateMod - numMod;},nil,7.8,true,false];
};
RBD_fnc_objectRotateClose = {
    player removeAction rotateMenuID;
    player removeAction clockwiseID;
    player removeAction CClockwiseID;
    rotateMenuID = player addAction ["-=Rotate=-",{call RBD_fnc_objectRotateOpen;},nil,7.8,true,false];
};
RBD_fnc_objectHeightOpen = {
    player removeAction heightMenuID;
    heightMenuID = player addAction ["-=Height=-",{call RBD_fnc_objectHeightClose;},nil,7.9,true,false];
    raiseID = player addAction ["Raise",{heightMod = heightMod + numMod;},nil,7.9,true,false];
    lowerID = player addAction ["Lower",{ heightMod = heightMod - numMod;},nil,7.9,true,false];
};
RBD_fnc_objectHeightClose = {
    player RemoveAction heightMenuID;
    player RemoveAction raiseID;
    player removeAction lowerID;
    heightMenuID = player addAction ["-=Height=-",{call RBD_fnc_objectHeightOpen;},nil,7.9,true,false];
};
RBD_fnc_objectPitchOpen = {
  player removeAction pitchMenuID;
  pitchMenuID = player addAction ["-=Pitch=-",{call RBD_fnc_objectPitchClose;},nil,7.7,true,false];
  pitchforwardID = player addAction ["Pitch forward",{pitchMod = pitchMod - numMod;},nil,7.7,true,false];
  pitchbackwardID = player addAction ["Pitch backward",{pitchMod = pitchMod + numMod;},nil,7.7,true,false];
  bankRightID = player addAction ["Bank right",{bankMod = bankMod + numMod;},nil,7.7,true,false];
  bankLeftID = player addAction ["Bank left",{bankMod = bankMod - numMod;},nil,7.7,true,false];
};
RBD_fnc_objectPitchClose = {
  player removeAction pitchMenuID;
  player removeAction pitchforwardID;
  player removeAction pitchbackwardID;
  player removeAction bankRightID;
  player removeAction bankLeftID;
  pitchMenuID = player addAction ["-=Pitch=-",{call RBD_fnc_objectPitchOpen;},nil,7.7,true,false];
};
RBD_fnc_objectNumOpen = {
  player removeAction numMenuID;
  numMenuID = player addAction ["-=Values=-",{call RBD_fnc_objectNumClose;},nil,7.6,true,false];
  value90ID = player addAction ["90",{numMod = 90;},nil,7.6,true,false];
  value45ID = player addAction ["45",{numMod = 45;},nil,7.6,true,false];
  value15ID = player addAction ["15",{numMod = 15;},nil,7.6,true,false];
  value1ID = player addAction ["1",{numMod = 1;},nil,7.6,true,false];
  valuepoint5ID = player addAction ["0.5",{numMod = 0.5;},nil,7.6,true,false];
  valuepoint1ID = player addAction ["0.1",{numMod = 0.1;},nil,7.6,true,false];
};
RBD_fnc_objectNumClose = {
  player removeAction numMenuID;
  player removeAction value90ID;
  player removeAction value45ID;
  player removeAction value15ID;
  player removeAction value1ID;
  player removeAction valuepoint5ID;
  player removeAction valuepoint1ID;
  numMenuID = player addAction ["-=Values=-",{call RBD_fnc_objectNumOpen;},nil,7.6,true,false];
};

RBD_fnc_saveObjects = {
  params ["_objectToSave"];
  _playerBuiltObjects = profileNameSpace getVariable [(missionPrefix + "playerBuiltObjects"),[]];
  _playerBuiltObjects pushBack _objectToSave;
  profileNameSpace setVariable [(missionPrefix + "playerBuiltObjects"),_playerBuiltObjects];
  [] call vics_bld_verifyConstruction;
};

RBD_fnc_loadObjects = {
  _playerBuiltObjects = profileNameSpace getVariable [(missionPrefix + "playerBuiltObjects"),[]];
  {
    _objectToCreate = _x;
    _objectClass = _objectToCreate select 0;
    _objectPosition = _objectToCreate select 1;
    _objectDir = _objectToCreate select 2;
    _objectPitch = _objectToCreate select 3;
    _objectBank = _objectToCreate select 4;
    _objectCreated = createVehicle [_objectClass,_objectPosition,[],0,"CAN_COLLIDE"];
    _removeAction = ["removeAction","Remove","",{[_target] call vics_bld_removeConstruction},{("ACE_EntrenchingTool" in (items player));}] call ace_interact_menu_fnc_createAction;
    [_objectCreated,0,["ACE_MainActions"], _removeAction, true] remoteExec ["ace_interact_menu_fnc_addActionToObject",0,false];
    _objectCreated setDir _objectDir;
    _objectCreated setPos _objectPosition;
    [_objectCreated, _objectPitch, _objectBank] call BIS_fnc_setPitchBank;
    _objectToCreate set [5,_objectCreated];
    _playerBuiltObjects set [_forEachIndex,_objectToCreate];
  }forEach _playerBuiltObjects;
  profileNameSpace setVariable [(missionPrefix + "playerBuiltObjects"),_playerBuiltObjects];
};

vics_bld_addDigAction = {
  params ["_objectArray"];
  _objectClass = _objectArray select 0;
  _objectPosition = _objectArray select 1;
  _objectDir = _objectArray select 2;
  _objectPitch = _objectArray select 3;
  _objectBank = _objectArray select 4;
  _helperObject = createVehicle ["FlagMarker_01_F",_objectPosition,[],0,"CAN_COLLIDE"];
  _helperObject setVariable ["objectBuild",_objectArray,true];
  _digAction = ["digAction","Dig","",{[_target] call vics_bld_dig},{("ACE_EntrenchingTool" in (items player));}] call ace_interact_menu_fnc_createAction;
  systemChat str _objectArray;
  [_helperObject,0,["ACE_MainActions"], _digAction, true] remoteExec ["ace_interact_menu_fnc_addActionToObject",0,false];
};

vics_bld_dig = {
  params ["_helper"];
  [15,[_helper],{[_args select 0] call vics_bld_digSuccess;},{HintSilent "Stopped digging."}, "Digging..."] call ace_common_fnc_progressBar;
};

vics_bld_digSuccess = {
  params ["_helper"];
  _objectArray = _helper getVariable ["objectBuild",nil];
  if !(isNil "_objectArray") then {
    deleteVehicle _helper;
    _objectClass = _objectArray select 0;
    _objectPosition = _objectArray select 1;
    _objectDir = _objectArray select 2;
    _objectPitch = _objectArray select 3;
    _objectBank = _objectArray select 4;
    _objectCreated = createVehicle [_objectClass,_objectPosition,[],0,"CAN_COLLIDE"];
    _removeAction = ["removeAction","Remove","",{[_target] call vics_bld_removeConstruction},{("ACE_EntrenchingTool" in (items player));}] call ace_interact_menu_fnc_createAction;
    [_objectCreated,0,["ACE_MainActions"], _removeAction, true] remoteExec ["ace_interact_menu_fnc_addActionToObject",0,false];
    _objectCreated setDir _objectDir;
    _objectCreated setPos _objectPosition;
    [_objectCreated, _objectPitch, _objectBank] call BIS_fnc_setPitchBank;
    _objectArray set [5,_objectCreated];
    [_objectArray] remoteExec ["RBD_fnc_SaveObjects",2];
  };
};

vics_bld_removeConstruction = {
  params ["_object"];
  deleteVehicle _object;
};

vics_bld_verifyConstruction = {
  _playerBuiltObjects = profileNameSpace getVariable [(missionPrefix + "playerBuiltObjects"),[]];
  _playerObjectsUpdated = [];
  {
    if !(isNull (_x select 5)) then {
      _playerObjectsUpdated pushBack _x;
    };
  }forEach _playerBuiltObjects;
  profileNameSpace setVariable [(missionPrefix + "playerBuiltObjects"),_playerObjectsUpdated];
};

vics_bld_constructRequest = {
  params ["_unit","_construction"];
  _buildingPos = getPos _unit;
  _buildingDir = getDir _unit;
  _constructionObject = _construction select 0;
  _constructionTime = _construction select 1;
  _constructed = nil;
  [_constructionTime,[_buildingPos,_buildingDir,_constructionObject],{[_args select 0,_args select 1,_args select 2] call vics_bld_constructStructure;},{_constructed = false},"Building"] call ace_common_fnc_progressBar;
};

vics_bld_constructStructure = {
  params ["_buildingPos","_buildingDir","_constructionObject"];
  _constructionComp = [_constructionObject,_buildingPos,[0,0,0],_buildingDir,true,true,true] call LARs_fnc_spawnComp;
};

vics_bld_setFobPoint = {
  params ["_playerPos","_fobPos","_clientID"];
  _fobNames = ["APACHE","AZTEC","BANSHEE","BERETTA","CLEARY","DRAGON","IRON","MURRAY","RESOLVE","ROMEO","RUGER","SOUTH","SPEAR","TAMPA","TRIPOLI","WARHORSE","DELTA","COBRA","ENDEAVOR","MAREZ","ARROW","BULLDOG","COMANCHE","EDEN","ARCHER","CATFISH"];
  _createdFobs = profileNameSpace getVariable [(missionPrefix + "createdFobs"),[]];
  _usedFobNames = profileNameSpace getVariable [(missionPrefix + "usedFobNames"),[]];
  if ((count _createdFobs) < playerFobsAllowed) then {
    _fobNameChosen = false;
    _fobName = nil;
    while {_fobNameChosen isEqualTo false} do {
      _fobName = selectRandom _fobNames;
      if !(_fobName in _usedFobNames) then {
        _fobNameChosen = true;
      };
    };
    _fobName;
    _createdFob = [_fobPos,[_fobName]];
    _fobMarker = createMarker [("fobMarker_" + _fobName),_fobPos];
    _fobMarker setMarkerType "hd_dot";
    _fobMarker setMarkerSize [250,250];
    _fobMarker setMarkerBrush "Border";
    _fobMarker setMarkerShape "ELLIPSE";
    _fobMarker setMarkerColor "colorWEST";
    _fobMarker setMarkerAlpha 0.3;
    _fobFlag = createMarker [("fobFlag_" + _fobName),_fobPos];
    _fobFlag setMarkerType "Faction_US";
    _fobFlag setMarkerAlpha 1;
    _fobFlag setMarkerText ("COP " + _fobName);
    _usedFobNames pushBack _fobName;
    _createdFobs pushBack _createdFob;
    profileNameSpace setVariable [(missionPrefix + "createdFobs"),_createdFobs];
    profileNameSpace setVariable [(missionPrefix + "usedFobNames"),_usedFobNames];
  } else {
    ["FOB limit reached."] remoteExec ["systemChat",_clientID];
  };

};

vics_bld_loadFobPoints = {
  [] spawn {
    _createdFobs = profileNameSpace getVariable [(missionPrefix + "createdFobs"),[]];
    {
      _fobArray = _x;
      _fobPos = _fobArray select 0;
      _fobInfo = _fobArray select 1;
      _fobName = _fobInfo select 0;
      if (_fobName isEqualTo "BANCHEE") then {
        _fobName = "BANSHEE";
      };
      _fobName;
      _fobMarker = createMarker [("fobMarker_" + _fobName),_fobPos];
      _fobMarker setMarkerType "hd_dot";
      _fobMarker setMarkerSize [250,250];
      _fobMarker setMarkerBrush "Border";
      _fobMarker setMarkerShape "ELLIPSE";
      _fobMarker setMarkerColor "colorWEST";
      _fobMarker setMarkerAlpha 0.3;
      _fobFlag = createMarker [("fobFlag_" + _fobName),_fobPos];
      _fobFlag setMarkerType "Faction_US";
      _fobFlag setMarkerAlpha 1;
      _fobFlag setMarkerText ("COP " + _fobName);
      objectiveSpawnBlacklist pushBackUnique _fobMarker;
    }forEach _createdFobs;
    systemChat str (objectiveSpawnBlacklist);
  };
  true;
};

vics_bld_setPBPoint = {
  params ["_playerPos","_pbPos","_clientID"];
  _fobNames = ["APACHE","AZTEC","BANSHEE","BERETTA","CLEARY","DRAGON","IRON","MURRAY","RESOLVE","ROMEO","RUGER","SOUTH","SPEAR","TAMPA","TRIPOLI","WARHORSE","DELTA","COBRA","ENDEAVOR","MAREZ","ARROW","BULLDOG","COMANCHE","EDEN","ARCHER","CATFISH"];
  _createdPBs = profileNameSpace getVariable [(missionPrefix + "createdPBs"),[]];
  _usedPBNames = profileNameSpace getVariable [(missionPrefix + "usedPBNames"),[]];
  if ((count _createdPBs) < playerPBsAllowed) then {
    _pbNameChosen = false;
    _pbName = nil;
    while {_pbNameChosen isEqualTo false} do {
      _pbName = selectRandom _fobNames;
      if !(_pbName in _usedPBNames) then {
        _pbNameChosen = true;
      };
    };
    _pbName;
    _createdPB = [_pbPos,[_pbName]];
    _PBMarker = createMarker [("pbMarker_" + _pbName),_pbPos];
    _PBMarker setMarkerType "hd_dot";
    _PBMarker setMarkerSize [50,50];
    _PBMarker setMarkerBrush "Border";
    _PBMarker setMarkerShape "ELLIPSE";
    _PBMarker setMarkerColor "colorWEST";
    _PBMarker setMarkerAlpha 0.3;
    _pbFlag = createMarker [("pbFlag_" + _pbName),_pbPos];
    _pbFlag setMarkerType "Faction_US";
    _pbFlag setMarkerAlpha 1;
    _pbFlag setMarkerText ("PB " + _pbName);
    _usedPBNames pushBack _pbName;
    _createdPBs pushBack _createdPB;
    profileNameSpace setVariable [(missionPrefix + "createdPBs"),_createdPBs];
    profileNameSpace setVariable [(missionPrefix + "usedPBNames"),_usedPBNames];
  } else {
    ["PB limit reached."] remoteExec ["systemChat",_clientID];
  };

};

vics_bld_loadPBPoints = {
  [] spawn {
    _createdPBs = profileNameSpace getVariable [(missionPrefix + "createdPBs"),[]];
    {
      _pbArray = _x;
      _pbPos = _pbArray select 0;
      _pbInfo = _pbArray select 1;
      _pbName = _pbInfo select 0;
      if (_pbName isEqualTo "BANCHEE") then {
        _pbName = "BANSHEE";
      };
      _pbName;
      _pbMarker = createMarker [("pbMarker_" + _pbName),_pbPos];
      _pbMarker setMarkerType "hd_dot";
      _pbMarker setMarkerSize [250,250];
      _pbMarker setMarkerBrush "Border";
      _pbMarker setMarkerShape "ELLIPSE";
      _pbMarker setMarkerColor "colorWEST";
      _pbMarker setMarkerAlpha 0.3;
      _pbFlag = createMarker [("pbFlag_" + _pbName),_pbPos];
      _pbFlag setMarkerType "Faction_US";
      _pbFlag setMarkerAlpha 1;
      _pbFlag setMarkerText ("PB " + _pbName);
      objectiveSpawnBlacklist pushBackUnique _pbMarker;
    }forEach _createdPBs;
    systemChat str (objectiveSpawnBlacklist);
  };
  true;
};
