/*
rcas_fnc_hook = {
  waituntil {!isnull (finddisplay 46)};
  _keyPressed = (findDisplay 46) displayAddEventHandler ["KeyDown", {if (_this select 1 == 199) then { closeDialog 0; createDialog "RCAS";};}];
};
[] spawn rcas_fnc_hook;
*/

rcas_fnc_radio = {
  params ["_gTgt","_gIngress","_dir","_distance","_munition","_cancelCode"];
  _posResponse = ["Its good"];
  _negResponse = ["Nope ya dumb fuck"];
  _gridTgt = parseNumber _gTgt;
  _gridIngress = parseNumber _gIngress;
  _dir = parseNumber _dir;
  _distance = parseNumber _distance;
  if (_gridTgt == 0) exitWith {systemChat "Incorrect TGT grid format"};
  if (_gridIngress == 0) exitWith {systemChat "Incorrect Ingress grid format"};
  _tgt = _gTgt call BIS_fnc_gridToPos;
  _ingress = _gIngress call BIS_fnc_gridToPos;
  _tgt = _tgt select 0;
  _ingress = _ingress select 0;
  _dirChallenge = _ingress getDir _tgt;
  _res = abs(1 - abs(_dirChallenge-_dir)/180);
  _ans = nil;
  if (_res > .9) then {
  _ans = true;
  } else {
    _ans = false;
  };
  _ans;
  _dirCheck = _ans;
  _distChallenge = _tgt distance2D _ingress;
  _res = abs(_distance - _distChallenge);
  if (_res < 800) then {
    _ans = true;
  } else {
    _ans = false;
  };
  _ans;
  _distCheck = _ans;
  _ans = nil;
  deleteMarkerLocal "ing";
  deleteMarkerLocal "tgt";
  _ingMrk = createMarkerLocal ["ing",_ingress];
  _ingMrk setMarkerTypeLocal "mil_arrow";
  _ingMrk setMarkerDirLocal _dirChallenge;
  _tgtMrk = createMarkerLocal ["tgt",_tgt];
  _tgtMrk setMarkerTypeLocal "mil_destroy";
  _brev = toUpper _munition;
  _atkType = nil;
  switch (_brev) do {
    case "ALPHA": {_atkType = 0};
    case "BRAVO": {_atkType = 1};
    case "CHARLIE": {_atkType = 2};
    case "DELTA": {_atkType = 3};
  };
  _atkType;
  player setVariable ["cancelCode",_cancelCode];
  player setVariable ["cancelCheck",nil];
  if ((_dirCheck isEqualTo true) && (_distCheck isEqualTo true)) then {
    _response = selectRandom _posResponse;
    systemChat format ["%1",_response];
    [3500,"NORMAL",_tgt,_ingress,_dir,_distance,_atkType] spawn rcas_fnc_request;
  } else {
    _response = selectRandom _negResponse;
    systemChat format ["%1",_response];
  };
};


rcas_fnc_request = {
  params [["_altitude", 100],["_speed","NORMAL"],"_tgt","_ingress","_dir","_distance","_ordnance"];
  _targetPos = nil;
  _targetPos = _tgt;
  _targetPos;
  _mrkr = createMarkerLocal ["target",_targetPos];
  _mrkr setMarkerShapeLocal "ELLIPSE";
  _mrkr setMarkerSizeLocal [1000,1000];
  _mrkr setMarkerBrushLocal "Grid";
  _mrkr setMarkerAlpha 0;
  _flyByStart = getMarkerPos "RCASSPAWN";
  _flyByEnd = _ingress;
  [_flyByStart, _flyByEnd, _altitude, _speed, "B_Plane_CAS_01_dynamicLoadout_F"] call BIS_fnc_ambientFlyby;
  _dir = _flyByEnd getDir _targetPos;
  _nearObjects = nearestObjects [_flyByStart,["Plane"],100];
  _plane = _nearObjects select 0;
  while {alive _plane} do {
    _distanceToTgt = _plane distance2D _targetPos;
    if (_distanceToTgt > 1000) then {
      _txtToShow = format ["Distnace: %1",_distanceToTgt];
      [_txtToShow] spawn rcas_ui_trackerUpdate;
    } else {
      _txtToShow = "Entering Airspace";
      [_txtToShow] spawn rcas_ui_trackerUpdate;
    };
    uiSleep 1;
  };
  systemChat "Aircraft in Airspace. Break.";
  uiSleep (random 2);
  systemChat "Mark with laser. Over.";
  _laseCheckCount = 0;
  _laseTgt = nil;
  while {isNil "_laseTgt"} do {
    _laser = getPosATL laserTarget player;
    if ((_laser distance2D _targetPos) < 500) then {
      systemChat "lase Found. Rounds imbound.";
      _laseTgt = _laser;
    } else {
      _laseTgt = nil;
    };
    _laseCheckCount = _laseCheckCount + 1;
    if (_laseCheckCount == 30) then {
      systemChat "Still searching for that laser. Over.";
    };
    if (_laseCheckCount == 60) then {
      systemChat "We aren't catching your designation. Make sure you put batteries in your designator. Over.";
    };
    if (_laseCheckCount == 75) then {
      systemChat "Last call for that lase or we are RTB. Over.";
    };
    if (_laseCheckCount > 90) exitWith {systemChat "Unable to track your laser. We are Bingo fuel and RTB. Out."};
    uisleep 1;
  };
  if (isNil "_laseTgt") then {

  } else {
    [_laseTgt,_dir,"B_Plane_CAS_01_F",_ordnance] remoteExec ["rcas_fnc_cas",2];
  };
  deleteMarkerLocal "target";
  deleteMarkerLocal "ing";
  deleteMarkerLocal "tgt";
  onMapSingleClick "";
};

