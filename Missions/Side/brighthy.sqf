 //nasty code plus nasty badass ai will be fun aka nak
 private _claws = ["Agios_Camp_2","Agios_Camp_3","Agios_Camp_4","Agios_Camp_6","Agios_Camp_7","Agios_Camp_8","Agios_Camp_9","Agios_Camp_10","Agios_Camp_11"];
 currentAOFL = _claws call BIS_fnc_selectRandom;  
 sleep 5; 
 _pos = getMarkerPos currentAOFL; _mainUnits = [_pos, [true, true, true, true, true, true, true, true]] call derp_fnc_maman;

 // now let tell some folks about what poppin lets lie lol about ai skill ----------------------------

 // Breifing and Markers ---------------------------
{_x setMarkerPos (getMarkerPos currentAOFL);} forEach ["sideMarker","bright_camp"];
sideMarkerText = "Secure Town From Rebels";
"sideMarker" setMarkerText "Side Mission: Secure Town";
[west,["tankTask"],["We have gotten reports that OpFor have sent some Rebels to the Town. Get over there and kill them all Private. Be careful, our operatives have said that those Spetsnaz are powerful as the Seals.","Side Mission: Secure Town From Rebels","bright_camp"],(getMarkerPos "bright_camp"),0,0,true,"target",true] call BIS_fnc_taskCreate;
sideMarkerText = "Secure Town From Rebels";
	sleep 10;

			Treshold = createTrigger ["EmptyDetector", getMarkerPos currentAOFL];
			Treshold setTriggerArea [800, 800, 0, false];
			Treshold setTriggerActivation ["GUER", "PRESENT", false];
			Treshold setTriggerStatements ["this","",""];
	

waitUntil {sleep 5;(count list Treshold < 5)};

deleteVehicle Treshold;

//[] call AW_fnc_SMhintSUCCESS;
sleep 20;

{
		if (!(isNull _x) && {alive _x}) then {
			deleteVehicle _x;
		};
} foreach _mainUnits;
{
	if (!(isNull _x) && {!alive _x}) then {
		deleteVehicle _x;
	};
} foreach _mainUnits;

// Debrief ----------------------------------------
{ _x setMarkerPos [-10000,-10000,-10000]; } forEach ["sideMarker", "bright_camp"];
["tankTask", "SUCCEEDED",true] call BIS_fnc_taskSetState;
sleep 5;
["tankTask",west] call bis_fnc_deleteTask;