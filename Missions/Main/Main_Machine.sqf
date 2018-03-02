missionActive = true;
 waitUntil {!isNil "HC"}; waitUntil {!isNull HC};
_HCid   = owner HC; 

while {missionActive} do {
    currentAO = aofl call BIS_fnc_selectRandom;  sleep 5; _pos = getMarkerPos currentAO;
	 _mainAOUnits = [_pos, [true, true, true, true, true, true, true, true]] call derp_fnc_mainAOSpawnHandler;
	
{if (side _x == east) then {_x setGroupOwner _HCid;}} forEach (allGroups);
	diag_log "HC spwning shit right now bro";
	sleep 40;
	{_x setMarkerPos (getMarkerPos currentAO);} forEach ["aoCircle","aoMarker","inside"];
	{_x setMarkerText currentAO;} forEach ["aoMarker"];
	_targetStartText = format
	[
		"<t align='center' size='2.2'>New Target</t><br/><t size='1.5' align='center' color='#FFCF11'>%1</t><br/>____________________<br/>Good work on that last OP. I want to see the same again. We have a new objective you you. High Command has decided that %1 is of strategic value.<br/><br/>Don't forget about the secondary targets.",
		currentAO
	];
	[_targetStartText] remoteExec ["AW_fnc_globalHint",0,false];
    _mainAoTaskName = format
        [
	       "Take %1",
	        currentAO
        ];
    _mainAoTaskDesc = format
        [
           "Clear %1 of hostile forces.",
            currentAO
        ];
    [west,["MainAoTask"],[_mainAoTaskDesc,_mainAoTaskName,currentAO],(getMarkerPos currentAO),0,0,true,"attack",true] call BIS_fnc_taskCreate;

	sleep 10;

	//Spawn Sub-Obj -----------------------------------------

subObjComplete = 0;
subObjScript = [] execVM "Missions\Main\SubObj.sqf";

	//Checks for Ao still Active ----------------------------
	switch(mainSide) do{
		case "east":{
			mainMissionTreshold = createTrigger ["EmptyDetector", getMarkerPos currentAO];
			mainMissionTreshold setTriggerArea [1000, 1000, 0, false];
			mainMissionTreshold setTriggerActivation ["EAST", "PRESENT", false];
			mainMissionTreshold setTriggerStatements ["this","",""];
		};
		case "resistance":{
			mainMissionTreshold = createTrigger ["EmptyDetector", getMarkerPos currentAO];
			mainMissionTreshold setTriggerArea [1000, 1000, 0, false];
			mainMissionTreshold setTriggerActivation ["GUER", "PRESENT", false];
			mainMissionTreshold setTriggerStatements ["this","",""];
		};
	};


            

waitUntil {sleep 25;subObjComplete == 1 || !missionActive;}; 
_heliReinf = [currentAO, "airCavSpawnMarker", secondaryMainFaction] call AW_fnc_airCav;
waitUntil {sleep 25;(count list mainMissionTreshold < 75) || !missionActive;};
_mainAOUnitss = [_pos, [true, true, true, true, true, true, true, true]] call derp_fnc_papa;
waitUntil {sleep 25;(count list mainMissionTreshold < PARAMS_EnemyLeftThreshhold) || !missionActive;};
                           	//{if (side _x == east) then {deleteVehicle _x}} forEach allunits;


	deleteVehicle mainMissionTreshold;

	{
		if (!(isNull _x) && {alive _x}) then {
			deleteVehicle _x;
		};
	} foreach _mainAOUnits;
	{
		if (!(isNull _x) && {!alive _x}) then {
			deleteVehicle _x;
		};
	} foreach _mainAOUnits;
	{
		if (!(isNull _x) && {alive _x}) then {
			deleteVehicle _x;
		};
	} foreach _mainAOUnitss;
	{
		if (!(isNull _x) && {!alive _x}) then {
			deleteVehicle _x;
		};
	} foreach _mainAOUnitss;
	{
		deleteVehicle _x;
	} foreach _heliReinf;

	_targetStartText = format
	[
		"<t align='center' size='2.2'>Secured</t><br/><t size='1.5' align='center' color='#FFCF11'>%1</t><br/>____________________<br/>Good work out there. We have provided you with some light assets to help you redeploy to the next assignment.",
		currentAO
	];
    ["MainAoTask", "Succeeded",true] call BIS_fnc_taskSetState;
    sleep 5;
    ["MainAoTask",west] call bis_fnc_deleteTask;
	[_targetStartText] remoteExec ["AW_fnc_globalHint",0,false];

	{ _x setMarkerPos [-10000,-10000,-10000]; } forEach ["aoCircle","aoMarker","inside"];
	reinforcementsSpawned = 0;
_pos = getMarkerPos currentAO;
if (Random 8 > 4) then {
_flatPos = _pos;
sleep 7;
_mainAOUnits = [_pos, [true, true, true, true, true, true, true, true]] call derp_fnc_defendAOSpawnHandler;
sleep 5;

	switch(mainSide) do{
		case "east":{
			mainMissionTreshold = createTrigger ["EmptyDetector", getMarkerPos currentAO];
			mainMissionTreshold setTriggerArea [1000, 1000, 0, false];
			mainMissionTreshold setTriggerActivation ["EAST", "PRESENT", false];
			mainMissionTreshold setTriggerStatements ["this","",""];
		};
		case "resistance":{
			mainMissionTreshold = createTrigger ["EmptyDetector", getMarkerPos currentAO];
			mainMissionTreshold setTriggerArea [1000, 1000, 0, false];
			mainMissionTreshold setTriggerActivation ["GUER", "PRESENT", false];
			mainMissionTreshold setTriggerStatements ["this","",""];
		};
	};


{_x setMarkerPos (getMarkerPos currentAO);} forEach ["aoCircleDefend","aoMarkerDefend"];
	{_x setMarkerText currentAO;} forEach ["aoMarkerDefend"];
	_targetStartText = format
	[
		"<t align='center' size='2.2'>Defend Target</t><br/><t size='1.5' align='center' color='#3011ff'>%1</t><br/>____________________<br/>You have 10 minutes to Defend %1.<br/><br/>Don't forget about the secondary targets.",
		currentAO
	];
	[_targetStartText] remoteExec ["AW_fnc_globalHint",0,false];
    _mainAoTaskName = format
        [
	       "Defend %1",
	        currentAO
        ];
    _mainAoTaskDesc = format
        [
           "Protect %1 of hostile forces.",
            currentAO
        ];
    [west,["MainAoTask"],[_mainAoTaskDesc,_mainAoTaskName,currentAO],(getMarkerPos currentAO),0,0,true,"attack",true] call BIS_fnc_taskCreate;

    
	_heliReinf = [currentAO, "airCavSpawnMarker", secondaryMainFaction] call AW_fnc_airCav;	

	sleep 400;
	waitUntil {sleep 25;(count list mainMissionTreshold < 20) || !missionActive;};
//	sleep 500;

	deleteVehicle mainMissionTreshold;

	{
		if (!(isNull _x) && {alive _x}) then {
			deleteVehicle _x;
		};
	} foreach _mainAOUnits;
	{
		if (!(isNull _x) && {!alive _x}) then {
			deleteVehicle _x;
		};
	} foreach _mainAOUnits;
	{
		deleteVehicle _x;
	} foreach _heliReinf;
	
	_targetStartText = format
	[
		"<t align='center' size='2.2'>Protected</t><br/><t size='1.5' align='center' color='#FFCF11'>%1</t><br/>____________________<br/>Good work out there. We have provided you with some light assets to help you redeploy to the next assignment.",
		currentAO
	];
    ["MainAoTask", "Succeeded",true] call BIS_fnc_taskSetState;
    sleep 5;
    ["MainAoTask",west] call bis_fnc_deleteTask;
	[_targetStartText] remoteExec ["AW_fnc_globalHint",0,false];

	{ _x setMarkerPos [-10000,-10000,-10000]; } forEach ["aoCircleDefend","aoMarkerDefend"];


};

sleep 90;

};