rcas_fnc_cas = {
  params [
  	"_position","_direction",["_vehicle","B_Plane_CAS_01_F"],["_type",2],
  	"_logic"
  ];

  _logic = createAgent ["Logic",_position,[],0,"CAN_COLLIDE"];
  _logic setDir _direction;
  _logic setVariable ["vehicle",_vehicle];
  _logic setVariable ["type",_type];

  [_logic,nil,true] call BIS_fnc_moduleCAS;
  systemChat "Engaging Target. Out.";
  uiSleep 15;
  systemChat "Clearing Airspace. Will check in shortly. Out.";
  deleteVehicle _logic;
  uiSleep 18;
  systemChat "How was that strike. Over.";
  _negEffect = player addAction ["Negative Effect. Re-engage. Over.",{[0,_this select 3 select 0, _this select 3 select 1, _this select 3 select 2, _this select 3 select 3] call rcas_fnc_rerun;},[_position,_direction,_vehicle,_type]];
  _posEffect = player addACtion ["Positive Effect. Good hits. Out.",{[1] call rcas_fnc_rerun}];
  player setVariable ["rcasActions",[_negEffect,_posEffect]];
};

rcas_fnc_rerun = {
  params ["_effect","_position","_direction","_plane","_type"];
  _rcasActions = player getVariable "rcasActions";
  {
    player removeAction _x;
  }forEach _rcasActions;
  if (_effect isEqualTo 0) then {
    systemChat "Re-engaging target. Wait one. Out.";
    uiSleep (round (random [12,16,22]));
    systemChat "Aircraft in Airspace. Break.";
    uiSleep (random 2);
    systemChat "Mark with laser. Over.";
    _laseCheckCount = 0;
    _laseTgt = nil;
    while {isNil "_laseTgt"} do {
      _laser = getPosATL laserTarget player;
      if ((_laser distance2D _position) < 700) then {
        systemChat "lase Found. Rounds imbound.";
        _laseTgt = _laser;
      } else {
        _laseTgt = nil;
      };
      _laseCheckCount = _laseCheckCount + 1;
      if (_laseCheckCount == 30) then {
        systemChat "Still searching for that laser. Over.";
      };
      if (_laseCheckCount == 60) then {
        systemChat "We aren't catching your designation. Make sure you put batteries in your designator. Over.";
      };
      if (_laseCheckCount == 75) then {
        systemChat "Last call for that lase or we are RTB. Over.";
      };
      if (_laseCheckCount > 90) exitWith {systemChat "Unable to track your laser. We are Bingo fuel and RTB. Out."};
      uisleep 1;
    };
    if (isNil "_laseTgt") then {

    } else {
      [_laseTgt,_direction,"B_Plane_CAS_01_F",_type] remoteExec ["rcas_fnc_cas",2];
    };
  } else {
    systemChat "Copy good effect. Out.";
  };
};


rcas_ui_map = {
  _mapCtrls = [1540,1541];
  _otherCtrls = [1561,1571,1572,1573,1574];
  {
    ctrlShow [_x, false];
  }forEach _otherCtrls;
  {
    if (ctrlVisible _x) then {
      ctrlShow [_x, false];
      } else {
      ctrlShow [_x, true]};
  }forEach _mapCtrls;
};
rcas_ui_tracker = {
  _trackerCtrls = [1561];
  _otherCtrls = [1540,1541,1571,1572,1573,1574];
  {
    ctrlShow [_x, false];
  }forEach _otherCtrls;
  {
    if (ctrlVisible _x) then {
      ctrlShow [_x, false]
      } else {
      ctrlShow [_x, true]};
  }forEach _trackerCtrls;
};

rcas_ui_comms = {
  _commsCtrls = [1571,1572,1573,1574];
  _otherCtrls = [1540,1541,1561];
  {
    ctrlShow [_x, false];
  }forEach _otherCtrls;
  {
    if (ctrlVisible _x) then {
      ctrlShow [_x, false]
      } else {
      ctrlShow [_x, true]};
  }forEach _commsCtrls;
};

rcas_ui_start = {
  _allCtrls = [1540,1541,1561,1571,1572,1573,1574];
  {
    ctrlShow [_x, false];
  }forEach _allCtrls;
};

rcas_ui_trackerUpdate = {
  params ["_txt"];
  _txtToShow = format ["%1",_txt];
  ctrlSetText [1561,_txtToShow];
};
