//nakakanak
//victoire

////fixed wings
_planes = ["B_Plane_Fighter_01_Stealth_F","B_Plane_Fighter_01_F","O_Plane_CAS_02_dynamicLoadout_F","O_Plane_Fighter_02_F","O_Plane_Fighter_02_Stealth_F","I_Plane_Fighter_03_dynamicLoadout_F","I_Plane_Fighter_04_F"];
_attackHeli = ["B_Heli_Attack_01_dynamicLoadout_F","O_Heli_Attack_02_dynamicLoadout_F"];
_civilianHeli = ["I_Heli_Transport_02_F","I_Heli_light_03_dynamicLoadout_F","I_Heli_light_03_unarmed_F","I_C_Plane_Civil_01_F","I_C_Heli_Light_01_civil_F"];
_csatattackHeli = ["O_Heli_Light_02_dynamicLoadout_F","O_Heli_Light_02_unarmed_F","O_T_VTOL_02_infantry_dynamicLoadout_F","O_Heli_Light_02_dynamicLoadout_F","O_Heli_Light_02_unarmed_F"];
_mhnato = ["B_Heli_Light_01_F","B_Heli_Light_01_dynamicLoadout_F","B_Heli_Transport_03_unarmed_F","B_Heli_Transport_03_F","B_CTRG_Heli_Transport_01_sand_F","B_CTRG_Heli_Transport_01_tropic_F"];
_vtol = ["B_T_VTOL_01_armed_F","B_T_VTOL_01_infantry_F","B_T_VTOL_01_vehicle_F"];
_mi = ["O_Heli_Transport_04_bench_F","O_Heli_Transport_04_ammo_F","O_Heli_Transport_04_F","O_Heli_Transport_04_fuel_F","O_Heli_Transport_04_medevac_F","O_Heli_Transport_04_repair_F","O_Heli_Transport_04_covered_F"];


//plane 1  270 degrees
_neo = _planes call BIS_fnc_selectRandom;;
_heli1 = _neo createVehicle (getMarkerPos "plane1");
_heli1 setDir 130;
null = [_heli1,600,FALSE,AW_fnc_vSetup02] spawn AW_fnc_vMonitor;
//plane 2
_trinity = _planes call BIS_fnc_selectRandom;;
_heli2 = _trinity createVehicle (getMarkerPos "plane2");
_heli2 setDir 130;
null = [_heli2,2400,FALSE,AW_fnc_vSetup02] spawn AW_fnc_vMonitor;
////attacheli////
 _morpheus = _attackHeli call BIS_fnc_selectRandom;;
_heli3 = _morpheus createVehicle (getMarkerPos "attackHeli");
_heli3 setDir 40;
null = [_heli3,600,FALSE,AW_fnc_vSetup02] spawn AW_fnc_vMonitor;
////civilianHeli1////
 _agent_smith  = _civilianHeli call BIS_fnc_selectRandom;;
_heli4 = _agent_smith createVehicle (getMarkerPos "civilianHeli1");
_heli4 setDir 208;
null = [_heli4,300,FALSE,AW_fnc_vSetup02] spawn AW_fnc_vMonitor;
////civilianHeli2////
 _agent_smith1  = _civilianHeli call BIS_fnc_selectRandom;;
_heli5 = _agent_smith1 createVehicle (getMarkerPos "civilianHeli2");
_heli5 setDir 185;
null = [_heli5,300,FALSE,AW_fnc_vSetup02] spawn AW_fnc_vMonitor;
////civilianHeli2////
 _agent_smith2  = _civilianHeli call BIS_fnc_selectRandom;;
_heli6 = _agent_smith2 createVehicle (getMarkerPos "civilianHeli3");
_heli6 setDir 150;
null = [_heli6,300,FALSE,AW_fnc_vSetup02] spawn AW_fnc_vMonitor;
////cattacheli////
 _The_Oracle  = _csatattackHeli call BIS_fnc_selectRandom;;
_heli7 = _The_Oracle createVehicle (getMarkerPos "csatattackHeli1");
_heli7 setDir 195;
null = [_heli7,500,FALSE,AW_fnc_vSetup02] spawn AW_fnc_vMonitor;
////cattacheli1////
 _The_Oracle1  = _csatattackHeli call BIS_fnc_selectRandom;;
_heli8 = _The_Oracle1 createVehicle (getMarkerPos "csatattackHeli2");
_heli8 setDir 195;
null = [_heli8,500,FALSE,AW_fnc_vSetup02] spawn AW_fnc_vMonitor;
////_mhnato////
 _Sentinels  = _mhnato call BIS_fnc_selectRandom;;
_heli9 = _Sentinels createVehicle (getMarkerPos "mhnato");
_heli9 setDir 150;
null = [_heli9,300,FALSE,AW_fnc_vSetup02] spawn AW_fnc_vMonitor;
////_mhnato1////
 _Sentinels1  = _mhnato call BIS_fnc_selectRandom;;
_heli10 = _Sentinels1 createVehicle (getMarkerPos "mhnato1");
_heli10 setDir 120;
null = [_heli10,300,FALSE,AW_fnc_vSetup02] spawn AW_fnc_vMonitor;
////_vtol////
 _The_Keymaker  = _vtol call BIS_fnc_selectRandom;;
_heli11 = _The_Keymaker createVehicle (getMarkerPos "_vtol1");
_heli11 setDir 200;
null = [_heli11,2400,FALSE,AW_fnc_vSetup02] spawn AW_fnc_vMonitor;
////_mi////
 _The_Architect = _mi call BIS_fnc_selectRandom;;
_heli12 = _The_Architect createVehicle (getMarkerPos "_mi1");
_heli12 setDir 120;
null = [_heli12,300,FALSE,AW_fnc_vSetup02] spawn AW_fnc_vMonitor;