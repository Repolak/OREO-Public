vics_halo_maskBreathe = {
  [] spawn {
    oxygenState = player getVariable "oxygenState";
    if (isNil "oxygenState") then {
      oxygenState = false;
    };
    oxygenState;
    systemChat format ["%1",oxygenState];
    if (oxygenState isEqualTo false) then {
      _masks = ["mcu2p2_black"];
      _mask = goggles player;
      if (_mask in _masks) then {
        _magazines = magazines player;
        if ("VICS_OXYBOTTLE" in _magazines) then {
          _oxyTime = 20;
          player setVariable ["oxygenState",true];
          oxygenState = true;
            while {_oxyTime > 3.85} do {
              if (oxygenState == false) exitWith {};
              player say "maskBreathe";
              _oxyTime = _oxyTime - 3.85;
              systemChat format ["Time remaining: %1",_oxyTime];
              uiSleep 3.85;
            };
            systemChat "Oxygen ran out!";
            oxygenState = false;
            player setVariable ["oxygenState",false];
          systemChat "Oxygen turned off";
        } else {
          systemChat "No oxygen";
        };
      } else {
        systemChat "Incorrect mask worn";
      };
    } else {
      oxygenState = false;
      player setVariable ["oxygenState",false];
      systemChat "Manually turned off oxygen";
    };
  };
};
