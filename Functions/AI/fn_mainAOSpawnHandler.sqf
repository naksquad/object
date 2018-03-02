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

//-------------------------------------------------- AA vehicles
private ["_grp1"];
if (_AAAVehcSetting) then {
    for "_x" from 1 to _AAAVehcAmount do {
           private  _randomPos = [_AOpos, 2000,2500, 3, 0, 0.7, 0] call BIS_fnc_findSafePos;
		_AAVicList = (missionconfigfile >> "unitList" >> MainFaction >> "AAvic") call BIS_fnc_getCfgData;
        private _AAVehicle = (selectRandom _AAVicList) createVehicle _randomPos;

        _AAVehicle allowCrewInImmobile true;

        _AAVehicle lock 2;
        _grp1 = createGroup east;
        [_AAVehicle,_grp1,MainFaction] call AW_fnc_createCrew;

        _spawnedUnits pushBack _AAVehicle;

        {
            _spawnedUnits pushBack _x;
        } foreach (crew _AAVehicle);

        private _group = group _AAVehicle;
       //  _group enableDynamicSimulation true;
        [_group, _AOpos, _radiusSize] call BIS_fnc_taskPatrol;
    
        _group setSpeedMode "LIMITED";
        _group setCombatMode "RED";
       
    };
};

//-------------------------------------------------- MRAP
private ["_grp1"];
if (_MRAPSetting) then {
    for "_x" from 1 to _MRAPAmount do {
      private  _randomPos =  [_AOpos, 2000,2500, 3, 0, 0.7, 0] call BIS_fnc_findSafePos;
		_MRAPList = (missionconfigfile >> "unitList" >> MainFaction >> "AAvic") call BIS_fnc_getCfgData;
        private _MRAP = (selectRandom MRAPList) createVehicle _randompos;

        _MRAP allowCrewInImmobile true;
        _MRAP lock 2;
        _grp1 = createGroup east;
        [_MRAP,_grp1,MainFaction] call AW_fnc_createCrew;
        _spawnedUnits pushBack _MRAP;

        {
            _spawnedUnits pushBack _x;
        } foreach (crew _MRAP);

        private _group = group _MRAP;
       //  _group enableDynamicSimulation true;
        [_group, _AOpos, _radiusSize] call BIS_fnc_taskPatrol;
        _group setSpeedMode "LIMITED";
        _group setCombatMode "RED";
         
    };
};

//-------------------------------------------------- random vehcs
private ["_grp1"];
if (_randomVehcsSetting) then {
    for "_x" from 1 to _randomVehcsAmount do {
     private  _randomPos =  [_AOpos, 2000,2500, 3, 0, 0.7, 0] call BIS_fnc_findSafePos;
		_RandomVehicleList = (missionconfigfile >> "unitList" >> MainFaction >> "APCs") call BIS_fnc_getCfgData;
        private _vehc = (selectRandom _RandomVehicleList) createVehicle _randompos;

        _vehc allowCrewInImmobile true;
        _vehc lock 2;
        _grp1 = createGroup east;
        [_vehc,_grp1,MainFaction] call AW_fnc_createCrew;
        _spawnedUnits pushBack _vehc;
        {
            _spawnedUnits pushBack _x;
        } foreach (crew _vehc);
        private _group = group _vehc;
      //   _group enableDynamicSimulation true;
        [_group, _AOpos, _radiusSize] call BIS_fnc_taskPatrol;
        _group setSpeedMode "LIMITED";
        _group setCombatMode "RED";
    
    };
};

//-------------------------------------------------- main infantry groups
if (_infantryGroupsSetting) then {
    for "_x" from 1 to _infantryGroupsAmount do {
        private  _spawnPos = [_AOpos, 100, 900, 3, 0, 0.7, 0] call BIS_fnc_findSafePos;
		private _infantryGroup = createGroup EAST;
		for "_x" from 1 to 8 do {
			_unitArray = (missionconfigfile >> "unitList" >> MainFaction >> "units") call BIS_fnc_getCfgData;
			_unit = _unitArray call BIS_fnc_selectRandom;
			_grpMember = _infantryGroup createUnit [_unit, _spawnPos, [], 0, "FORM"];
		};
         _infantryGroup enableDynamicSimulation true;
        [_infantryGroup, _AOpos, _radiusSize / 2] call  BIS_fnc_taskPatrol;

        {
            _spawnedUnits pushBack _x;
            _AISkillUnitsArray pushBack _x;
        } foreach (units _infantryGroup);
    };
};

//-------------------------------------------------- AA groups
if (_AAGroupsSetting) then {
    for "_x" from 1 to _AAGroupsAmount do {
     private  _spawnPos = [_AOpos, 100, 900, 3, 0, 0.7, 0] call BIS_fnc_findSafePos;
        private _infantryGroup = [_spawnPos, EAST, (configfile InfantryGroupsCFGPATH (selectRandom AAGroupsList))] call BIS_fnc_spawnGroup;
         _infantryGroup enableDynamicSimulation true;
       [_infantryGroup, _AOpos, _radiusSize / 2] call  BIS_fnc_taskPatrol;
        {
            _spawnedUnits pushBack _x;
            _AISkillUnitsArray pushBack _x;
        } foreach (units _infantryGroup);
    };
};

