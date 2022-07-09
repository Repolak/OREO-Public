TCL_Follow_F = [
	
	// ////////////////////////////////////////////////////////////////////////////
	// Follow Function #0
	// ////////////////////////////////////////////////////////////////////////////
	// Follow
	// By =\SNKMAN/=
	// ////////////////////////////////////////////////////////////////////////////
	{params ["_unit","_group"];
	
	private _leader = (leader _group);
	
	private _array = ( (TCL_Heal select 0) + (TCL_Rearm select 0) + (TCL_Take_Cover select 0) + (TCL_House_Search select 0) );
	
	if (_unit in _array) exitWith {True};
	
	// _unit doFollow _leader;
	
	True
	
	}
];