vics_sys_debug = {
  params ["_text","_prefix","_log"];
  _time = [time, "HH:MM:SS"] call BIS_fnc_secondsToString;
  _prefix = toUpper _prefix;
  _fullMessage = format ["[%1] %2 - %3",_time,_prefix,_text];
  if (debugMsg isEqualTo true) then {
    [_fullMessage] remoteExec ["systemChat",0];
  };
  if (_log isEqualTo true) then {
    diag_log _fullMessage;
  };
};

// Code below to get player ids
// local exec this while looking
// at intended player. Will error
// if not looking at player
// getPlayerUID cursorObject;
