-/*
Author: Quiksilver
Last modified: 23/10/2014 ArmA 1.32 by Quiksilver
Description:

	Restricts certain weapon systems to different roles
_________________________________________________*/

private ["_backpackRestricteds","_opticsAllowed","_specialisedOptics","_optics","_basePos","_firstRun","_insideSafezone","_outsideSafezone"];


#define AUTOTUR_MSG "You are not allowed to use this weapon system, Backpack removed."
#define UAV_MSG "Only UAV operator may use this Item, UAV terminal removed."

//===== UAV TERMINAL
_uavOperator = ["B_soldier_UAV_F","B_officer_F"];
_uavRestricted = ["B_UavTerminal","O_UavTerminal","I_UavTerminal"];
//==========claws
_backpackRestricteds = ["Respawn_TentDome_F", "B_Respawn_TentDome_F", "Respawn_TentA_F", "B_Respawn_TentA_F", "Respawn_Sleeping_bag_F", "Respawn_Sleeping_bag_blue_F", "B_Respawn_Sleeping_bag_blue_F", "Respawn_Sleeping_bag_brown_F", "B_Respawn_Sleeping_bag_brown_F", "B_Respawn_Sleeping_bag_F", "B_KA_Metal_Storm_AI_AAF", "B_KA_Metal_Storm_AI_CSAT", "B_KA_Metal_Storm_AI_NATO", "B_KA_Metal_Storm_AAF", "B_KA_Metal_Storm_CSAT", "B_KA_Metal_Storm_NATO"];



while {true} do {

	//------------------------------------- UAV

    _assignedItems = assignedItems player;

	if (({"B_UavTerminal" == _x} count _assignedItems) > 0) then {
		if (({player isKindOf _x} count _uavOperator) < 1) then {
			player unassignItem "B_UavTerminal";
			player removeItem "B_UavTerminal";
			titleText [UAV_MSG,"PLAIN",3];
		};
	};
	
	
	sleep 5;
	
	
	if ((backpack player) in _backpackRestricteds) then {
		removeBackpack player;
		titleText [AUTOTUR_MSG, "PLAIN", 3];
		sleep 1;
	};
	
};
