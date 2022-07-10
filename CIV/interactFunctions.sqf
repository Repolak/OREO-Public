civNoNeutralResponses = ["I would rather not tell you.","I am not sure I am comfortable answering.","Please do not ask me that."];
civNoScaredResponses = ["I do not think I should be speaking to you.","I think you should leave.","You should go."];
civ_fnc_ConversationStart = {
  params ["_targetCiv","_interactor"];
  _dirPlayer = getDir _interactor;
  _targetCiv setFormDir (_dirPlayer - 180);
  _targetCiv disableAI "PATH";
  _targetCiv disableAI "MOVE";
};

civ_fnc_ConversationEnd = {
  params ["_targetCiv"];
  _targetCiv enableAI "MOVE";
  _targetCiv enableAI "PATH";
};

civ_fnc_InteractQuestionsPop = {
  params ["_category"];
  _greetings = [9101,9102,9103,9104,9105,9106,9107,9108,9109,9110,9111,9112,9113,9114];
  _questions = [9201,9202,9203,9204,9205,9206,9207,9208,9209,9210,9211,9212,9213,9214];
  _hostileQuestions = [9301,9302,9303,9304,9305,9306,9307,9308,9309,9310,9311,9312,9313,9314];
  _civilianQuestions = [9401,9402,9403,9404,9405,9406,9407,9408,9409,9410,9411,9412,9413,9414];
  _civActions = [9601,9602,9603,9604,9605,9606,9607,9608,9609,9610,9611,9612,9613,9614];
  _allChildOptions = [9101,9102,9103,9104,9105,9106,9107,9108,9109,9110,9111,9112,9113,9114,9201,9202,9203,9204,9205,9206,9207,9208,9209,9210,9211,9212,9213,9214,9301,9302,9303,9304,9305,9306,9307,9308,9309,9310,9311,9312,9313,9314,9401,9402,9403,9404,9405,9406,9407,9408,9409,9410,9411,9412,9413,9414,9601,9602,9603,9604,9605,9606,9607,9608,9609,9610,9611,9612,9613,9614];
  if (_category == "greetings") then {
    {
      ctrlShow [_x, false];
    } forEach _allChildOptions;
    {
      ctrlShow [_x, true];
    } forEach _greetings;
  };
  if (_category == "questions") then {
    {
      ctrlShow [_x, false];
    } forEach _allChildOptions;
    {
      ctrlShow [_x, true];
    } forEach _questions;
  };
  if (_category == "actions") then {
    {
      ctrlShow [_x, false];
    } forEach _allChildOptions;
    {
      ctrlShow [_x, true];
    } forEach _civActions;
  };
  if (_category == "hostile") then {
    {
      ctrlShow [_x, false];
    } forEach _allChildOptions;
    {
      ctrlShow [_x, true];
    } forEach _hostileQuestions;
  };
  if (_category == "civilian") then {
    {
      ctrlShow [_x, false];
    } forEach _allChildOptions;
    {
      ctrlShow [_x, true];
    } forEach _civilianQuestions;
  };
  if (_category == "all") then {
    [] call civ_fnc_questionWipe;
  };
};


civ_fnc_questionWipe = {
  [] spawn {
    _allChildOptions = [9101,9102,9103,9104,9105,9106,9107,9108,9109,9110,9111,9112,9113,9114,9201,9202,9203,9204,9205,9206,9207,9208,9209,9210,9211,9212,9213,9214,9301,9302,9303,9304,9305,9306,9307,9308,9309,9310,9311,9312,9313,9314,9401,9402,9403,9404,9405,9406,9407,9408,9409,9410,9411,9412,9413,9414,9601,9602,9603,9604,9605,9606,9607,9608,9609,9610,9611,9612,9613,9614];
    {
        ctrlShow [_x, false];
    } forEach _allChildOptions;
  };
};


civ_fnc_GreetingsFriendly = {
  _playerLanguages = player getVariable ["spokenLanguages",[]];
  _civLanguages = target getVariable ["spokenLanguages",["Arabic"]];
  _canSpeak = false;
  {
    if (_x in _civLanguages) then {
      _canSpeak = true;
    };
  }forEach _playerLanguages;
  if (_canSpeak) then {
    _opforMoraleClient = missionNameSpace getVariable "opforMoraleClient";
    _civMoraleClient = target getVariable "objHostility";
    _civMoraleClient = 100 - _civMoraleClient;
    diag_log format ["%1 %2",_civMoraleClient,_opforMoraleClient];
    _target = target;
    _civPos = getPos _target;
    _enemySides = [side player] call BIS_fnc_enemySides;
    _radius = 1000;
    _nearEnemies = allUnits select {_x distance _target < _radius AND side _x in _enemySides};
    _enemyCount = count _nearEnemies;
    //systemChat format ["Civ - morale - %1",civMorale];
    if (_civMoraleClient >= 0) then {
      systemChat "Hello.";
    } else {
      if (_enemyCount == 0) then {
        systemChat "Go away.";
      };
      if ((_enemyCount > 0) && (_enemyCount <= 4)) then {
        _response = selectRandom civNoNeutralResponses;
        systemChat "Go away now.";
      };
      if ((_enemyCount > 4) && (_enemyCount <= 8)) then {
        systemChat "Get out of here.";
      };
      if (_enemyCount > 8) then {
        _response = selectRandom civNoScaredResponses;
        systemChat "leave quickly.";
      };
    };
  } else {
    systemChat "You don't speak the language";
  };
};

