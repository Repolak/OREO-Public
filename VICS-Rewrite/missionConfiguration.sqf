
//   __      ___      _               _   _____        __            _                 _____                _           _      _____           _
//   \ \    / (_)    | |             | | |_   _|      / _|          | |               / ____|              | |         | |    / ____|         | |
//    \ \  / / _ _ __| |_ _   _  __ _| |   | |  _ __ | |_ __ _ _ __ | |_ _ __ _   _  | |     ___  _ __ ___ | |__   __ _| |_  | (___  _   _ ___| |_ ___ _ __ ___
//     \ \/ / | | '__| __| | | |/ _` | |   | | | '_ \|  _/ _` | '_ \| __| '__| | | | | |    / _ \| '_ ` _ \| '_ \ / _` | __|  \___ \| | | / __| __/ _ \ '_ ` _ \
//      \  /  | | |  | |_| |_| | (_| | |  _| |_| | | | || (_| | | | | |_| |  | |_| | | |___| (_) | | | | | | |_) | (_| | |_   ____) | |_| \__ \ ||  __/ | | | | |
//       \/   |_|_|   \__|\__,_|\__,_|_| |_____|_| |_|_| \__,_|_| |_|\__|_|   \__, |  \_____\___/|_| |_| |_|_.__/ \__,_|\__| |_____/ \__, |___/\__\___|_| |_| |_|
//                                                                             __/ |                                                  __/ |
//                                                                            |___/                                                  |___/

////////////////////
// VICS OPTIONS ///
//////////////////

//
// SYSTEM OPTIONS
//

// to load the system or not on mission start, mainly for development
runOnLoad = true;
publicVariableServer "runOnLoad";

// Length of core gameplay loop (Probably shouldnt change...ever)
cycleMultiplier = 10;
publicVariableServer "cycleMultiplier";

// Auto save time in 10 minute intervals
autoSaveTime = 12;
publicVariableServer "autoSaveTime";

// How many bodies before the cleanup will run
cleanupDead = 5;
publicVariableServer "cleanupDead";

// Distance away from players the body has to be to be deleted
cleanupDistance = 700;
publicVariableServer "cleanupDistance";

// How many 10 minute intervals before cleanup check.
cleanupTime = 2;
publicVariableServer "cleanupTime";

//Should system cleanup west bodies or not? (Useful if you need to recover gear from them later).
cleanupFriendlies = false;
publicVariableServer "cleanupFriendlies";

//A system for spawning in units at a smoother rate to help eliviate lag and desync
smoothSpawn = 0.3;
publicVariableServer "smoothSpawn";

//Admin UIDs for the admin menu. Also uses the logged admin in the server.
adminUIDs = ["_SP_PLAYER_","76561198053836830","76561198053920264"];
publicVariable "adminUIDs";

//
// DEBUG OPTIONS
//

debugMsg = false;
publicVariableServer "debugMsg";

debugMrk = false;
publicVariableServer "debugMrk";

debugObjRunning = false;
debugObjOccupied = false;
debugObjWeight = false;



//
// OBJECTIVE OPTIONS
//

// Objectives Filter
objectivesToCreate = ["tiny","small","medium","large","huge"];
publicVariableServer "objectivesToCreate";

// The size of objectives ^2
objectiveSizeMultiplier = 750;
publicVariableServer "objectiveSizeMultiplier";

/*
size 1000 = 88 OBJs Chernarus, full clipping
size 750 = 131 OBJs Chernarus, major clipping
size 500 = 191 OBJs Chernarus, minor clipping into Blacklist areas
size 250 = 344 OBJs Chernarus, no clipping
Testing 500 for performance reasons
*/


// Objective degrade value per tick
objDegradeRate = 1;
publicVariableServer "objDegradeRate";

// Health points for objectives
objCapturedTicks = 720;
publicVariableServer "objCapturedTicks";

// Blacklist marker names to prevent any VICS behavior from utilizing that area.
objectiveOffwhiteList = ["blufor_1"];
publicVariableServer "objectiveOffwhiteList";

//Marker names that shouldnt spawn anything but should be objectives for AI
objectiveSpawnBlacklist = [];
publicVariableServer "objectiveSpawnBlacklist";

//Marker names that shouldnt spawn Civilian AI
civilianSpawnBlacklist = [];
publicVariableServer "civilianSpawnBlacklist";

//Hotzones are manually placed markers that tell the AI commander how imporant these zones are. Useful for rural areas and military bases.
hotZones = [];
publicVariableServer "hotZones";

//Alert zones have a chance of alerting blufor players if enemies have taken an area
alertZones = [];
publicVariableServer "alertZones";

//Chance that Objective is assigned to OPFOR on generation. Useful for occupied deployments.
opforOwnershipChance = 100;
publicVariableServer "opforOwnershipChance";

//
// Insurgency OPTIONS
//

//Toggle Insurgency features
insurgencyMode = false;
publicVariableServer "insurgencyMode";

civConvertMin = 1;
publicVariableServer "civConvertMin";

