execVM "VICS-Rewrite\systemFunctions.sqf";
vicsConfigComplete = execVM "VICS-Rewrite\missionConfiguration.sqf";
publicVariable "vicsConfigComplete";
execVM "VICS-Rewrite\ObjectiveFunctions.sqf";
execVM "VICS-Rewrite\enemyFunctions.sqf";
execVM "VICS-Rewrite\economyFunctions.sqf";
execVM "VICS-Rewrite\supportFunctions.sqf";
execVM "VICS-Rewrite\loopFunctions.sqf";
execVM "VICS-Rewrite\taskingFunctions.sqf";
execVM "VICS-Rewrite\dialogFunctions.sqf";
execVM "VICS-Rewrite\hvtFunctions.sqf";
execVM "VICS-Rewrite\intelFunctions.sqf";
execVM "VICS-Rewrite\civilianFunctions.sqf";
execVM "VICS-Rewrite\pmcFunctions.sqf";
execVM "VICS-Rewrite\buildingFunctions.sqf";
execVM "VICS-Rewrite\IEDFunctions.sqf";
execVM "VICS-Rewrite\countryFunctions.sqf";
//initilization of gamemode