civ_fnc_GreetingsHostile = {
  _playerLanguages = player getVariable ["spokenLanguages",[]];
  _civLanguages = target getVariable ["spokenLanguages",["Arabic"]];
  _canSpeak = false;
  {
    if (_x in _civLanguages) then {
      _canSpeak = true;
    };
  }forEach _playerLanguages;
  if (_canSpeak) then {
    _opforMoraleClient = missionNameSpace getVariable "opforMoraleClient";
    _civMoraleClient = target getVariable "objHostility";
    _civMoraleClient = 100 - _civMoraleClient;
    _target = target;
    _civPos = getPos _target;
    _enemySides = [side player] call BIS_fnc_enemySides;
    _radius = 1000;
    _nearEnemies = allUnits select {_x distance _target < _radius AND side _x in _enemySides};
    _enemyCount = count _nearEnemies;
    _randomMorale = random [-2,0,2];
    //systemChat format ["Civ - morale - %1",civMorale];
    publicVariable "civMorale";
    if (_civMoraleClient >= 0) then {
      systemChat "As-salamu alaykum";
    } else {
      if (_enemyCount == 0) then {
        systemChat "Go away.";
      };
      if ((_enemyCount > 0) && (_enemyCount <= 4)) then {
        _response = selectRandom civNoNeutralResponses;
        systemChat "Go away now.";
      };
      if ((_enemyCount > 4) && (_enemyCount <= 8)) then {
        systemChat "Get out of here.";
      };
      if (_enemyCount > 8) then {
        _response = selectRandom civNoScaredResponses;
        systemChat "leave quickly.";
      };
    };
  } else {
    systemChat "You don't speak the language";
  };
};

civ_fnc_infoName = {
  _playerLanguages = player getVariable ["spokenLanguages",[]];
  _civLanguages = target getVariable ["spokenLanguages",["Arabic"]];
  _canSpeak = false;
  {
    if (_x in _civLanguages) then {
      _canSpeak = true;
    };
  }forEach _playerLanguages;
  if (_canSpeak) then {
    _opforMoraleClient = missionNameSpace getVariable "opforMoraleClient";
    _civMoraleClient = target getVariable "objHostility";
    _civMoraleClient = 100 - _civMoraleClient;
    _target = target;
    _civPos = getPos _target;
    _enemySides = [side player] call BIS_fnc_enemySides;
    _radius = 1000;
    _nearEnemies = allUnits select {_x distance _target < _radius AND side _x in _enemySides};
    _enemyCount = count _nearEnemies;
    _randomMorale = random [-2,0,2];
    //systemChat format ["Civ - morale - %1",civMorale];
    //publicVariable "civMorale";
    if (_civMoraleClient >= 0) then {
      _name = [_target] call ace_common_fnc_getName;
      systemChat format ["My name is %1",_name];
    } else {
      if (_enemyCount == 0) then {
        _response = selectRandom civNoNeutralResponses;
        systemChat format ["%1",_response];
      };
      if ((_enemyCount > 0) && (_enemyCount <= 4)) then {
        _response = selectRandom civNoNeutralResponses;
        systemChat format ["%1",_response];
      };
      if ((_enemyCount > 4) && (_enemyCount <= 8)) then {
        _response = selectRandom civNoScaredResponses;
        systemChat format ["%1",_response];
      };
      if (_enemyCount > 8) then {
        _response = selectRandom civNoScaredResponses;
        systemChat format ["%1",_response];
      };
    };
  } else {
    systemChat "You don't speak the language";
  };
};

civ_fnc_infoAge = {
  _playerLanguages = player getVariable ["spokenLanguages",[]];
  _civLanguages = target getVariable ["spokenLanguages",["Arabic"]];
  _canSpeak = false;
  {
    if (_x in _civLanguages) then {
      _canSpeak = true;
    };
  }forEach _playerLanguages;
  if (_canSpeak) then {
    _age = target getVariable "targetAge";
    if (isNil "_age") then {
      _age =  round random [29,43,86];
      target setVariable ["targetAge",_age];
    };
    _age;
    systemChat format ["I am %1 years old.",_age];
  } else {
    systemChat "You don't speak the language";
  };
};