civConvertMax = 1;
publicVariableServer "civConvertMax";

civConvertSimple = true;
publicVariableServer "civConvertSimple";

civConvertChance = 5;
publicVariableServer "civConvertChance";

//Chance that civilian is a spotter
civSpotterChance = 5;
publicVariableServer "civSpotterChance";

//
// FOB OPTIONS
//

// Higher value means more fobs/longer deployment
fobsToCreate = 14;
publicVariableServer "fobCreationMultiplier";

// Min distance between FOBs
fobDistance = 400;
publicVariableServer "fobDistance";



//
// SIMULATED GROUP OPTIONS
//

// A hard cap for ai spawned, higher is more ai
aiLimitMultiplier = 1;
publicVariableServer "aiLimitMultiplier";

maxGroups = 30;
publicVariableServer "maxGroups";

//max groups per objective
forcePoolMultipler = 2;
publicVariableServer "forcePoolMultipler";

//Higher means more groups created per cycle
groupCycleMultiplier = 1;
publicVariableServer "groupCycleMultiplier";


//Health points for group tasking
groupTaskingTicks = 9;
publicVariableServer "groupTaskingTicks";



//
// CQB OPTIONS
//

//values for how many buildings per objective selected to spawn cqb ai [min,mid,max]
cqbValues = [0,3,7];
publicVariableServer "cqbValues";

//The distance that CQB units will appear
cqbDistance = 1100;
publicVariableServer "cqbDistance";

//Minimum distance away from players needed to spawn CQB units
cqbDistanceMinimum = 600;
publicVariableServer "cqbDistanceMinimum";

//Chance CQB units will be unable to move from their position. (Useful for keeping them from running out on players always.)
cqbHoldChance = 90;
publicVariableServer "cqbHoldChance";



//
// ECONOMY OPTIONS
//

//Funding level, multiplier that affects starting balance and income generated per loop. higher = more money (1-10)
opforFundingLevel = 10;
publicVariableServer "fundingLevel";

//Production Time in 10 minute intervals
productionTime = 6;
publicVariableServer "productionTime";

//
// FILLER GROUP OPTIONS
//


//values for how many groups per objective selected to spawn filler groups [min,mid,max]
fillerGroupsValues = [1,1,1];
publicVariableServer "fillerGroupsValues";

//percent chance 0-100 that a filler group will be created
fillerGroupsChance = 5;
publicVariableServer "fillerGroupsChance";

fillerGroupWeightMultiplier = 0.5;
publicVariableServer "fillerGroupWeightMultiplier";

fillerDistance = 1300;
publicVariableServer "fillerDistance";

fillerDistanceMinimum = 700;
publicVariableServer "fillerDistanceMinimum";



//
// CIVILIAN OPTIONS
//

//distance in meters for civilians to spawn/despawn
civDistance = 900;
publicVariableServer "civDistance";

//Minimum distance away from players needed to spawn civilian units
civDistanceMinimum = 400;
publicVariableServer "civDistanceMinimum";

//values for how many buildings per objective selected to spawn civilian ai [min,base,max]
civValues = [2,4,6];
publicVariableServer "civValues";

civWeightMultiplier = 0.7;
publicVariableServer "fillerGroupWeightMultiplier";

//limit of civilian vehicles alive at one time
civVehicleLimit = 0;
publicVariableServer "civVehicleLimit";

civTrafficValues = [0,1,2];
publicVariableServer "civTrafficValues";

//Starting value of civilian morale per objective
objectiveCivMorale = 50;
publicVariableServer "objectiveCivMorale";

//Chance that civilians are targeted by OPFOR units;
renegadeChance = 0;
publicVariableServer "renegadeChance";

//Chance that traffic vehicles are locked
lockedChance = 70;
publicVariableServer "lockedChance";

//Chance of animals spawning at an objective
animalChance = 85;
publicVariableServer "animalChance";


//
// VEHICLE OPTIONS
//

//maximum opfor vehicles that can exist at one time
vehLimit = 0;
publicVariableServer "vehLimit";



//
// Installation Options
//

//Maximum installations for _opForInArea
opforInstallationLimit = 12;
publicVariableServer "opforInstallationLimit";


//
// IED Options
//

//Maximum IEDs in an areas
IEDLimit = -1;
publicVariableServer "IEDLimit";

//Chance for individual IEDs to spawn when Requested
IEDSpawnChance = -1;
publicVariableServer "IEDSpawnChance";

//Chance for a civilian to become a suicide bomber
sVestSpawnChance = -1;
publicVariable "sVestSpawnChance";

//Chance a spawned IED is buried and harder/not possible to spot
IEDBuryChance = -1;
publicVariableServer "IEDBuryChance";

//Maximum trash objects that can exist at any given time
trashLimit = -1;
publicVariableServer "trashLimit";

//Chance trash spawns on loop
trashSpawnChance = -1;
publicVariableServer "trashSpawnChance";

//
// Task Options
//

