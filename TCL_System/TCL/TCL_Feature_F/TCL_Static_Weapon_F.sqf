#include "TCL_Macros.hpp"

TCL_Static_Weapon_F = [
	
	// ////////////////////////////////////////////////////////////////////////////
	// Static Weapon Function #0
	// ////////////////////////////////////////////////////////////////////////////
	// Static Weapon
	// By =\SNKMAN/=
	// ////////////////////////////////////////////////////////////////////////////
	{params ["_enemy","_group","_logic"];
	
	private _units = (units _group);
	
	private _array = ( (TCL_Static_Weapon select 0) + (TCL_House_Search select 0) );
	
	_units = _units - _array;
	
	private _leader = (leader _group);
	
	_units deleteAt (_units find _leader);
	
	_units = _units select { ( (alive _x) && { (isNull objectParent _x) } ) };
	
	if (count _units > 1) then
	{
		private _unit = _units select (count _units - 1);
		
		private _vehicle = [_unit, _group, _logic] call (TCL_Static_Weapon_F select 1);
		
		if (alive _vehicle) then
		{
			private _bool = True;
			
			if (_group in (TCL_Hold select 0) ) then
			{
				_bool = [_group, _vehicle] call TCL_Trigger_F;
			};
			
			if (_bool) then
			{
				[_unit, _group, _logic, _vehicle] spawn (TCL_Static_Weapon_F select 2);
			};
		};
	};
	
	True
	
	},
	
	// ////////////////////////////////////////////////////////////////////////////
	// Static Weapon Function #1
	// ////////////////////////////////////////////////////////////////////////////
	// Static Weapon
	// By =\SNKMAN/=
	// ////////////////////////////////////////////////////////////////////////////
	{params ["_unit","_group","_logic"];
	
	private _return = objNull;
	
	private _leader = (leader _group);
	
	private _objects = _unit nearEntities ["StaticWeapon", 100];
	
	if (_objects isEqualTo [] ) exitWith {_return};
	
	private _array = ( (TCL_Static_Weapon select 1) + (TCL_Static_Weapon select 2) );
	
	_objects = _objects - _array;
	
	_objects = _objects select { ( (alive _x) && { (someAmmo _x) } && { (_unit knowsAbout _x > 0) } && { (_x distance _leader < 100) } ) };
	
	private ["_vehicle","_side","_crew"];
	
	private _count = 0;
	
	for "_count" from _count to (count _objects - 1) do
	{
		_vehicle = (_objects select _count);
		
		_side = False;
		
		if (getNumber (configFile >> "CfgVehicles" >> (typeOf _unit) >> "side") isEqualTo getNumber (configFile >> "CfgVehicles" >> (typeOf _vehicle) >> "side") ) then
		{
			_side = True;
		};
		
		_crew = (crew _vehicle);
		
		if ( (_side) && { (_crew isEqualTo [] ) } ) exitWith
		{
			_return = _vehicle;
		};
	};
	
	_return
	
	},
	
	// ////////////////////////////////////////////////////////////////////////////
	// Static Weapon Function #2
	// ////////////////////////////////////////////////////////////////////////////
	// Static Weapon
	// By =\SNKMAN/=
	// ////////////////////////////////////////////////////////////////////////////
	{params ["_unit","_group","_logic","_vehicle"];
	
	_unit assignAsGunner _vehicle;
	
	_unit doMove (getPos _vehicle);
	
	(TCL_Static_Weapon select 0) pushBack _unit;
	
	(TCL_Static_Weapon select 1) pushBack _vehicle;
	
	[_unit] orderGetIn True; [_unit] allowGetIn True;
	
	// player sideChat format ["TCL_Static_Weapon_F > Vehicle > %1", _vehicle];
	
	private _time = (time + 30);
	
	private _distance = (_unit distance _vehicle);
	
	_time = (_time + _distance);
	
	while { ( (alive _unit) && { (time < _time) } && { (isNull objectParent _unit) } ) } do
	{
		sleep 5;
	};
	
	if ( (alive _unit) && { (time < _time) } && { (_unit == gunner _vehicle) } ) then
	{
		[_unit, _group, _vehicle] spawn (TCL_Static_Weapon_F select 3);
	}
	else
	{
		TCL_DeleteAT(TCL_Static_Weapon,0,_unit);
		
		TCL_DeleteAT(TCL_Static_Weapon,1,_vehicle);
		
		_unit leaveVehicle _vehicle; [_unit] orderGetIn False; [_unit] allowGetIn False;
	};
	
	},
	
	// ////////////////////////////////////////////////////////////////////////////
	// Static Weapon Function #3
	// ////////////////////////////////////////////////////////////////////////////
	// Static Weapon
	// By =\SNKMAN/=
	// ////////////////////////////////////////////////////////////////////////////
	{params ["_unit","_group","_vehicle"];
	
	private _bool = True;
	
	private _missile = False;
	
	private _units = (units _group);
	
	private ["_leader","_weapon","_enemy"];
	
	if (getArray (configfile >> "CfgVehicles" >> (typeOf _vehicle) >> "availableForSupportTypes") isEqualTo [] ) then
	{
		_bool = False;
		
		private _weapons = (weapons _vehicle);
		
		private _magazines = getArray (configfile >> "CfgWeapons" >> (_weapons select 0) >> "magazines");
		
		private _magazine = (_magazines select 0);
		
		private _ammo = getText (configfile >> "CfgMagazines" >> _magazine >> "ammo");
		
		if (_ammo isKindOf "MissileBase") then
		{
			_missile = True;
		};
	};
	
	while { ( (alive _unit) && { (_unit == gunner _vehicle) } ) } do
	{
		_leader = (leader _group);
		
		if ( (canFire _vehicle) && { (someAmmo _vehicle) } ) then
		{
			if (_bool) then
			{
				if (_vehicle in (TCL_Static_Weapon select 2) ) exitWith {};
				
				[_unit, _group, _vehicle] spawn (TCL_Mortar_F select 0);
			}
			else
			{
				if (_missile) then
				{
					// _weapon = (weapons _vehicle select 0);
					
					// _enemy = (_group getVariable "TCL_Enemy");
					
					// _vehicle fireAtTarget [_enemy, _weapon];
					
					// player sideChat format ["TCL_Static_Weapon_F > Missile > %1 > %2", _unit, _weapon];
				};
			};
		}
		else
		{
			_unit leaveVehicle _vehicle; [_unit] orderGetIn False; [_unit] allowGetIn False;
		};
		
		_enemy = (_group getVariable "TCL_Enemy");
		
		if (_unit distance _enemy < 10) then
		{
			[_unit, _group, _vehicle] call (TCL_Static_Weapon_F select 4);
		};
		
		if (_group in (TCL_Reinforcement select 2) ) then
		{
			[_unit, _group, _vehicle] call (TCL_Static_Weapon_F select 4);
		};
		
		_group = (group _unit);
		
		_waypoint = (_group getVariable "TCL_Waypoint");
		
		if (_unit distance _waypoint > 500) then
		{
			if (behaviour _leader isEqualTo "COMBAT") then
			{
				[_unit, _group, _vehicle] call (TCL_Static_Weapon_F select 4);
			};
		};
		
		sleep 5;
	};
	
	if (_unit == gunner _vehicle) then
	{
		_unit leaveVehicle _vehicle; [_unit] orderGetIn False; [_unit] allowGetIn False;
	};
	
	TCL_DeleteAT(TCL_Static_Weapon,0,_unit);
	
	sleep 10 + (random 30);
	
	TCL_DeleteAT(TCL_Static_Weapon,1,_vehicle);
	
	},
	
	// ////////////////////////////////////////////////////////////////////////////
	// Static Weapon Function #4
	// ////////////////////////////////////////////////////////////////////////////
	// Static Weapon
	// By =\SNKMAN/=
	// ////////////////////////////////////////////////////////////////////////////
	{params ["_unit","_group","_vehicle"];
	
	if (_group in (TCL_Artillery select 0) ) exitWith {};
	
	_unit leaveVehicle _vehicle; [_unit] orderGetIn False; [_unit] allowGetIn False;
	
	True
	
	}
];