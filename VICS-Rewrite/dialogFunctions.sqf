vics_diag_intelUpdate = {
  systemChat "test";
};

vem_diag_setMissionActive = {

};

vem_diag_setMissionDetails = {
  [] spawn {
    uiSleep 1;
    _textToAdd = "<t size=2.0>Large text</t> Normal text <br/> A different line";
    systemChat format ["%1",(parseText _textToAdd)];
    ((uiNamespace getVariable "missionDisplayDetails") displayCtrl 1100) ctrlSetStructuredText (parseText _textToAdd);
  };
};


vics_tablet_login = {
  params ["_user","_pass"];
  _users = ["Repo","User"];
  _passwords = ["123","Password"];
  _loggedIn = player getVariable "tabletLogged";
  if (!isNil "_loggedIn") then {
    closeDialog 0;
    createDialog "vicsTabletHome";
    systemChat "Previously Logged in.";
    systemChat "Login: Success";
  } else {
    if ((_user in _users) && (_pass in _passwords)) then {
      closeDialog 0;
      createDialog "vicsTabletHome";
      player setVariable ["tabletLogged",true];
      systemChat "Login: Success";
    } else {
      systemChat "Login: Failed";
    };
  };
};


vics_tablet_xpInfo = {
  _textToAdd = parseText "<t size='1.25'>WELCOME TO LEVELUP</t> <t size='1'> <br/><br/>STAMINA: %1 / %2    Current Level: %3<br/><br/>SHOOTING: %4 / %5    Current Level: %6<br/><br/>Press Home to open/close menu</t>";
  _display = findDisplay 888;
  _ctrl = _display displayCtrl 1101;
  _ctrl ctrlSetStructuredText _textToAdd;
};

vics_menu_xpText = {
  [] spawn {
    waituntil {!isnull (finddisplay 1999)};
    _uiSizeSetting = profileNameSpace getVariable ["uiSizeSetting","Medium"];
    _textToShow = nil;
    if (_uiSizeSetting isEqualTo "Small") then {
      _textToShow = format ["<t size= '0.7' align='center'>LEVELUP</t> <t size= '0.7' align='center'> <br/><br/>STAMINA: %1 / %2    Current Level: %3<br/><br/>SHOOTING: %4 / %5    Current Level: %6<br/><br/></t>", playerStaminaCount, nextStaminaLevelVal, playerStaminaLevel, playerShotCount, nextShotLevelVal, playerShotLevel];
    };
    if (_uiSizeSetting isEqualTo "Medium") then {
      _textToShow = format ["<t size= '0.9' align='center'>LEVELUP</t> <t size= '0.85' align='center'> <br/><br/>STAMINA: %1 / %2    Current Level: %3<br/><br/>SHOOTING: %4 / %5    Current Level: %6<br/><br/></t>", playerStaminaCount, nextStaminaLevelVal, playerStaminaLevel, playerShotCount, nextShotLevelVal, playerShotLevel];
    };
    if (_uiSizeSetting isEqualTo "Large") then {
      _textToShow = format ["<t size= '1.1' align='center'>LEVELUP</t> <t size= '0.9' align='center'> <br/><br/>STAMINA: %1 / %2    Current Level: %3<br/><br/>SHOOTING: %4 / %5    Current Level: %6<br/><br/></t>", playerStaminaCount, nextStaminaLevelVal, playerStaminaLevel, playerShotCount, nextShotLevelVal, playerShotLevel];
    };
    _displayCtrl = uiNamespace getVariable "vics_MainMenu" displayCtrl 1100;
    _displayCtrl ctrlSetStructuredText parseText _textToShow;
    call vics_menu_playerNear;
    //call vics_menu_statistics;
  };
};

