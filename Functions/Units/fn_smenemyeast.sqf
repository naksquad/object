/*
Author: 

	Quiksilver
	
Last modified:

	25/04/2014

Description:

	Spawn OPFOR enemy around side objectives.
	Enemy should have backbone AA/AT + random composition.
	
	
___________________________________________*/

//---------- CONFIG

#define INF_TEAMS "HAF_InfSentry","HAF_InfSquad","HAF_InfSquad_Weapons","HAF_InfTeam","HAF_InfTeam_AA","HAF_InfTeam_AT","HAF_SniperTeam"
#define VEH_TYPES "I_MRAP_03_hmg_F","I_APC_tracked_03_cannon_F","I_APC_Wheeled_03_cannon_F","I_MBT_03_cannon_F"
private ["_x","_pos","_flatPos","_randomPos","_enemiesArray","_infteamPatrol","_SMvehPatrol","_SMveh","_SMaaPatrol","_SMaa","_smSniperTeam"];
_enemiesArray = [grpNull];
_x = 0;

//---------- GROUPS
	
_infteamPatrol = createGroup resistance;
_smSniperTeam = createGroup resistance;
_SMvehPatrol = createGroup resistance;
_SMaaPatrol = createGroup resistance;

//---------- INFANTRY RANDOM
	
for "_x" from 0 to 2 do {
	_randomPos = [[[getPos sideObj, 300],[]],["water","out"]] call BIS_fnc_randomPos;
	_infteamPatrol = [_randomPos, resistance, (configfile >> "CfgGroups" >> "Indep" >> "IND_F" >> "Infantry" >> [INF_TEAMS] call BIS_fnc_selectRandom)] call BIS_fnc_spawnGroup;
	//  _infteamPatrol enableDynamicSimulation true;

	[_infteamPatrol, getPos sideObj, 100] call BIS_fnc_taskPatrol;
				
	_enemiesArray = _enemiesArray + [_infteamPatrol];

	{
		_x addCuratorEditableObjects [units _infteamPatrol, false];
	} foreach adminCurators;

};
sleep 5;
//---------- SNIPER

for "_x" from 0 to 1 do {
	_randomPos = [getPos sideObj, 500, 100, 20] call BIS_fnc_findOverwatch;
	_smSniperTeam = [_randomPos, resistance, (configfile >> "CfgGroups" >> "Indep" >> "IND_F" >> "Infantry" >> "HAF_SniperTeam")] call BIS_fnc_spawnGroup;
	_smSniperTeam setBehaviour "COMBAT";
	_smSniperTeam setCombatMode "RED";
		 // _smSniperTeam enableDynamicSimulation true;

		
	_enemiesArray = _enemiesArray + [_smSniperTeam];

	{
		_x addCuratorEditableObjects [units _smSniperTeam, false];
	} foreach adminCurators;

};
sleep 5;
//---------- VEHICLE RANDOM
	
_randomPos = [[[getPos sideObj, 300],[]],["water","out"]] call BIS_fnc_randomPos;
_SMveh1 = [VEH_TYPES] call BIS_fnc_selectRandom createVehicle _randomPos;
waitUntil {sleep 0.5; !isNull _SMveh1};
[_SMveh1, _SMvehPatrol] call BIS_fnc_spawnCrew;
		 // _SMvehPatrol enableDynamicSimulation true;

[_SMvehPatrol, getPos sideObj, 75] call BIS_fnc_taskPatrol;
_SMveh1 lock 3;
if (random 1 >= 0.5) then {
	_SMveh1 allowCrewInImmobile true;
};
sleep 0.1;
	
_enemiesArray = _enemiesArray + [_SMveh1];
sleep 5;

//---------- VEHICLE RANDOM	
	
_randomPos = [[[getPos sideObj, 300],[]],["water","out"]] call BIS_fnc_randomPos;
_SMveh2 = [VEH_TYPES] call BIS_fnc_selectRandom createVehicle _randomPos;
waitUntil {sleep 0.5; !isNull _SMveh2};
[_SMveh2, _SMvehPatrol] call BIS_fnc_spawnCrew;
		 // _SMvehPatrol enableDynamicSimulation true;

[_SMvehPatrol, getPos sideObj, 150] call BIS_fnc_taskPatrol;
_SMveh2 lock 3;
if (random 1 >= 0.5) then {
	_SMveh2 allowCrewInImmobile true;
};
sleep 0.1;
	
_enemiesArray = _enemiesArray + [_SMveh2];
sleep 0.1;
_enemiesArray = _enemiesArray + [_SMvehPatrol];

sleep 5;

//---------- VEHICLE AA
	
_randomPos = [[[getPos sideObj, 300],[]],["water","out"]] call BIS_fnc_randomPos;
_SMaa = "O_APC_Tracked_02_AA_F" createVehicle _randomPos;
waitUntil {sleep 0.5; !isNull _SMaa};
[_SMaa, _SMaaPatrol] call BIS_fnc_spawnCrew;
_SMaa lock 3;
if (random 1 >= 0.5) then {
	_SMaa allowCrewInImmobile true;
};
		 // _SMaaPatrol enableDynamicSimulation true;

[_SMaaPatrol, getPos sideObj, 150] call BIS_fnc_taskPatrol;
	
_enemiesArray = _enemiesArray + [_SMaaPatrol];
sleep 0.1;
_enemiesArray = _enemiesArray + [_SMaa];

{
	_x addCuratorEditableObjects [[_SMaa], false];
	_x addCuratorEditableObjects [units _SMaaPatrol, false];
} foreach adminCurators;


//---------- COMMON



[(units _infteamPatrol)] call AW_fnc_setSkill2;
[(units _smSniperTeam)] call AW_fnc_setSkill3;
[(units _SMaaPatrol)] call AW_fnc_setSkill4;
[(units _SMvehPatrol)] call AW_fnc_setSkill2;
	
//---------- GARRISON FORTIFICATIONS
/*	
	{
		_newGrp = [_x] call AW_fnc_buildingDefenders;
		if (!isNull _newGrp) then { 
		_enemiesArray = _enemiesArray + [_newGrp]; };
	} forEach (getPos sideObj nearObjects ["Building", 150]);
*/
_enemiesArray