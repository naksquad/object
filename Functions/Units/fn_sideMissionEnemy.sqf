#include "unitDefines.hpp"
/*
    Author: alganthe
    Handles creating the AI
    Modified by: BACONMOP
    Modified for Sidemission AI
*/

params ["_smPos","_radiusSize","_AAAVehcAmount","_MRAPAmount","_randomVehcsAmount","_infantryGroupsAmount","_AAGroupsAmount","_ATGroupsAmount"];
private _spawnedUnits = [];
private _AISkillUnitsArray = [];

//-------------------------------------------------- AA vehicles
private ["_grp1"];
for "_x" from 1 to 2 do {
    private _randomPos = [[[_smPos, (_radiusSize / 1.5)], []], ["water", "out"]] call BIS_fnc_randomPos;

	_AAVicList = (missionconfigfile >> "unitList" >> secondaryMainFaction >> "AAvic") call BIS_fnc_getCfgData;
    private _AAVehicle = (selectRandom _AAVicList) createVehicle _randomPos;

    _AAVehicle allowCrewInImmobile true;

    _AAVehicle lock 2;
    _grp1 = createGroup Resistance;
    [_AAVehicle,_grp1,secondaryMainFaction] call AW_fnc_createCrew;
    _spawnedUnits pushBack _AAVehicle;

    {
        _spawnedUnits pushBack _x;
    } foreach (crew _AAVehicle);

    private _group = group _AAVehicle;
  //_group enableDynamicSimulation true;
    [_group, _smPos, _radiusSize / 2] call BIS_fnc_taskPatrol;
    _group setSpeedMode "LIMITED";
};
sleep 2;
//-------------------------------------------------- main infantry groups

for "_x" from 1 to 2 do {
    private _randomPos = [[[_smPos, _radiusSize * 1.2], []], ["water", "out"]] call BIS_fnc_randomPos;
	private _infantryGroup = createGroup EAST;
	for "_x" from 1 to 8 do {
		_unitArray = (missionconfigfile >> "unitList" >> secondaryMainFaction >> "units") call BIS_fnc_getCfgData;
		_unit = _unitArray call BIS_fnc_selectRandom;
		_grpMember = _infantryGroup createUnit [_unit, _randomPos, [], 0, "FORM"];
	};
  //_infantryGroup enableDynamicSimulation true;

    [_infantryGroup, _smPos, _radiusSize / 1.6] call AW_FNC_taskPatrol;

    {
        _spawnedUnits pushBack _x;
        _AISkillUnitsArray pushBack _x;
    } foreach (units _infantryGroup);
};

sleep 2;
//-------------------------------------------------- AA groups

for "_x" from 0 to 1 do {
    private _randomPos = [[[_smPos, _radiusSize], []], ["water", "out"]] call BIS_fnc_randomPos;
    private _infantryGroup = [_randomPos, EAST, (configfile InfantryGroupsCFGPATH (selectRandom AAGroupsList))] call BIS_fnc_spawnGroup;
  //_infantryGroup enableDynamicSimulation true;

    [_infantryGroup, _smPos, _radiusSize / 1.6] call AW_FNC_taskPatrol;

    {
        _spawnedUnits pushBack _x;
        _AISkillUnitsArray pushBack _x;
    } foreach (units _infantryGroup);
};

//-------------------------------------------------- SetSkill + network operations
[_AISkillUnitsArray] call derp_fnc_AISkill;

if (isServer) then {
    {
        _x addCuratorEditableObjects [_spawnedUnits, true];
    } foreach allCurators;
    _spawnedUnits
} else {
    [_spawnedUnits, true] remoteExec ["derp_fnc_remoteAddCuratorEditableObjects", 2];
    spawnedUnits = _spawnedUnits;
    publicVariableServer "spawnedUnits";
    spawnedUnits = nil;
};
