// Original pilotcheck by Kamaradski [AW]. 
// Since then been tweaked by many hands!
// Notable contributors: chucky [allFPS], Quiksilver.

_pilots = ["B_Helipilot_F"];
_aircraft_nocopilot = ["B_Heli_Light_01_F","B_Heli_Transport_01_camo_F", "B_Heli_Transport_01_F", "I_Heli_Transport_02_F", "O_Heli_Light_02_F", "O_Heli_Light_02_unarmed_F", "B_Heli_Light_01_armed_F","B_Heli_Transport_03_F", "I_Heli_light_03_unarmed_F",
"O_T_VTOL_02_infantry_F", "B_Heli_Transport_03_unarmed_F", "B_T_VTOL_01_infantry_F", "C_Heli_Light_01_civil_F", "O_Heli_Attack_02_black_F", "O_Heli_Transport_04_bench_F","O_Heli_Light_02_v2_F","B_T_VTOL_01_armed_F","B_T_VTOL_01_vehicle_F"];
_RestrictLandSea = ["B_Truck_01_mover_F"];
waitUntil {player == player};

_iampilot = ({typeOf player == _x} count _pilots) > 0;

_uid = getPlayerUId player;
if (_uid in nastyfunction) exitWith {};
while { true } do {
	_oldvehicle = vehicle player;
	waitUntil {vehicle player != _oldvehicle};

	if(vehicle player != player) then {
		_veh = vehicle player;

		//------------------------------ pilot can be pilot seat only
		
		if((_veh isKindOf "Helicopter" || _veh isKindOf "Plane") && !(_veh isKindOf "ParachuteBase")) then {
			if(({typeOf _veh == _x} count _aircraft_nocopilot) > 0) then {
				_forbidden = [_veh turretUnit [0]];
				if(player in _forbidden) then {
					if (!_iampilot) then {
						systemChat "Co-pilot is disabled on this vehicle";
						player action ["getOut",_veh];
					};
				};
			};
			if(!_iampilot) then {
				_forbidden = [driver _veh];
				if (player in _forbidden) then {
					systemChat "You must be a pilot to fly this aircraft";
					player action ["getOut", _veh];
				};
			};
	
		};
			private "_v","_t";
			_v = vehicle player;
			_t = typeof _v;
		if(!_iampilot) then {
		if (_t in _RestrictLandSea) then {
			if ((driver _v == player) or (gunner _v == player)) then {
				player action ["eject", _v];
				waitUntil {sleep 0.5; vehicle player == player};
				player action ["engineOff", _v];
				hint "Authorized 2nd RB Drivers\Pilot Only!";
			};
		};
		};
	};
};

