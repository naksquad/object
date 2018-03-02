//nastynak
private ["_flatPos","_accepted","_position","_flatPos1","_flatPos2","_flatPos3","_PTdir","_unitsArray","_priorityGroup","_distance","_dir","_c","_pos","_barrier","_enemiesArray","_radius","_unit","_targetPos","_firingMessages","_fuzzyPos","_briefing","_completeText","_priorityMan1","_priorityMan2"];
private _spawnedUnits = [];
private _AISkillUnitsArray = [];
//-------------------- 1. FIND POSITION

	_flatPos = [0,0,0];
	_accepted = false;
	while {!_accepted} do {
		_position = [[[getMarkerPos currentAO,2500]],["water","out"]] call BIS_fnc_randomPos;
		_flatPos = _position isFlatEmpty [5, 0, 0.2, 5, 0, false];

		while {(count _flatPos) < 2} do {
			_position = [[[getMarkerPos currentAO,2500]],["water","out"]] call BIS_fnc_randomPos;
			_flatPos = _position isFlatEmpty [5, 0, 0.2, 5, 0, false];
		};

		if ((_flatPos distance (getMarkerPos "respawn_west")) > 2000 && (_flatPos distance (getMarkerPos currentAO)) > 2000) then
		{
			_accepted = true;
		};
	};

	_flatPos1 = [(_flatPos select 0) - 2, (_flatPos select 1) - 2, (_flatPos select 2)];
	_flatPos2 = [(_flatPos select 0) + 2, (_flatPos select 1) + 2, (_flatPos select 2)];
	_flatPos3 = [(_flatPos select 0) + 20, (_flatPos select 1) + random 20, (_flatPos select 2)];
	_flatPos4 = [(_flatPos select 0) + 40, (_flatPos select 1) + random 30, (_flatPos select 2)];
	_flatPos5 = [(_flatPos select 0) - 40, (_flatPos select 1) - random 30, (_flatPos select 2)];
	_flatPos6 = [(_flatPos select 0) - 60, (_flatPos select 1) + random 30, (_flatPos select 2)];


//-------------------- 2. SPAWN OBJECTIVES

	_PTdir = random 360;

	sleep 0.3;

	priorityObj1 = "O_MBT_02_cannon_F" createVehicle _flatPos1;
	waitUntil {!isNull priorityObj1};
	priorityObj1 setDir _PTdir;

	sleep 0.3;

	priorityObj2 = "O_APC_Tracked_02_AA_F" createVehicle _flatPos2;
	waitUntil {!isNull priorityObj2};
	priorityObj2 setDir _PTdir;

	sleep 0.3;

	//----- SPAWN AMMO TRUCK (for ambiance and plausibiliy of unlimited ammo)

	ammoTruck = "O_Truck_03_ammo_F" createVehicle _flatPos3;
	towers = "Land_Cargo_Tower_V1_F" createVehicle _flatPos4; 
	buka = "Land_Research_HQ_F" createVehicle _flatPos5; 
	buker = "Land_Cargo_Patrol_V4_F" createVehicle _flatPos6; 

	


	towers allowDamage false;
	towers enableDynamicSimulation true;
	buka allowDamage false;
	buka enableDynamicSimulation true;
	buker allowDamage false;
	buker enableDynamicSimulation true;
	waitUntil {!isNull ammoTruck};
	ammoTruck setDir random 360;
	ammoTruck enableDynamicSimulation true;

	{_x lock 3;_x allowCrewInImmobile true; } forEach [priorityObj1,priorityObj2,ammoTruck];

//-------------------- 3. SPAWN CREW

	sleep 1;

	_unitsArray = [objNull];

	_priorityGroup = createGroup east;
	_priorityGroup2 = createGroup east;
	[priorityObj1,_priorityGroup] call BIS_fnc_spawnCrew;
	[priorityObj2,_priorityGroup2] call BIS_fnc_spawnCrew;
	[(units _priorityGroup)] call AW_fnc_setSkill4;
	[(units _priorityGroup2)] call AW_fnc_setSkill4;
	_priorityGroup setBehaviour "COMBAT";
	_priorityGroup setCombatMode "RED";
	_priorityGroup allowFleeing 0;


//-------------------- 4. SPAWN H-BARRIER RING

	sleep 1;

	_distance = 16;
	_dir = 0;
	for "_c" from 0 to 7 do {
		_pos = [_flatPos, _distance, _dir] call BIS_fnc_relPos;
		_barrier = "Land_HBarrier_5_F" createVehicle _pos;
		waitUntil {alive _barrier};
		_barrier setDir _dir;
		_dir = _dir + 45;
		_barrier allowDamage false;
		_barrier enableSimulation false;
		_barrier enableDynamicSimulation true;
		_unitsArray = _unitsArray + [_barrier];
	};

