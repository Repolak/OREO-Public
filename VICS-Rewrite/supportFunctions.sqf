vics_sup_transportRequest = {
  onMapSingleClick "[_this,_pos,_shift,_alt] call vics_sup_transportOrder; true;";
};

vics_sup_hoverRequest = {
  onMapSingleClick "[_this,_pos,_shift,_alt] call vics_sup_hoverOrder; true;";
};

vics_sup_transportOrder = {
  [_this,_pos,_shift,_alt] spawn {
    params [];
    _veh = (vehicle player);
    _veh doMove (_this select 1);
    _landingPad = "Land_HelipadEmpty_F" createVehicle (_this select 1);
    while { ( (alive _veh) && !(unitReady _veh) ) } do
    {
         sleep 1;
    };

    if (alive _veh) then
      {
         _veh land "LAND";
       };
    onMapSingleClick "";
  };
};

vics_sup_hoverOrder = {
  [_this,_pos,_shift,_alt] spawn {
    params [];
    _veh = (vehicle player);
    _veh doMove (_this select 1);
    while { ( (alive _veh) && !(unitReady _veh) ) } do
    {
         sleep 1;
    };

    if (alive _veh) then
      {
        uiSleep 7;
         _veh flyInHeight 10;
       };
    onMapSingleClick "";
  };
};


vics_sup_boatSpawn = {
  params ["_vehicle"];
  _pos = getPos boatSpawn;
  _veh = _vehicle createVehicle _pos;
};

vics_support_supplyRequest = {
  params ["_position","_suppliesName",["_dateOfOrder",nil],["_deliveryType",0],["_delay",0]];
  _shippingQueue = profileNameSpace getVariable [(missionPrefix + "shippingQueue"),[]];
  _dateOfOrder = systemTime;
  _shippingOrder = [_position,_suppliesName,_dateOfOrder,_deliveryType,_delay];
  _shippingQueue pushBack _shippingOrder;
  profileNameSpace getVariable [(missionPrefix + "shippingQueue"),_shippingQueue];
};

vics_support_supplyfufill = {
  params ["_shippingOrder"];
  _commandCredits = profileNameSpace getVariable [(missionPrefix + "commandCredits"),0];
  _medicalSupplyCrate = [
    [
      ["ACE_fieldDressing",250],
      ["ACE_adenosine",40],
      ["kat_aatKit",50],
      ["ACE_quikclot",100],
      ["ACE_elasticBandage",100],
      ["ACE_epinephrine",40],
      ["kat_larynx",70],
      ["ACE_morphine",40],
      ["kat_pulseoximeter",70],
      ["ACE_salineIV",40],
      ["ACE_salineIV_250",40],
      ["ACE_salineIV_500",40],
      ["ACE_splint",50],
      ["ACE_tourniquet",40]
    ],
    [

    ],
    [

    ],
    [

    ],
    "Box_NATO_Ammo_F"
  ];
  _position = _shippingOrder select 0;
  _suppliesName = _shippingOrder select 1;
  _deliveryType = _shippingOrder select 3;
  _positionToSpawn = _position;
  //Check if position is a marker
  if (typename _position isEqualTo "STRING") then {
    _positionToSpawn = getMarkerPos _position;
  };
  _suppliesName = toUpper _suppliesName;
  _chosenCrate = nil;
  //Select appropriate crate
  switch (_suppliesName) do {
    case "MEDICALSUPPLIES": {_chosenCrate = [_medicalSupplyCrate,0,0]};
    default {_chosenCrate = [_medicalSupplyCrate,5,3]};
  };
  _chosenCrate;
  //Items in crate
  _crateInfo = _chosenCrate select 0;
  //cost of points to make crate
  _crateCost = _chosenCrate select 1;
  //default time for arrival (days IRL)
  _crateTime = _chosenCrate select 2;
  //Crate to spawn classname
  _crateClassname = _crateInfo select 4;
  //Crate Created
  diag_log str _shippingOrder;
  systemChat format ["%1 %2",_commandCredits, _crateCost];
  if (_commandCredits >= _crateCost) then {
    _crateCreated = createVehicle [_crateClassname,_positionToSpawn,[],3,"NONE"];
    clearItemCargoGlobal _crateCreated;
    clearWeaponCargoGlobal _crateCreated;
    clearBackpackCargoGlobal _crateCreated;
    clearMagazineCargoGlobal _crateCreated;
    _crateCreated allowDamage false;
    _crateCreated enableSimulationGlobal false;


    //Adding Items to Crate;
    _itemsToAdd = _crateInfo select 0;
    _magazinesToAdd = _crateInfo select 1;
    _weaponsToAdd = _crateInfo select 2;
    _backpacksToAdd = _crateInfo select 3;
    //Item add loop
    {
      _crateCreated addItemCargoGlobal _x;
    }forEach _itemsToAdd;
    //Magazine add loop
    {
      _crateCreated addMagazineCargoGlobal _x;
    }forEach _magazinesToAdd;
    //Weapon add loop
    {
      _crateCreated addWeaponCargoGlobal _x;
    }forEach _weaponsToAdd;
    //Backpack add loop
    {
      _crateCreated addBackpackCargoGlobal _x;
    }forEach _backpacksToAdd;
    ["Supplies delivered."] remoteExec ["systemChat",0];
    //Removing cost from command points pool
    _commandCredits = _commandCredits - _crateCost;
    profileNameSpace setVariable [(missionPrefix + "commandCredits"),_commandCredits];

    //Determining shipping time

    //Adding to shipping queue
  } else {
    systemChat "An order was denied by command.";
  };
};

vics_support_creditChange = {
  params ["_valueToChange"];
  _commandCredits = profileNameSpace getVariable [(missionPrefix + "commandCredits"),0];
  _commandCredits = _commandCredits + _valueToChange;
  profileNameSpace setVariable [(missionPrefix + "commandCredits"),_commandCredits];
};

vics_support_creditEarn = {

};

vics_support_processShipping = {
  _shippingQueue = profileNameSpace getVariable [(missionPrefix + "shippingQueue"),[]];
  _shippingQueueUpdated = [];
  {
    _shippingOrder = _x;
    _shippingDate = _shippingOrder select 2;
    _shippingDelay = _shippingOrder select 4;
    _daysCount = [_shippingDate,systemTime] call vics_sys_countTime;
    if (_daysCount >= _shippingDelay) then {
      [_shippingOrder] call vics_support_supplyfufill;
    } else {
      _shippingQueueUpdated pushBack _shippingOrder;
    };
  }forEach _shippingQueue;
  profileNameSpace setVariable [(missionPrefix + "shippingQueue"),_shippingQueueUpdated];
};

vics_support_creditCheck = {
  params ["_unit"];
  _commandCredits = profileNameSpace getVariable [(missionPrefix + "commandCredits"),0];
  _response = "Unavailable at this time.";
  if (_commandCredits < 30) then {
    _response = "Command is unhappy and is looking to close operations in the region if things don't approve.";
  } else {
    if (_commandCredits >= 30) then {
      _response = "Command is unsatisfied with the current status of the mission and will be pulling assets if it remains static.";
    } else {
      if (_commandCredits >= 60) then {
        _response = "Command finds the current operation status acceptable and plans to continue supporting operations in the region.";
      } else {
        if (_commandCredits >= 100) then {
          _response = "Command is very happy with the current operation status and has decided to dedicate more assets to the mission at hand.";
        };
      };
    };
  };
  [_response] remoteExec ["systemChat",_unit];
};
