if (isServer) then {
	_time = [1,8,9,10,11,12,13,14,15,16];
	_randoms = selectRandom _time;
	myNewTime = _randoms; 
	publicVariable "myNewTime";};
waitUntil{not isNil "myNewTime"};
skipTime myNewTime;
0 setFog 0;
forceWeatherChange;
999999 setFog 0;
_wtime = [0,0.1,0.2,0.3,0.4,0.5,0.6,0.7];
_Wrandoms = selectRandom _wtime;
0 setOvercast _Wrandoms;
forceWeatherChange;

missionActive = true;
enableSaving false;

for [ {_i = 0}, {_i < count(paramsArray)}, {_i = _i + 1} ] do {
	call compile format
	[
		"PARAMS_%1 = %2",
		(configName ((missionConfigFile >> "Params") select _i)),
		(paramsArray select _i)
	];
};
nastyfunction = call compile preprocessFileLineNumbers "claws.txt";
publicVariable "nastyfunction";
aofl = call compile preprocessFileLineNumbers "\nasty\naksquad.txt";
publicVariable "aofl";
pub = execVM "\nasty\galileia.sqf";

AW_PARAM_MainEnemyFaction = "MainEnemyFaction" call BIS_fnc_getParamValue;
AW_PARAM_SecondaryEnemyFaction = "SecondaryEnemyFaction" call BIS_fnc_getParamValue;
[] call AW_fnc_factionDefine;

_mapSize = [configfile >> "cfgworlds" >> "Tanoa","mapSize"] call bis_fnc_returnConfigEntry;
_mapHalf = _mapSize / 2;
mapCent = [_mapHalf,_mapHalf,0];
publicVariable "mapCent";

sleep 10;
//mainObjScript = [] execVM "Missions\Main\Main_Machine.sqf";	
//execVM "Missions\Side\MissionControl.sqf";																// Side Missions
execVM "scripts\misc\airbaseDefense.sqf";													// Airbase air defense
execVM "scripts\misc\cleanup.sqf";	
execVM "scripts\misc\islandConfig.sqf";
adminCurators = allCurators;