//-------------------- 5. SPAWN FORCE PROTECTION



	sleep 1;
	_infPoss = getPos priorityObj1;
    for "_x" from 1 to 3 do {


		private _group = createGroup EAST;
		for "_x" from 1 to 8 do {
			_unitArray = (missionconfigfile >> "unitList" >> MainFaction >> "units") call BIS_fnc_getCfgData;
			_unit = _unitArray call BIS_fnc_selectRandom;
			_grpMember = _group createUnit [_unit, _infPoss, [], 0, "FORM"];
		};
        private _returnedUnits = [_infPoss, nil, (units _group), (100), 2, false] call derp_fnc_AIOccupyBuilding;

        { deleteVehicle _x } foreach _returnedUnits;

        {
            _spawnedUnits pushBack _x;
            _AISkillUnitsArray pushBack _x;
        } foreach (units _group);
    };

sleep 1;
_infPos = getPos priorityObj1;
for "_x" from 1 to 2 do {
    private _randomPos = [[[_infPos, 100], []], ["water", "out"]] call BIS_fnc_randomPos;
    private _infantryGroup = createGroup EAST;
    for "_x" from 1 to 8 do {
		private _squadPos = [[[_randomPos, 10], []], ["water", "out"]] call BIS_fnc_randomPos;
        _unitArray = (missionconfigfile >> "unitList" >> MainFaction >> "units") call BIS_fnc_getCfgData;
        _unit = _unitArray call BIS_fnc_selectRandom;
        _grpMember = _infantryGroup createUnit [_unit, _squadPos, [], 0, "FORM"];
        sleep 1;
		_infantryGroup enableDynamicSimulation true;
    };
    [_infantryGroup, _infPos, 300 / 1.6] call AW_FNC_taskPatrol;
//	[_infantryGroup,_infPos] call BIS_fnc_taskDefend;

    {
        _spawnedUnits pushBack _x;
		_AISkillUnitsArray pushBack _x;
    } foreach (units _infantryGroup);
};


//--------------------- Add units to zues
[_AISkillUnitsArray] call derp_fnc_AISkill;
if (isServer) then {
	{
	_x addCuratorEditableObjects [_spawnedUnits, true];
	} foreach allCurators;
} else {
	[_spawnedUnits, true] remoteExec ["derp_fnc_remoteAddCuratorEditableObjects", 2];
	spawnedUnits = _spawnedUnits;
	publicVariableServer "spawnedUnits";
	spawnedUnits = nil;
};


	//-------------------- 7. BRIEF

//	_fuzzyPos = [((_flatPos select 0) - 300) + (random 600),((_flatPos select 1) - 300) + (random 600),0];
	{ _x setMarkerPos _flatPos; } forEach ["priorityMarker", "priorityCircle"];

	priorityTargetText = "Research_HQ";
	"priorityMarker" setMarkerText "Priority Target: Research_HQ";

    [west,["priorArtyTask"],["OPFOR forces are setting up an Research_HQ! We've picked up their positions with thermal imaging scans and have marked it on your map. This is a priority target, boys! They're just setting up now; they'll be firing in about five minutes!","Priority Target: Research_HQ","priorityCircle"],(getMarkerPos "priorityCircle"),0,0,true,"whiteboard",true] call BIS_fnc_taskCreate;


//-------------------- FIRING SEQUENCE LOOP
sleep 10;

			Tresholds = createTrigger ["EmptyDetector", getPos priorityObj1];
			Tresholds setTriggerArea [150, 150, 0, false];
			Tresholds setTriggerActivation ["EAST", "PRESENT", false];
			Tresholds setTriggerStatements ["this","",""];

//waitUntil { sleep 0.5; !alive priorityObj1 && (count list Treshold < 5);};
waitUntil {sleep 5; !alive priorityObj1 && (count list Tresholds < 4)};

deleteVehicle Tresholds;

//-------------------- DE-BRIEF

["priorArtyTask", "Succeeded",true] call BIS_fnc_taskSetState;
sleep 5;
["priorArtyTask",west] call bis_fnc_deleteTask;
{ _x setMarkerPos [-10000,-10000,-10000] } forEach ["priorityMarker","priorityCircle"];

//-------------------- DELETE

sleep 300;
{ deleteVehicle _x } forEach _unitsArray;
{ deleteVehicle _x } forEach [priorityObj1,priorityObj2,ammoTruck,towers,buka,buker];
{ deleteVehicle _x } foreach _spawnedUnits;