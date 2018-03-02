private ["_mission","_missionList","_currentMission","_nextMission","_delay","_loopTimeout"];

_delay = 450;
_loopTimeout = 450;


_missionList = [
	"HQcoast",
	"HQresearch",
	"secureChopper",
	"secureRadar",
	"blackoops",
	"bright",
	"grace",
	"brighthy"
];

SM_SWITCH = true; publicVariable "SM_SWITCH";

while {missionActive} do {

	if (SM_SWITCH) then {

		hqSideChat = "Side objective assigned, stand-by for orders.";
		[hqSideChat] remoteExec ["AW_fnc_globalSideChat",0,false];


		sleep 3;

		_mission = _missionList call BIS_fnc_selectRandom;
		_currentMission = execVM format ["missions\side\%1.sqf", _mission];

		waitUntil {
			sleep 3;
			scriptDone _currentMission
		};

		sleep _delay;

		SM_SWITCH = true; publicVariable "SM_SWITCH";
	};
	sleep _loopTimeout;
};