civ_fnc_QuestionHostileArea = {
  _target = target;
  _safeResponses = ["I think we are safe.","We are probably fine.","There's nothing here for you.","Might as well leave,","Stop bothering us.","Leave here.","You'll pay for being here.","These are our homes."];
 _lowResponses = ["We don't need you.","Stay away from us.","You will only bring death to our homes.","We need help.","Protect us.","You won't get hurt.","These are our homes."];
 _medResponses = ["There's nothing to worry about.","We are probably fine","I think we are safe.","Stay away.","You aren't the only one with soldiers.","You will be punished for being here.","nothing to worry about.","These are our homes."];
 _highResponses = ["there's nothing here.","We are all friends here.","Turn back now.","Get out of here.","Help us.","Hide quickly.","You will die today."];
 _playerLanguages = player getVariable ["spokenLanguages",[]];
 _civLanguages = target getVariable ["spokenLanguages",["Arabic"]];
 _canSpeak = false;
 {
   if (_x in _civLanguages) then {
     _canSpeak = true;
   };
 }forEach _playerLanguages;
 if (_canSpeak) then {
    _opforMoraleClient = missionNameSpace getVariable "opforMoraleClient";
    _civMoraleClient = target getVariable "objHostility";
    _civMoraleClient = 100 - _civMoraleClient;
    _civPos = getPos _target;
    _enemySides = [side player] call BIS_fnc_enemySides;
    _radius = 1000;
    _nearEnemies = allUnits select {_x distance _target < _radius AND side _x in _enemySides};
    _enemyCount = count _nearEnemies;
    if (_enemyCount == 0) then {
      _response = selectRandom _safeResponses;
      systemChat _response;
    };
    if ((_enemyCount > 0) && (_enemyCount <= 4)) then {
      _response = selectRandom _lowResponses;
      systemChat _response;
    };
    if ((_enemyCount > 4) && (_enemyCount <= 8)) then {
      _response = selectRandom _medResponses;
      systemChat _response;
    };
    if (_enemyCount > 8) then {
      _response = selectRandom _highResponses;
      systemChat _response;
    };
    //systemChat format ["%1",_enemyCount];
  } else {
    systemChat "You don't speak the language.";
  };
};

civ_fnc_questionCivilianHostility = {
  _playerLanguages = player getVariable ["spokenLanguages",[]];
  _civLanguages = target getVariable ["spokenLanguages",["Arabic"]];
  _canSpeak = false;
  {
    if (_x in _civLanguages) then {
      _canSpeak = true;
    };
  }forEach _playerLanguages;
  if (_canSpeak) then {
    _opforMoraleClient = missionNameSpace getVariable "opforMoraleClient";
    _civMoraleClient = target getVariable "objHostility";
    _civMoraleClient = 100 - _civMoraleClient;
    _target = target;
    _civPos = getPos _target;
    _enemySides = [side player] call BIS_fnc_enemySides;
    _radius = 1000;
    _nearEnemies = allUnits select {_x distance _target < _radius AND side _x in _enemySides};
    _enemyCount = count _nearEnemies;
    _hostileModifier = _opforMoraleClient;
    If (_enemyCount < 4) then {
      _hostileModifier = (_opforMoraleClient / 2);
    } else {
      _hostileModifier = _opforMoraleClient;
    };
    if (_civMoraleClient > _hostileModifier) then {
      systemChat format ["Civilian Freindliness: %1",_civMoraleClient];
    } else {
      if (_enemyCount == 0) then {
        _response = selectRandom civNoNeutralResponses;
        systemChat format ["%1",_response];
      };
      if ((_enemyCount > 0) && (_enemyCount <= 4)) then {
        _response = selectRandom civNoNeutralResponses;
        systemChat format ["%1",_response];
      };
      if ((_enemyCount > 4) && (_enemyCount <= 8)) then {
        _response = selectRandom civNoScaredResponses;
        systemChat format ["%1",_response];
      };
      if (_enemyCount > 8) then {
        _response = selectRandom civNoScaredResponses;
        systemChat format ["%1",_response];
      };
    };
  } else {
    systemChat "You don't speak the language";
  };
};

