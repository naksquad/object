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

//#define INF_TEAMS "HAF_InfSentry","HAF_InfSquad","HAF_InfSquad_Weapons","HAF_InfTeam","HAF_InfTeam_AA","HAF_InfTeam_AT","HAF_SniperTeam"
//#define VEH_TYPES "I_MRAP_03_hmg_F","I_APC_tracked_03_cannon_F","I_APC_Wheeled_03_cannon_F","I_MBT_03_cannon_F"
private ["_x","_pos","_flatPos","_randomPos","_enemiesArray","_infteamPatrol","_SMvehPatrol","_SMveh","_SMaaPatrol","_SMaa","_smSniperTeam"];
_enemiesArray = [grpNull];
_x = 0;

//---------- GROUPS
	
_infteamPatrol = createGroup east;
_smSniperTeam = createGroup east;
//_SMvehPatrol = createGroup east;
//SMaaPatrol = createGroup east;

//---------- INFANTRY RANDOM
	
for "_x" from 0 to 2 do {
	private  _randomPos = [getPos currentAO, 3000, 4000, 3, 0, 0.7, 0] call BIS_fnc_findSafePos;
	_infteamPatrol =  [_randomPos, east, (configfile >> "CfgGroups" >> "OPF_F" >> "Motorized_MTP" >> "OIA_MotInf_Reinforce")] call BIS_fnc_spawnGroup;
	//  _infteamPatrol enableDynamicSimulation true;

	[_infteamPatrol, getPos currentAO, 500] call BIS_fnc_taskPatrol;
				
	_enemiesArray = _enemiesArray + [_infteamPatrol];

	{
		_x addCuratorEditableObjects [units _infteamPatrol, false];
	} foreach adminCurators;

};
sleep 5;
//---------- reinfo

for "_x" from 0 to 2 do {
	private  _randomPos = [getPos currentAO, 3000, 4000, 3, 0, 0.7, 0] call BIS_fnc_findSafePos;
	_smSniperTeam = [_randomPos, east, (configfile >> "CfgGroups" >> "OPF_F" >> "Motorized_MTP" >> "OIA_MotInf_Reinforce")] call BIS_fnc_spawnGroup;
	//_smSniperTeam setBehaviour "COMBAT";
//	_smSniperTeam setCombatMode "RED";
		 // _smSniperTeam enableDynamicSimulation true;
[_smSniperTeam, getPos currentAO, 500] call BIS_fnc_taskPatrol;
		
	_enemiesArray = _enemiesArray + [_smSniperTeam];

	{
		_x addCuratorEditableObjects [units _smSniperTeam, false];
	} foreach adminCurators;

};
sleep 5;



//---------- COMMON



[(units _infteamPatrol)] call AW_fnc_setSkill2;
[(units _smSniperTeam)] call AW_fnc_setSkill3;
//[(units _SMaaPatrol)] call AW_fnc_setSkill4;
//[(units _SMvehPatrol)] call AW_fnc_setSkill2;
	
//---------- GARRISON FORTIFICATIONS
/*	
	{
		_newGrp = [_x] call AW_fnc_buildingDefenders;
		if (!isNull _newGrp) then { 
		_enemiesArray = _enemiesArray + [_newGrp]; };
	} forEach (getPos sideObj nearObjects ["Building", 150]);
*/
_enemiesArray