//Maximum drug production tasks to exist at any time
maxDrugLocations = 0;


//
// OPFOR Support Options
//

//Chance that OPFOR will call easy artillery every minute.
opforArtyChance = -1;
publicVariableServer "opforArtyChance";

//Amount of strikes that can happen at once [min, mid, max]
opforArtyAmount = [1,3,6];
publicVariableServer "opforArtyAmount";


//
// Region Options
//

//Amount of Regions to generate
regionAmount = 3;
publicVariableServer "regionAmount";



//
// Player FOB Options
//

playerFobsAllowed = 5;
publicVariableServer "playerFobsAllowed";

playerPBsAllowed = 8;
publicVariableServer "playerPBsAllowed";


//
// HVT Options
//

chanceOfHVT = 5;
publicVariableServer "chanceOfHVT";





//
// VEM CONFIGURATION OPTIONS
//

// Enable VEM
vemEnabled = true;
publicVariable "vemEnabled";

// Objects that the intel interaction will be added to
// Mission will NOT START unless these objects exist in mission
intelInteractPoint = [];
publicVariable "intelInteractPoint";


// Store list of SRT members
// Used to segregate infantry from SRT
// definetly not eliteism...
// note these are steamID64's
srtPlayerUIDs = ["_SP_PLAYER_"];
publicVariableServer "srtPlayerUIDs";

// Variables to balance intel drop system
// These first two work in tandom. First is group,
// which controls percent chance anyone in group
// could contain any intel at all
// Next is Unit so if a group is determined to contain intel,
// this controls the percent chance that each unit will have intel.
// EX.) Group =33, Unit = 25 (100/4) -> With these numbers,
// odds are 1/3 of all groups could contain intel, %25 of units in these
// groups contain intel. If we assume all groups are 4 mans for simplicitys sake
// this would mean %8.25 of all units on map contain intel (1/3 * 25)
// [chanceGroupHasAnyIntel, chanceUnitHasAnyIntel, chanceCqbGroupHasIntel, chanceCqbUnitHasIntel, chanceHVTGroupCarryingIntel, chanceHVTCarryingIntel, chanceVehicleGroupCarryingIntel, chanceVehicleUnitCarryingIntel]
intelSpawnChances = [50, 25, 50, 25, 25, 75, 50, 25];
publicVariableServer "intelSpawnChances";


// While the above percentages control if someone will have intel,
// these control what intel each carrier is most likely to have
//chanceUnitHasFile = 60;
//chanceUnitHasPhone = 30;
//chanceUnitHasLaptop = 10;
//publicVariableServer "chanceUnitHasFile";
//publicVariableServer "chanceUnitHasPhone";
//publicVariableServer "chanceUnitHasLaptop";
//[chanceUnitHasFile,chanceUnitHasPhone,chanceUnitHasLaptop]
intelItemChance = [60,30,10];
publicVariableServer "intelItemChance";

// The below variables control the percentage chance of each tier
// of intel to be given to enemies.
//chanceUnitHasT1 = 60;
//chanceUnitHasT2 = 25;
//chanceUnitHasT3 = 15;
//publicVariableServer "chanceUnitHasT1";
//publicVariableServer "chanceUnitHasT2";
//publicVariableServer "chanceUnitHasT3";
intelTierChance = [60,30,10];
publicVariableServer "intelTierChance";


hvtClassNames = [["localLeader",["me_hvt_t1"]]];
publicVariableServer "hvtClassNames";

//How many HVTs should generate for deployment [min,mid,max]
//This number has to be smaller or equal to amount of HVTs or else there can be duplicate types
hvtCount = random [4,4,4];
publicVariableServer "hvtCount";
//
//  VEM MISSION OPTIONS
//

//How many missions should generate on first load of the deployment [min,mid,max]
missionInitCount = [1,3,5];
publicVariableServer "missionInitCount";

//How many missions should be generated and loaded at max at any one time.
missionMaxCount = 5;
publicVariableServer "missionMaxCount";



//
// End VEM Configuration opions
//


//-------------------------\\
//Dont touch past this line!\\
//Dont touch past this line!\\
//Dont touch past this line!\\
//Dont touch past this line!\\
//-------------------------\\

// Saving files per map!

_missionName = missionName;
missionPrefix = (_missionName + "_");
publicVariableServer "missionPrefix";
_allMissionSaves = profileNameSpace getVariable "allMissionSaves";
if (isNil "_allMissionSaves") then {
  _allMissionSaves = [];
  profileNameSpace setVariable ["allMissionSaves",_allMissionSaves];
};
_allMissionSaves;
if (missionPrefix in _allMissionSaves) then {
  ["Save Found.", "VICS_Cfg", true] call vics_sys_debug;
  profileNameSpace setVariable [(missionPrefix + "startOrder"),"load"];
} else {
  _allMissionSaves pushBackUnique missionPrefix;
  profileNameSpace setVariable ["allMissionSaves",_allMissionSaves];
  profileNameSpace setVariable [(missionPrefix + "startOrder"),"new"];
};
