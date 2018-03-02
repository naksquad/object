#include "unitDefines.hpp"
params ["_AOpos", "_settingsArray", ["_radiusSize", derp_PARAM_AOSize], ["_AAAVehcAmount", derp_PARAM_AntiAirAmount], ["_MRAPAmount", derp_PARAM_MRAPAmount], ["_randomVehcsAmount", derp_PARAM_RandomVehcsAmount], ["_infantryGroupsAmount", derp_PARAM_InfantryGroupsAmount], ["_AAGroupsAmount", derp_PARAM_AAGroupsAmount], ["_ATGroupsAmount", derp_PARAM_ATGroupsAmount], ["_urbanInfantryAmount", 2]];

_settingsArray params [["_AAAVehcSetting", false], ["_MRAPSetting", false], ["_randomVehcsSetting", false], ["_infantryGroupsSetting", false], ["_AAGroupsSetting", false], ["_ATGroupsSetting", false], ["_urbanInfantrySetting", false], ["_milbuildingInfantry", false]];

private _spawnedUnits = [];
private _AISkillUnitsArray = [];

//-------------------------------------------------- AA vehicles
private ["_grp1"];
if (_AAAVehcSetting) then {
    for "_x" from 1 to 1 do {
        //private _randomPos = [[[_AOpos, (_radiusSize / 1.5)], []], ["water", "out"]] call BIS_fnc_randomPos;

        private  _randomPos = [_AOpos, 1000, 3000, 3, 0, 20, 0] call BIS_fnc_findSafePos;

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
//_group enableDynamicSimulation true;
       // [_group, _AOpos, _radiusSize / 2] call BIS_fnc_taskPatrol;
      [_group,_AOpos] call BIS_fnc_taskAttack;
    
       _group setSpeedMode "LIMITED";
    };
};
//-------------------------------------------------- MRAP
private ["_grp1"];
if (_MRAPSetting) then {
    for "_x" from 1 to 1 do {
       // private _randomPos = [[[_AOpos, _radiusSize], []], ["water", "out"]] call BIS_fnc_randomPos;
         private  _randomPos = [_AOpos, 1000, 3000, 3, 0, 20, 0] call BIS_fnc_findSafePos;
		_MRAPList = (missionconfigfile >> "unitList" >> MainFaction >> "cars") call BIS_fnc_getCfgData;
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
//_group enableDynamicSimulation true;
      [_group,_AOpos] call BIS_fnc_taskAttack;
       _group setSpeedMode "LIMITED";
    };
};

//-------------------------------------------------- random vehcs
private ["_grp1"];
if (_randomVehcsSetting) then {
    for "_x" from 1 to 1 do {
       // private _randomPos = [[[_AOpos, _radiusSize], []], ["water", "out"]] call BIS_fnc_randomPos;
         private  _randomPos = [_AOpos, 1000, 3000, 3, 0, 20, 0] call BIS_fnc_findSafePos;
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
//_group enableDynamicSimulation true;
    [_group,_AOpos] call BIS_fnc_taskAttack;
     _group setSpeedMode "LIMITED";
    };
};

//-------------------------------------------------- main infantry groups
if (_infantryGroupsSetting) then {
    for "_x" from 1 to 7 do {
        private  _spawnPos = [_AOpos, 1500, 2000, 3, 0, 20, 0] call BIS_fnc_findSafePos;
		private _infantryGroup = createGroup EAST;
		for "_x" from 1 to 6 do {
			_unitArray = (missionconfigfile >> "unitList" >> MainFaction >> "units") call BIS_fnc_getCfgData;
			_unit = _unitArray call BIS_fnc_selectRandom;
			_grpMember = _infantryGroup createUnit [_unit, _spawnPos, [], 0, "FORM"];
		};
//_infantryGroup enableDynamicSimulation true;
       [_infantryGroup,_AOpos] call BIS_fnc_taskAttack;

        {
            _spawnedUnits pushBack _x;
            _AISkillUnitsArray pushBack _x;
        } foreach (units _infantryGroup);
    };
};
sleep 3;
//-------------------------------------------------- AA groups
if (_AAGroupsSetting) then {
    for "_x" from 1 to 2 do {
          private  _spawnPos = [_AOpos, 1000, 1500, 3, 0, 20, 0] call BIS_fnc_findSafePos;
        private _infantryGroup = [_spawnPos, EAST, (configfile InfantryGroupsCFGPATH (selectRandom AAGroupsList))] call BIS_fnc_spawnGroup;
//_infantryGroup enableDynamicSimulation true;
       [_infantryGroup,_AOpos] call BIS_fnc_taskAttack;

        {
            _spawnedUnits pushBack _x;
            _AISkillUnitsArray pushBack _x;
        } foreach (units _infantryGroup);
    };
};
sleep 3;
//-------------------------------------------------- AT groups
if (_ATGroupsSetting) then {
    for "_x" from 1 to 2 do {
        private  _spawnPos = [_AOpos, 1000, 1500, 3, 0, 20, 0] call BIS_fnc_findSafePos;
        private _infantryGroup = [_spawnPos, EAST, (configfile InfantryGroupsCFGPATH (selectRandom ATGroupsList))] call BIS_fnc_spawnGroup;
//_infantryGroup enableDynamicSimulation true;
       [_infantryGroup,_AOpos] call BIS_fnc_taskAttack;

        {
            _spawnedUnits pushBack _x;
            _AISkillUnitsArray pushBack _x;
        } foreach (units _infantryGroup);
    };
};

//-------------------------------------------------- Indoors infantry

///////////////////////sniperteam///////////////////////////
for "_x" from 0 to 4 do {
	_randomPos = [_AOpos, 1000, 600, 20] call BIS_fnc_findOverwatch;
	_smSniperTeam = [_randomPos, EAST, (configfile >> "CfgGroups" >> "East" >> "OPF_F" >> "Infantry" >> "OI_SniperTeam")] call BIS_fnc_spawnGroup;
	_smSniperTeam setBehaviour "COMBAT";
	_smSniperTeam setCombatMode "RED";
	// _smSniperTeam enableDynamicSimulation true;

	    {
            _spawnedUnits pushBack _x;
            _AISkillUnitsArray pushBack _x;
        } foreach (units _smSniperTeam);
};
//-------------------------------------------------- Military area


//--------------------mad---dog-----------------------------------
private ["_air"];
if((10 <= 10)) then {
	_airGroup = createGroup east;
	private _randomPos =  [_AOpos, 3000, 5000, 3, 0, 20, 0] call BIS_fnc_findSafePos;
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

    [_airGroup, _AOpos, 4000] call BIS_fnc_taskPatrol;
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
