vics_country_generation = {
  _headCountries = [];
  _amountToGenerate = 25;
  _amountOfSubCountries = 30;
  for "_i" from 1 to _amountToGenerate do {
    _countryArray = [];
    _subCountryArray = [];
    //[Country name, Country Size(0-10),Country Wealth(0-10),Country Military Strength(0-10),Country type (0-6),Sub Countries array []];
    _countryName = str _i;
    _countrySize = round random 10;
    _countryWealth = round random 10;
    _countryMilStrength = round random 10;
    _countryType = round random 6;
    for "_j" from 1 to _amountOfSubCountries do {
      _random100 = random 100;
      if (_random100 <= (_countryMilStrength * 10)) then {
        _subCountryName = (str _i) + ":" + (str _j);
        _subCountrySize = round random 10;
        _subCountryWealth = round random 10;
        _subCountryMilStrength = round random 10;
        _subCountryType = round random 6;
        //[Country name, Country Size(0-10),Country Wealth(0-10),Country Military Strength(0-10),Country type (0-6),Sub Countries array [],Original Head Country Name,Current Head Country Name];
        _subCountryCreated = [_subCountryName,_subCountrySize,_subCountryWealth,_subCountryMilStrength,_subCountryType,_countryName,""];
        _subCountryArray pushBack _subCountryCreated;
      };
    };
    _countryCreated = [_countryName,_countrySize,_countryWealth,_countryMilStrength,_countryType,_subCountryArray];
    _headCountries pushBack _countryCreated;
  };
  diag_log str _headCountries;
  [_headCountries] spawn vics_country_simulate;
};

vics_country_simulate = {
 params ["_countries"];
 while {true} do {
   _milStrengthSorted = [_countries,[],{_x select 3},"DESCEND"] call bis_fnc_sortBy;
   for "_k" from 0 to 4 do {
     diag_log format ["%1: %2",(_k + 1),(_milStrengthSorted select _k select 0)];
   };
   _totalMilStrength = 0;
   _averageMilStrength = 0;
   {
     _country = _x;
     _countryMilStrength = _x select 3;
     _totalMilStrength = _totalMilStrength + _countryMilStrength;
   }forEach _countries;
   _averageMilStrength = (_totalMilStrength /(count _countries));
   {
     _country = _x;
     _countryName = _country select 0;
     _countryMilStrength = _country select 3;
     _shouldTarget = false;
     if (_countryMilStrength > _averageMilStrength) then {
       _shouldTarget = true;
     };
     if (_shouldTarget) then {
       _militaryAction = false;
       while {_militaryAction isEqualTo false} do {
         _randomCountry = selectRandom _countries;
         _randomCountryName = _randomCountry select 0;
         _randomCountryMilStrength = _randomCountry select 3;
         if !(_randomCountryName isEqualTo _countryName) then {
           if (_randomCountryMilStrength < _countryMilStrength) then {
             _targetCountryMilStrength = _countryMilStrength - _randomCountryMilStrength;
             _attackingCountryMilStrength = _countryMilStrength - (_randomCountryMilStrength / 2);
             _attackCountryIndex = _countries find _country;
             _targetCountryIndex = _countries find _randomCountry;
             _country set [3,_attackingCountryMilStrength];
             _randomCountry set [3,_targetCountryMilStrength];
             _countries set [_attackCountryIndex,_country];
             _countries set [_targetCountryIndex, _randomCountry];
             _militaryAction = true;
           };
         };
       };
     } else {
       _attackCountryIndex = _countries find _country;
       _attackingCountryMilStrength = _countryMilStrength + 1;
       _country set [3,_attackingCountryMilStrength];
       _countries set [_attackCountryIndex,_country];
     };
   }forEach _milStrengthSorted;
   uiSleep 1;
 };
};

vics_country_startWar = {
  params ["_targetCountry","_attackingCountry"];
};

vics_country_endWar = {

};

vics_country_startBattle = {

};

vics_country_endBattle = {

};
