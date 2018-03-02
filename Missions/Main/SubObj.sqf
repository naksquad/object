/*
 * Author: BACONMOP
 * Creates and handles Sub Objectives
 *
 *
 */
reinforcementsSpawned = 0;
subObjComplete = 0;
_subObjMission = [
	"RadioTower",
	"AmmoCache",
	"Warheads"
];
_subObj = _subObjMission call BIS_fnc_selectRandom;

switch(_subObj) do{

	case "AmmoCache":{
			_dt = createTrigger ["EmptyDetector", getMarkerPos currentAO];
		_dt setTriggerArea [800, 800, 0, false];
		_dt setTriggerActivation ["EAST", "PRESENT", false];
		_dt setTriggerStatements ["this","",""];
		_position = [[[getMarkerPos currentAO, PARAMS_AOSize],_dt],["water","out"]] call BIS_fnc_randomPos;
		_flatPos = _position isFlatEmpty[3, 1, 0.3, 30, 0, false];

		while {(count _flatPos) < 1} do {
			_position = [[[getMarkerPos currentAO, PARAMS_AOSize],_dt],["water","out"]] call BIS_fnc_randomPos;
			_flatPos = _position isFlatEmpty[3, 1, 0.3, 30, 0, false];
		};

		_roughPos =
		[
			((_flatPos select 0) - 200) + (random 400),
			((_flatPos select 1) - 200) + (random 400),
			0
		];

		radioTower = "Box_FIA_Ammo_F" createVehicle _flatPos;
		waitUntil { sleep 0.5; alive radioTower || !missionActive;};
		radioTower setVectorUp [0,0,1];
		radioTower setVariable ["R3F_LOG_disabled", true];
		radioTowerAlive = true;
		deleteVehicle _dt;
		{ _x setMarkerPos _position; } forEach ["radioMarker","radioCircle"];
		{_x setMarkerText "Sub-Objective: Cache"} forEach ["radioMarker"];
		_targetStartText = format
			[
				"<t align='center' size='2.2'>Sub-Objective</t><br/><t size='1.5' align='center' color='#FFCF11'>Supply Cache</t><br/>____________________<br/>We have received intel from local resistance fighters that OPFOR have hidden a weapons cache in the area. Take it out and expect it to be guarded.<br/><br/>"
			];
		[_targetStartText] remoteExec ["AW_fnc_globalHint",0,false];
        [west,["SubAoTask"],["We have received intel from local resistance fighters that OPFOR have hidden a weapons cache in the area. Take it out and expect it to be guarded.","Ammo Cache","radioCircle"],(getMarkerPos "radioCircle"),0,0,true,"destroy",true] call BIS_fnc_taskCreate;
		[] spawn {
			sleep 100;
			if (alive radioTower) then {
				while {(alive radioTower)} do {
					[] call AW_fnc_enemycas;
					sleep 720;
				};
			};
		};
		waitUntil {sleep 60; !alive radioTower};
		_targetStartText = format
			[
					"<t align='center' size='2.2'>Sub-Objective</t><br/><t size='1.5' align='center' color='#FFCF11'>Cache Destroyed</t><br/>____________________<br/>Good job. The cache has been destroyed.",
				currentAO
			];
		[_targetStartText] remoteExec ["AW_fnc_globalHint",0,false];
		["CompletedSub", "AmmoCache"] remoteExec ["AW_fnc_globalNotification",0,false];
        ["SubAoTask", "Succeeded",true] call BIS_fnc_taskSetState;
        sleep 5;
        ["SubAoTask",west] call bis_fnc_deleteTask;
		deleteVehicle radioTower;
	};

	case "RadioTower":{
		_dt = createTrigger ["EmptyDetector", getMarkerPos currentAO];
		_dt setTriggerArea [800, 800, 0, false];
		_dt setTriggerActivation ["EAST", "PRESENT", false];
		_dt setTriggerStatements ["this","",""];
		_position = [[[getMarkerPos currentAO, PARAMS_AOSize],_dt],["water","out"]] call BIS_fnc_randomPos;
		_flatPos = _position isFlatEmpty[3, 1, 0.3, 30, 0, false];

		while {(count _flatPos) < 1} do {
			_position = [[[getMarkerPos currentAO, PARAMS_AOSize],_dt],["water","out"]] call BIS_fnc_randomPos;
			_flatPos = _position isFlatEmpty[3, 1, 0.3, 30, 0, false];
		};

		_roughPos =
		[
			((_flatPos select 0) - 200) + (random 400),
			((_flatPos select 1) - 200) + (random 400),
			0
		];

		radioTower = "Land_TTowerBig_2_F" createVehicle _flatPos;
		waitUntil { sleep 0.5; alive radioTower || !missionActive;};
		radioTower setVectorUp [0,0,1];
		radioTower setVariable ["R3F_LOG_disabled", true];
		radioTowerAlive = true;
		deleteVehicle _dt;
		{ _x setMarkerPos _position; } forEach ["radioMarker","radioCircle"];
		{_x setMarkerText "Sub-Objective: Radio Tower"} forEach ["radioMarker"];
		_targetStartText = format
			[
				"<t align='center' size='2.2'>Sub-Objective</t><br/><t size='1.5' align='center' color='#FFCF11'>Radio Tower</t><br/>____________________<br/>OPFOR have setup a radio communications tower in the AO. Take it out quickly or else they will use it to call in air strikes.<br/><br/>"
			];
		[_targetStartText] remoteExec ["AW_fnc_globalHint",0,false];
        [west,["SubAoTask"],["OPFOR have setup a radio communications tower in the AO. Take it out quickly or else they will use it to call in air strikes.","Radio Tower","radioCircle"],(getMarkerPos "radioCircle"),0,0,true,"destroy",true] call BIS_fnc_taskCreate;
		[] spawn {
			sleep 100;
			if (alive radioTower) then {
				while {(alive radioTower)} do {
					[] call AW_fnc_enemycas;
					sleep 720;
				};
			};
		};
		waitUntil {sleep 60; !alive radioTower};
		_targetStartText = format
			[
				"<t align='center' size='2.2'>Sub-Objective</t><br/><t size='1.5' align='center' color='#FFCF11'>Complete</t><br/>____________________<br/>Good job with that radio tower. OPFOR should have a tougher organizing their air efforts.",
				currentAO
			];
		[_targetStartText] remoteExec ["AW_fnc_globalHint",0,false];
		["CompletedSub", "Radio Tower"] remoteExec ["AW_fnc_globalNotification",0,false];
        ["SubAoTask", "Succeeded",true] call BIS_fnc_taskSetState;
        sleep 5;
        ["SubAoTask",west] call bis_fnc_deleteTask;
		deleteVehicle radioTower;
	};

case "Warheads":{
		_dt = createTrigger ["EmptyDetector", getMarkerPos currentAO];
		_dt setTriggerArea [800, 800, 0, false];
		_dt setTriggerActivation ["EAST", "PRESENT", false];
		_dt setTriggerStatements ["this","",""];
		_position = [[[getMarkerPos currentAO, PARAMS_AOSize],_dt],["water","out"]] call BIS_fnc_randomPos;
		_flatPos = _position isFlatEmpty[3, 1, 0.3, 30, 0, false];

		while {(count _flatPos) < 1} do {
			_position = [[[getMarkerPos currentAO, PARAMS_AOSize],_dt],["water","out"]] call BIS_fnc_randomPos;
			_flatPos = _position isFlatEmpty[3, 1, 0.3, 30, 0, false];
		};

		_roughPos =
		[
			((_flatPos select 0) - 200) + (random 400),
			((_flatPos select 1) - 200) + (random 400),
			0
		];

		radioTower = "Land_Device_disassembled_F" createVehicle _flatPos;
		waitUntil { sleep 0.5; alive radioTower || !missionActive;};
		radioTower setVectorUp [0,0,1];
		radioTower setVariable ["R3F_LOG_disabled", true];
		radioTowerAlive = true;
		deleteVehicle _dt;
		{ _x setMarkerPos _position; } forEach ["radioMarker","radioCircle"];
		{_x setMarkerText "Sub-Objective: Warheads"} forEach ["radioMarker"];
		_targetStartText = format
			[
				"<t align='center' size='2.2'>Sub-Objective</t><br/><t size='1.5' align='center' color='#FFCF11'>Warheads</t><br/>____________________<br/>OPFOR have setup a Warheads inside the AO. Take it out quickly before Detonation.<br/><br/>"
			];
		[_targetStartText] remoteExec ["AW_fnc_globalHint",0,false];
        [west,["SubAoTask"],["OPFOR have setup a Warheads inside the AO. Take it out quickly before Detonation.","Warheads","radioCircle"],(getMarkerPos "radioCircle"),0,0,true,"destroy",true] call BIS_fnc_taskCreate;
		[] spawn {
			sleep 100;
			if (alive radioTower) then {
				while {(alive radioTower)} do {
					[] call AW_fnc_enemycas;
					sleep 720;
				};
			};
		};
		waitUntil {sleep 60; !alive radioTower};
		_targetStartText = format
			[
				"<t align='center' size='2.2'>Sub-Objective</t><br/><t size='1.5' align='center' color='#FFCF11'>Complete</t><br/>____________________<br/>Good job with that Warheads. OPFOR should have a tougher organizing their efforts to destroy the island.",
				currentAO
			];
		[_targetStartText] remoteExec ["AW_fnc_globalHint",0,false];
		["CompletedSub", "Warheads"] remoteExec ["AW_fnc_globalNotification",0,false];
        ["SubAoTask", "Succeeded",true] call BIS_fnc_taskSetState;
        sleep 5;
        ["SubAoTask",west] call bis_fnc_deleteTask;
		deleteVehicle radioTower;
	};
	
};
{ _x setMarkerPos [-10000,-10000,-10000]; } forEach ["radioMarker","radioCircle"];
subObjComplete = 1;
