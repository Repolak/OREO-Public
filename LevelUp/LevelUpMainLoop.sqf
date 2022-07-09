[] spawn {
  waitUntil {
    uiSleep 1;
    (!isNull player && time > 0.1);
  };
  toggleMenu = 0;
  toggleMainMenu = 0;
  player addEventHandler ["Fired", {
    playerShotCount = playerShotCount + 1;
    profileNameSpace setVariable ["playerShotCount", playerShotCount];
  }];

//Set menu to open on home key pressed



//Get stamina level and values

while {true} do {
  playerStaminaCount = profileNameSpace getVariable "playerStaminaCount";
  if (isNil "playerStaminaCount") then {
    profileNameSpace setVariable ["playerStaminaCount", 0];
    playerStaminaCount = 0;
  };
  playerStaminaCount;
  playerStaminaLevel = profileNameSpace getVariable "playerStaminaLevel";
  if (isNil "playerStaminaLevel") then {
    profileNameSpace setVariable ["playerStaminaLevel", 1];
    playerStaminaLevel = 1;
  };
  playerStaminaLevel;
  playerShotCount = profileNameSpace getVariable "playerShotCount";
  if (isNil "playerShotCount") then {
    profileNameSpace setVariable ["playerShotCount", 0];
    playerStaminaCount = 0;
  };
  playerStaminaCount;
  playerShotLevel = profileNameSpace getVariable "playerShotLevel";
  if (isNil "playerShotLevel") then {
    profileNameSpace setVariable ["playerShotLevel", 1];
    playerShotLevel = 1;
  };
  playerShotLevel;

  nextStaminaLevelVal = (125 * playerStaminaLevel) * playerStaminaLevel;
  nextShotLevelVal = (250 * playerShotLevel) * playerShotLevel;
  if (vehicle player != player) then {
  } else {
   speedvar = speed player;
   if ((speedvar > 1) and (speedvar <11.2)) then {
     playerStaminaCount = playerStaminaCount + 0.01;
      };
   if ((speedvar > 11.2) and (speedvar <17.5)) then {
     playerStaminaCount = playerStaminaCount + 0.25;
      };
   if ((speedvar > 17.6) and (speedvar <23.1)) then {
   playerStaminaCount = playerStaminaCount + 1;
      };
    };
    profileNameSpace setVariable ["playerStaminaCount", playerStaminaCount];
    if (toggleMenu == 1) then {
    //hintSilent parseText format ["<t size=2.0>WELCOME TO LEVELUP\n\nSTAMINA: %1 / %2 Current Level: %3\n\nSHOOTING: %4 / %5 Current Level: %6</t>", playerStaminaCount, nextStaminaLevelVal, playerStaminaLevel, playerShotCount, nextShotLevelVal, playerShotLevel];
    //hintSilent parseText format["<t size='1.25'>WELCOME TO LEVELUP</t> <t size='1'> <br/><br/>STAMINA: %1 / %2    Current Level: %3<br/><br/>SHOOTING: %4 / %5    Current Level: %6<br/><br/>Press Home to open/close menu</t>", playerStaminaCount, nextStaminaLevelVal, playerStaminaLevel, playerShotCount, nextShotLevelVal, playerShotLevel];
  } else {
    //hintSilent "";
  };
    if (playerStaminaCount >= nextStaminaLevelVal) then {
      if (playerStaminaLevel < 10) then {
        player sideChat "leveled up stamina!";
        staminaAdjust = 1 - (0.05 * playerStaminaLevel);
        playerStaminaCount = 0;
        playerStaminaLevel = playerStaminaLevel + 1;
        player setUnitTrait ["loadCoef",staminaAdjust,true];
        profileNameSpace setVariable ["playerStaminaCount", playerStaminaCount];
        profileNameSpace setVariable ["playerStaminaLevel", playerStaminaLevel];
      };
    };
    if (playerShotCount >= nextShotLevelVal) then {
      if (playerShotLevel < 15) then {
        player sideChat "leveled up shooting!";
        ShotAdjust = 1 - (0.05 * playerShotLevel);
        playerShotCount = 0;
        playerShotLevel = playerShotLevel + 1;
        player setCustomAimCoef ShotAdjust;
        profileNameSpace setVariable ["playerShotCount", playerShotCount];
        profileNameSpace setVariable ["playerShotLevel", playerShotLevel];
      };
    };
    uiSleep 1;
  };
};

lvlup_fnc_displayXP = {
  [] spawn {
    disableSerialization;
    waituntil {!isnull (uiNamespace getVariable "vicsXpDisplayTest")};
    playerStaminaCount = profileNameSpace getVariable "playerStaminaCount";
    playerStaminaCount = profileNameSpace getVariable "playerStaminaCount";
    playerStaminaLevel = profileNameSpace getVariable "playerStaminaLevel";
    playerShotCount = profileNameSpace getVariable "playerShotCount";
    playerShotLevel = profileNameSpace getVariable "playerShotLevel";
    _textToAdd = parseText format ["<t size='1.25'>WELCOME TO LEVELUP</t> <t size='1'> <br/><br/>STAMINA: %1 / %2    Current Level: %3<br/><br/>SHOOTING: %4 / %5    Current Level: %6<br/><br/>Press Home to open/close menu</t>",playerStaminaCount, nextStaminaLevelVal, playerStaminaLevel, playerShotCount, nextShotLevelVal, playerShotLevel];
    _display = uiNamespace getVariable "vicsXpDisplayTest";
    _ctrl = _display displayCtrl 1101;
    _ctrl ctrlSetStructuredText _textToAdd;
    copyToClipboard (str _textToAdd);
    systemChat "test";
  };
};
