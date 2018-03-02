#include "unitDefines.hpp"
#define STATIC_TYPE "O_HMG_01_high_F","O_HMG_01_high_F"
/*
* Author: alganthe
* Handles creating the AI
*
* Arguments:
* 0: Position of the mission <POSITION>
* 1: <ARRAY>
*    1: Place AA vehicles <BOOL>
*    2: Place  MRAPS <BOOL>
*    3: Place random vehcs <BOOL>
*    4: Place infantry groups <BOOL>
*    5: Place AA groups <BOOL>
*    6: Place AT groups <BOOL>
*    7: Place urban groups <BOOL>
*    8: Place infantry in milbuildings <BOOL>
* 2: AA vehicles amount <SCALAR> (OPTIONNAL)
* 3: MRAPs amount <SCALAR> (OPTIONNAL)
* 4: Random vehcs amount <SCALAR> (OPTIONNAL)
* 5: Infantry groups amount <SCALAR> (OPTIONNAL)
* 6: AA groups amount <SCALAR> (OPTIONNAL)
* 7: AT groups amount <SCALAR> (OPTIONNAL)
* 8: Urban groups amount <SCALAR> (OPTIONNAL)
*
* Return Value:
* Array of units created if executed on the server
* Nothing if executed anywhere else (it publicVarServer the array of spawned units instead)
*
* Example:
*
*[_pos, [true, true, false, true, true, true, true, false], 2, 1, 3, 5, 1, 1, 3] call derp_fnc_mainAOSpawnHandler;
*/
params ["_AOpos", "_settingsArray", ["_radiusSize", derp_PARAM_AOSize], ["_AAAVehcAmount", derp_PARAM_AntiAirAmount], ["_MRAPAmount", derp_PARAM_MRAPAmount], ["_randomVehcsAmount", derp_PARAM_RandomVehcsAmount], ["_infantryGroupsAmount", derp_PARAM_InfantryGroupsAmount], ["_AAGroupsAmount", derp_PARAM_AAGroupsAmount], ["_ATGroupsAmount", derp_PARAM_ATGroupsAmount], ["_urbanInfantryAmount", 2]];

_settingsArray params [["_AAAVehcSetting", false], ["_MRAPSetting", false], ["_randomVehcsSetting", false], ["_infantryGroupsSetting", false], ["_AAGroupsSetting", false], ["_ATGroupsSetting", false], ["_urbanInfantrySetting", false], ["_milbuildingInfantry", false]];
private _spawnedUnits = [];
private _AISkillUnitsArray = [];



for "_x" from 0 to 5 do {
	private _randomPos = [_AOpos, 1000,1500, 3, 0, 0.7, 0] call BIS_fnc_findSafePos;
	private _smSniperTeam = [_randomPos, east, (configfile >> "CfgGroups" >> "East" >> "OPF_F" >> "UInfantry" >> "OIA_GuardSquad")] call BIS_fnc_spawnGroup;
    [_smSniperTeam, _AOpos, _radiusSize / 2] call  BIS_fnc_taskPatrol;
	// _smSniperTeam enableDynamicSimulation true;

	    {
            _spawnedUnits pushBack _x;
            _AISkillUnitsArray pushBack _x;
        } foreach (units _smSniperTeam);
};
//-------------------------------------------------- Indoors infantry



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