vics_menu_statistics = {
  _creditsPlayer = [player] call HALs_money_fnc_getFunds;
  _creditsRounded = [_creditsPlayer,2] call BIS_fnc_cutDecimals;
  _uiSizeSetting = profileNameSpace getVariable ["uiSizeSetting","medium"];
  _textToShow = nil;
  if (_uiSizeSetting isEqualTo "Small") then {
    _textToShow = format ["<t size = '0.7' align='center'>Statistics</t> <t size = '0.7' align='center'> <br/><br/> Credits: %7 <br/> Rounds fired: %1 <br/> Magazines reloaded: %2 <br/> Containers opened: %3 <br/> Items taken %4 <br/> Times hit: %5 <br/> Times KIA: %6 </t>",statsShotCount,statsReloadedCount,statsContOpen,statsItemTaken,statsHitCount,statsDeath,_creditsRounded];
  };
  if (_uiSizeSetting isEqualTo "Medium") then {
    _textToShow = format ["<t size = '0.9' align='center'>Statistics</t> <t size = '0.85' align='center'> <br/><br/> Credits: %7 <br/> Rounds fired: %1 <br/> Magazines reloaded: %2 <br/> Containers opened: %3 <br/> Items taken %4 <br/> Times hit: %5 <br/> Times KIA: %6 </t>",statsShotCount,statsReloadedCount,statsContOpen,statsItemTaken,statsHitCount,statsDeath,_creditsRounded]
  };
  if (_uiSizeSetting isEqualTo "Large") then {
    _textToShow = format ["<t size = '1.0' align='center'>Statistics</t> <t size = '1' align='center'> <br/><br/> Credits: %7 <br/> Rounds fired: %1 <br/> Magazines reloaded: %2 <br/> Containers opened: %3 <br/> Items taken %4 <br/> Times hit: %5 <br/> Times KIA: %6 </t>",statsShotCount,statsReloadedCount,statsContOpen,statsItemTaken,statsHitCount,statsDeath,_creditsRounded]
  };
  _textToShow;
  _displayCtrl = uiNamespace getVariable "vics_MainMenu" displayCtrl 1101;
  _displayCtrl ctrlSetStructuredText parseText _textToShow;

};


vics_menu_playerNear = {
  _displayCtrl = uiNamespace getVariable "vics_MainMenu" displayCtrl 1500;
  {
    if (((player distance2D _x) < 5) &&!(_x isEqualTo player)) then {
      _name = name _x;
      _lbCreated = _displayCtrl lbAdd _name;
      _displayCtrl lbSetData [_lbCreated, _x call BIS_fnc_objectVar];
    };
  }forEach allUnits;
  //_creditsPlayer = [player] call HALs_money_fnc_getFunds;
  //_creditsRounded = [_creditsPlayer,2] call BIS_fnc_cutDecimals;
  //ctrlSetText [1003,("Balance: " + str (_creditsRounded) + " Credits")];
};

vics_menu_transferCredits = {
  _amountToTransfer = parseNumber (ctrlText 1400);
  _activeLabel = lbCurSel 1500;
  _labelData = lbData [1500,_activeLabel];
  _target = call compile format [_labelData, objNull];
  [_target,_amountToTransfer] call vics_ply_transferCredits;
};

vics_menu_refresh = {
  closeDialog 1; createDialog "vicsMainMenuTabletPlayer";
};

vics_menu_settings = {
  _displayCtrl = uiNamespace getVariable "vics_MainMenu" displayCtrl 2100;
  _wallpaperCtrl = uiNamespace getVariable "vics_MainMenu" displayCtrl 2101;
  _uiSizeSetting = profileNameSpace getVariable ["uiSizeSetting","medium"];
  _wallpaperSetting = profileNameSpace getVariable ["wallpaperSetting","0"];
  _lbCreated = _displayCtrl lbAdd "Small";
  _lbCreated = _displayCtrl lbAdd "Medium";
  _lbCreated = _displayCtrl lbAdd "Large";

  _lbCreated = _wallpaperCtrl lbAdd "0";
  _lbCreated = _wallpaperCtrl lbAdd "1";
  _lbCreated = _wallpaperCtrl lbAdd "2";
  _lbCreated = _wallpaperCtrl lbAdd "3";

  if (_uiSizeSetting isEqualTo "Small") then {
    _displayCtrl lbSetCurSel 0;
  };
  if (_uiSizeSetting isEqualTo "Medium") then {
    _displayCtrl lbSetCurSel 1;
  };
  if (_uiSizeSetting isEqualTo "Large") then {
    _displayCtrl lbSetCurSel 2;
  };

  if (_wallpaperSetting isEqualTo "0") then {
    _wallpaperCtrl lbSetCurSel 0;
  };
  if (_wallpaperSetting isEqualTo "1") then {
    _wallpaperCtrl lbSetCurSel 1;
  };
  if (_wallpaperSetting isEqualTo "2") then {
    _wallpaperCtrl lbSetCurSel 2;
  };
  if (_wallpaperSetting isEqualTo "3") then {
    _wallpaperCtrl lbSetCurSel 3;
  };
};

