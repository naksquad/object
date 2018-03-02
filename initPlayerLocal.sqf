/*
Author:

	BACONMOP

Description:

	Things that may run on both server.
	Deprecated initialization file.
______________________________________________________*/

enableSaving false;
enableSentences false;
waitUntil {time > 0};
enableEnvironment [false, true];

_respawnWest = getMarkerPos "respawn_west";
"ProtectionZone_Invisible_F" createVehicle _respawnWest;

CHVD_allowNfoGrass = true; 


//------------------- client executions

_null = [] execVM "scripts\misc\QS_icons.sqf";									// Icons
_null = [] execVM "scripts\pilotCheck.sqf"; 									// pilots only
_null = [] execVM "scripts\misc\earplugs.sqf";									//Earplugs from the start
_null = [] execVM "scripts\restrictions.sqf";	
//------------------ SafeZone
//------------------- Disable Arty Computer for all but FSG
enableEngineArtillery false;
if (player isKindOf "B_support_Mort_f") then {
	enableEngineArtillery true;
};


player addEventHandler ["Fired", {
	params ["_unit", "_weapon", "", "", "", "", "_projectile"];
	if (_unit distance2D (getMarkerPos "respawn_pilot") < 900) then {
		deleteVehicle _projectile;
		hintC "Don't goof at base. Hold your horses soldier, don't throw, fire or place anything inside the base.";
	}}];



//------------------ BIS groups
["InitializePlayer", [player, true]] call BIS_fnc_dynamicGroups;

[missionNamespace, "arsenalClosed", {	
	player setVariable ["Saved_Loadout",getUnitLoadout player];
	hint "gear saved !"
}] call BIS_fnc_addScriptedEventHandler;
[billboard_1] call AW_fnc_billBoardTex;
[billboard_2] call AW_fnc_billBoardTex;
[billboard_3] call AW_fnc_billBoardTex;
[billboard_4] call AW_fnc_billBoardTex;
[billboard_5] call AW_fnc_billBoardTex;
[billboard_6] call AW_fnc_billBoardTex;
[billboard_7] call AW_fnc_billBoardTex;
[billboard_8] call AW_fnc_billBoardTex;
[billboard_9] call AW_fnc_billBoardTex;
[billboard_10] call AW_fnc_billBoardTex;
waitUntil {!isNull (findDisplay 46)};
sleep 5;
[
	[
		[localize "STR_DOM_MISSIONSTRING_0","<t size='1.0' font='RobotoCondensed'>%1</t><br/>", 0],
		[name player,"<t size='1.0' font='RobotoCondensed'>%1</t><br/>", 5],
		[localize "STR_DOM_MISSIONSTRING_1","<t size='0.9'>%1</t><br/>", 27]
	],
	-safezoneX,0.85,"<t color='#FFFFFFFF' align='right'>%1</t>"
] spawn bis_fnc_typeText;

