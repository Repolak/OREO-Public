#include "TCL_Macros.hpp"

TCL_Artillery_F = [

	// ////////////////////////////////////////////////////////////////////////////
	// Artillery Function #0
	// ////////////////////////////////////////////////////////////////////////////
	// Artillery
	// By =\SNKMAN/=
	// ////////////////////////////////////////////////////////////////////////////
	{params ["_enemy","_group","_logic"];
	
	if (TCL_Feature select 9) then
	{
		if (floor (random 100) < (TCL_Feature select 10) ) then
		{
			private _condition = (_logic getVariable "TCL_Artillery");
			
			if (_condition select 0) then
			{
				private _leader = (leader _group);
				
				private _position = (getPos _logic);
				
				private _groups = (TCL_Artillery select 0);
				
				_groups = _groups select { ( (side _x getFriend side _group > 0.6) && { (_x getVariable "TCL_Artillery") } ) };
				
				if (_groups isEqualTo [] ) exitWith {};
				
				private ["_vehicle","_distance","_bool"];
				
				{_vehicle = (vehicle leader _x);
				
				_distance = [_x, _group] call (TCL_Radio_F select 0);
				
				_bool = [_vehicle, _position] call (TCL_Artillery_F select 2);
				
				if ( (_bool) && { (_distance) } ) exitWith
				{
					_condition set [0, False];
					
					_x setVariable ["TCL_Artillery", False];
					
					[_enemy, _x, _logic, _vehicle] spawn (TCL_Artillery_F select 1);
				};
				
				} count _groups;
			};
		};
	};
	
	True
	
	},
	
	// ////////////////////////////////////////////////////////////////////////////
	// Artillery Function #1
	// ////////////////////////////////////////////////////////////////////////////
	// Artillery
	// By =\SNKMAN/=
	// ////////////////////////////////////////////////////////////////////////////
	{params ["_enemy","_group","_logic","_vehicle"];
	
	private _value = [_enemy, _group, _logic] call (TCL_KnowsAbout_F select 3);
	
	sleep _value;
	
	sleep 10 + (random 30);
	
	if (alive _logic) then
	{
		private _condition = (_logic getVariable "TCL_Artillery");
		
		_condition set [1, True];
		
		private _units = (units _group);
		
		_units = _units select { ( (canFire vehicle _x) && { (_x == gunner vehicle _x) } ) };
		
		if (_units isEqualTo [] ) exitWith
		{
			_condition set [1, False];
			
			sleep 30 + (random 50);
			
			_condition set [0, True];
		};
		
		private _time = 0;
		
		private _value = (count _units);
		
		private _rounds = 7 + (random 10);
		
		_rounds = (_rounds / _value);
		
		private ["_unit","_vehicle","_position","_bool","_magazine"];
		
		private _count = 0;
		
		for "_count" from _count to (count _units - 1) do
		{
			_unit = (_units select _count);
			
			_vehicle = (vehicle _unit);
			
			_position = [ (getPos _logic select 0) + (random 70 - random 70), (getPos _logic select 1) + (random 70 - random 70), 0];
			
			// _position = [ (getPos _logic select 0) + (random 100 - random 100), (getPos _logic select 1) + (random 100 - random 100), 0];
			
			_bool = [_vehicle, _position] call (TCL_Artillery_F select 2);
			
			if (_bool) then
			{
				_magazine = (getArtilleryAmmo [_vehicle] select 0);
				
				_time = _vehicle getArtilleryETA [_position, _magazine];
				
				_vehicle doArtilleryFire [_position, _magazine, _rounds];
				
				sleep (random 3);
			};
		};
		
		if (_time > 0) then
		{
			while { (currentcommand _vehicle isEqualTo "FIRE AT POSITION") } do
			{
				sleep 5;
			};
			
			sleep _time;
			
			if (alive _logic) then
			{
				_condition set [1, False];
				
				sleep 170 + (random 150);
			};
		}
		else
		{
			_condition set [1, False];
			
			sleep 70 + (random 50);
		};
		
		if (alive _logic) then
		{
			_condition set [0, True];
		};
		
		_group setVariable ["TCL_Artillery", True];
		
		// player sideChat format ["TCL_Artillery_F > Artillery > %1", (_logic getVariable "TCL_Artillery") ];
	};
	
	},
	
	// ////////////////////////////////////////////////////////////////////////////
	// Artillery Function #2
	// ////////////////////////////////////////////////////////////////////////////
	// Artillery
	// By =\SNKMAN/=
	// ////////////////////////////////////////////////////////////////////////////
	{params ["_vehicle","_position"];
	
	private _return = False;
	
	private _gunner = (gunner _vehicle);
	
	if ( (canFire _vehicle) && { (alive _gunner) } ) then
	{
		if (getArray (configfile >> "CfgVehicles" >> (typeOf _vehicle) >> "availableForSupportTypes") select 0 isEqualTo "Artillery") then
		{
			private _magazine = (getArtilleryAmmo [_vehicle] select 0);
			
			private _range = _position inRangeOfArtillery [crew _vehicle, _magazine];
			
			if (_range) then
			{
				_return = [_vehicle, _position] call (TCL_Artillery_F select 3);
			};
		};
	};
	
	// player sideChat format ["TCL_Artillery_F > Artillery > %1 > %2", _vehicle, _return];
	
	_return
	
	},
	
	// ////////////////////////////////////////////////////////////////////////////
	// Artillery Function #3
	// ////////////////////////////////////////////////////////////////////////////
	// Artillery
	// By =\SNKMAN/=
	// ////////////////////////////////////////////////////////////////////////////
	{params ["_vehicle","_position"];
	
	private _return = True;
	
	private _distance = 100;
	
	if (_vehicle isKindOf "Tank") then
	{
		private _random = (random 100);
		
		_distance = (_distance + _random);
	};
	
	private _objects = _position nearEntities [ ["CAManBase","Car","Tank","Helicopter"], _distance];
	
	if (_objects isEqualTo [] ) exitWith {_return};
	
	private "_object";
	
	private _count = 0;
	
	for "_count" from _count to (count _objects - 1) do
	{
		_object = (_objects select _count);
		
		if ( (alive _object) && { (side _object getFriend side _vehicle > 0.6) } ) exitWith
		{
			_return = False;
			
			// player sideChat format ["TCL_Artillery_F > Artillery > %1 > %2", _object, _vehicle];
		};
	};
	
	_return
	
	}
];