civ_fnc_missionCheck = {
  _playerLanguages = player getVariable ["spokenLanguages",[]];
  _civLanguages = target getVariable ["spokenLanguages",["Arabic"]];
  _canSpeak = false;
  {
    if (_x in _civLanguages) then {
      _canSpeak = true;
    };
  }forEach _playerLanguages;
  if (_canSpeak) then {
    _opforMoraleClient = missionNameSpace getVariable "opforMoraleClient";
    _civMoraleClient = target getVariable "objHostility";
    _civMoraleClient = 100 - _civMoraleClient;
    _target = target;
    _civPos = getPos _target;
    _enemySides = [side player] call BIS_fnc_enemySides;
    _radius = 1000;
    _nearEnemies = allUnits select {_x distance _target < _radius AND side _x in _enemySides};
    _enemyCount = count _nearEnemies;
    //systemChat format ["Civ - morale - %1",civMorale];
    _hostileModifier = _opforMoraleClient;
    If (_enemyCount < 4) then {
      _hostileModifier = (_opforMoraleClient / 2);
    } else {
      _hostileModifier = _opforMoraleClient;
    };
    if (_civMoraleClient > 0) then {
      //[] remoteExec ["vics_fnc_missionRequest",2];
    } else {
      if (_enemyCount == 0) then {
        _response = selectRandom civNoNeutralResponses;
        systemChat format ["%1",_response];
      };
      if ((_enemyCount > 0) && (_enemyCount <= 4)) then {
        _response = selectRandom civNoNeutralResponses;
        systemChat format ["%1",_response];
      };
      if ((_enemyCount > 4) && (_enemyCount <= 8)) then {
        _response = selectRandom civNoScaredResponses;
        systemChat format ["%1",_response];
      };
      if (_enemyCount > 8) then {
        _response = selectRandom civNoScaredResponses;
        systemChat format ["%1",_response];
      };
    };
  } else {
    systemChat "You don't speak the language";
  };
};

civ_fnc_ActionHeadbag = {
  _playerInventory = items player;

  _target = target;
  _headgear = headgear _target;
  if (_headgear == "mgsr_headbag") then {
    removeHeadgear _target;
    removeGoggles _target;
    player addItem "mgsr_headbag";
  } else {
    if ("mgsr_headbag" in _playerInventory) then {
      removeHeadgear _target;
      _target addHeadgear "mgsr_headbag";
      removeGoggles _target;
      player removeItem "mgsr_headbag";
    } else {
      systemChat "You don't have a headbag";
    };
  };
};

civ_fnc_handWater = {
  _playerInventory = items player;
  _target = target;
  if ("ACE_WaterBottle" in _playerInventory) then {
    player removeItem "ACE_WaterBottle";
    _randomAddVal = random [0.25,0.5,0.75];
    [_randomAddVal,0] remoteExec ["vics_econ_civMoraleAdjust",2];
    systemChat "Thank you";
  } else {
    systemChat "You do not have any water to give.";
  };
};

civ_fnc_handRation = {
  _playerInventory = items player;
  _target = target;
  if ("ACE_Humanitarian_Ration" in _playerInventory) then {
    player removeItem "ACE_Humanitarian_Ration";
    _randomAddVal = random [0.25,0.5,0.75];
    [_randomAddVal,0] remoteExec ["vics_econ_civMoraleAdjust",2];
    systemChat "Thank you";
  } else {
    systemChat "You do not have any rations to give.";
  };
};

civ_fnc_handMoney = {
  _playerInventory = items player;
  _target = target;
  if ("UMI_Briefcase_Money_Open" in _playerInventory) then {
    player removeItem "UMI_Briefcase_Money_Open";
    _randomAddVal = random [25,50,75];
    [_randomAddVal,0] remoteExec ["vics_econ_civMoraleAdjust",2];
    systemChat "Thank you";
  } else {
    systemChat "You do not have any money to give.";
  };
};

civ_fnc_textPeople = {
  /*
  _people = ["Fred Drake", "Fredrick Elignore", "Fred Capt"];
  _textInput = toUpper ctrlText 1400;
  _textInput =
  */
};

civ_fnc_chatTest = {
  _text3 = ctrlText 1102;
  _text2 = ctrlText 1101;
  _text1 = ctrlText 1100;
  _userText = ctrlText 1400;

  if ((_userText == "Carter Church")) then {
    if !(_text3 isEqualTo "") then {
      ctrlSetText [1100,_text2];
      ctrlSetText [1101,_text3];
      ctrlSetText [1102,"Oh yeah, that boi who be rappin? Im a big fan!"];
    } else {
      ctrlSetText [1102,"Oh yeah, that boi who be rappin? Im a big fan!"];
    };
  } else {
    ctrlSetText [1100,_text2];
    ctrlSetText [1101,_text3];
    ctrlSetText [1102,_userText];
  };
};

civ_fnc_textCycle = {
  params ["_newText"];
};