//-------------------------------------------------- AT groups
if (_ATGroupsSetting) then {
    for "_x" from 1 to _ATGroupsAmount do {
   private  _spawnPos = [_AOpos, 100, 900, 3, 0, 0.7, 0] call BIS_fnc_findSafePos;
        private _infantryGroup = [_spawnPos, EAST, (configfile InfantryGroupsCFGPATH (selectRandom ATGroupsList))] call BIS_fnc_spawnGroup;
         _infantryGroup enableDynamicSimulation true;

       [_infantryGroup, _AOpos, _radiusSize / 2] call  BIS_fnc_taskPatrol;

        {
            _spawnedUnits pushBack _x;
            _AISkillUnitsArray pushBack _x;
        } foreach (units _infantryGroup);
    };
};

///////////////////////sniperteam///////////////////////////
for "_x" from 0 to 2 do {
	_randomPos = [_AOpos, 950, 200, 20] call BIS_fnc_findOverwatch;
	_smSniperTeam = [_randomPos, EAST, (configfile >> "CfgGroups" >> "East" >> "OPF_F" >> "Infantry" >> "OI_SniperTeam")] call BIS_fnc_spawnGroup;
	_smSniperTeam setBehaviour "COMBAT";
	_smSniperTeam setCombatMode "RED";
	 _smSniperTeam enableDynamicSimulation true;

	    {
            _spawnedUnits pushBack _x;
            _AISkillUnitsArray pushBack _x;
        } foreach (units _smSniperTeam);
};
///////////static//////////////////////////////////////////////////

for "_x" from 0 to 3 do {
	_staticGroup = createGroup east;
	_randomPos = [_AOpos, 600, 10, 10] call BIS_fnc_findOverwatch;
_static = [STATIC_TYPE] call BIS_fnc_selectRandom createVehicle _randomPos;
	waitUntil{!isNull _static};	
	_static setDir random 360;
		"O_support_MG_F" createUnit [_randomPos,_staticGroup];
		((units _staticGroup) select 0) assignAsGunner _static;
		((units _staticGroup) select 0) moveInGunner _static;
	_staticGroup setBehaviour "COMBAT";
	_staticGroup setCombatMode "RED";
	_static lock 3;

      {
            _spawnedUnits pushBack _x;
            _AISkillUnitsArray pushBack _x;
        } foreach (units _staticGroup);

      {
            _spawnedUnits pushBack _x;
            _AISkillUnitsArray pushBack _x;
        } foreach (units _static);

};
//-------------------------------------------------- Indoors infantry
if (_urbanInfantrySetting) then {
    for "_x" from 1 to 3 do {


		private _group = createGroup resistance;
		for "_x" from 1 to 8 do {
			_unitArray = (missionconfigfile >> "unitList" >> "bandits" >> "units") call BIS_fnc_getCfgData;
			_unit = _unitArray call BIS_fnc_selectRandom;
			_grpMember = _group createUnit [_unit, _AOpos, [], 0, "FORM"];
            _grpMember enableDynamicSimulation true;
		};
        private _returnedUnits = [_AOpos, nil, (units _group), (200), 2, false] call derp_fnc_AIOccupyBuilding;

        { deleteVehicle _x } foreach _returnedUnits;

        {
            _spawnedUnits pushBack _x;
            _AISkillUnitsArray pushBack _x;
        } foreach (units _group);
    };
};




//-------------------------------------------------- Indoors infantry
//--------------------mad---dog-----------------------------------
private ["_air"];
if((10 <= 10)) then {
	_airGroup = createGroup east;
	private _randomPos =  [_AOpos, 3000, 4000, 3, 0, 20, 0] call BIS_fnc_findSafePos;
	private _air = "O_Heli_Attack_02_F" createVehicle [_randomPos select 0,_randomPos select 1,1000];
   // _AAVicList = (missionconfigfile >> "unitList" >> MainFaction >> "AAvic") call BIS_fnc_getCfgData;
    // private _MRAP = (selectRandom MRAPList) createVehicle _spawnPos;
	waitUntil{!isNull _air};
	_air engineOn true;
	_air setPos [_randomPos select 0,_randomPos select 1,300];

	_air spawn
	{
		private["_x"];
		for [{_x=0},{_x<=200},{_x=_x+1}] do
		{
			_this setVelocity [0,0,0];
			sleep 0.1;
		};
	};

		"O_helipilot_F" createUnit [_randomPos,_airGroup];
		((units _airGroup) select 0) assignAsDriver _air;
		((units _airGroup) select 0) moveInDriver _air;
		"O_helipilot_F" createUnit [_randomPos,_airGroup];
		((units _airGroup) select 1) assignAsGunner _air;
		((units _airGroup) select 1) moveInGunner _air;

      _spawnedUnits pushBack _air;

        {
            _spawnedUnits pushBack _x;
        } foreach (crew _air);

        private _group = group _air;
    [_airGroup, _AOpos, 3000] call BIS_fnc_taskPatrol;
//[_airGroup, getMarkerPos _AOpos, 2000] call BIS_fnc_taskPatrol;
	//[(units _airGroup)] call QS_fnc_setSkill2;
	_air flyInHeight 300;
	_airGroup setCombatMode "RED";
	_air lock 3;

		

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