vics_menu_settingsApply = {
  _comboCtrl = uiNamespace getVariable "vics_MainMenu" displayCtrl 2100;
  _wallpaperCtrl = uiNamespace getVariable "vics_MainMenu" displayCtrl 2101;
  _wallpaperSetting = profileNameSpace getVariable ["wallpaperSetting","0"];
  _lbIndex = lbCurSel _comboCtrl;
  _selectedUiSetting = _comboCtrl lbText _lbIndex;
  profileNameSpace setVariable ["uiSizeSetting",_selectedUiSetting];

  _lbIndex = lbCurSel _wallpaperCtrl;
  _selectedWallpaper = _wallpaperCtrl lbText _lbIndex;
  profileNameSpace setVariable ["wallpaperSetting",_selectedWallpaper];

  closeDialog 0;
  if (_selectedWallpaper isEqualTo "0") then {
  createDialog "vicsMainMenuTablet";
  };
  if (_selectedWallpaper isEqualTo "1") then {
  createDialog "vicsMainMenuTablet";
  };
  if (_selectedWallpaper isEqualTo "2") then {
  createDialog "vicsMainMenuTablet";
  };
  if (_selectedWallpaper isEqualTo "3") then {
  createDialog "vicsMainMenuTablet";
  };
};

vics_menu_open = {
  _wallpaperSetting = profileNameSpace getVariable ["wallpaperSetting","0"];
  closeDialog 0;
  if (_wallpaperSetting isEqualTo "0") then {
  createDialog "vicsMainMenuTablet";
  };
  if (_wallpaperSetting isEqualTo "1") then {
  createDialog "vicsMainMenuTablet";
  };
  if (_wallpaperSetting isEqualTo "2") then {
  createDialog "vicsMainMenuTablet";
  };
  if (_wallpaperSetting isEqualTo "3") then {
  createDialog "vicsMainMenuTablet";
  };
};

vics_menu_InfoUpdate = {
  [] spawn {
    waituntil {!isnull (finddisplay 1999)};
    _uiSizeSetting = profileNameSpace getVariable ["uiSizeSetting","Medium"];
    _textToShow = nil;
    _curDate = date;
    _ddMMyyyy = format [
    "%3/%2/%1",
	  _curDate select 0,
	  (if (_curDate select 1 < 10) then { "0" } else { "" }) + str (_curDate select 1),
	  (if (_curDate select 2 < 10) then { "0" } else { "" }) + str (_curDate select 2)
    ];
    _time = [(daytime), "HH:MM"] call BIS_fnc_timeToString;
    if (_uiSizeSetting isEqualTo "Small") then {
      _textToShow = format ["<t size= '0.9' align='right'>10TH SFG NEWSROOM</t> <t size= '0.7' align='right'> <br/>O.R.E.O. V:0.7.2<br/> %1 <br/> %2", _ddMMyyyy, _time];
    };
    if (_uiSizeSetting isEqualTo "Medium") then {
      _textToShow = format ["<t size= '1.1' align='right'>10TH SFG NEWSROOM</t> <t size= '0.85' align='right'> <br/>O.R.E.O. V:0.7.2<br/> %1 <br/> %2", _ddMMyyyy, _time];
    };
    if (_uiSizeSetting isEqualTo "Large") then {
      _textToShow = format ["<t size= '1.3' align='right'>10TH SFG NEWSROOM</t> <t size= '1' <t size= '0.85' align='right'> <br/>O.R.E.O. V:0.7.2<br/> %1 <br/> %2", _ddMMyyyy, _time];
    };
    _displayCtrl = uiNamespace getVariable "vics_MainMenu" displayCtrl 1101;
    _displayCtrl ctrlSetStructuredText parseText _textToShow;
  };
};
