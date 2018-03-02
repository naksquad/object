 //nasty code plus nasty badass ai will be fun aka nak
 private _claws = ["Chelonisi_Camp"];
 currentAOFL = _claws call BIS_fnc_selectRandom;  
 sleep 5; 
 _pos = getMarkerPos currentAOFL; _mainUnits = [_pos, [true, true, true, true, true, true, true, true]] call derp_fnc_jumeaux;

 // now let tell some folks about what poppin lets lie lol about ai skill ----------------------------

 // Breifing and Markers ---------------------------
{_x setMarkerPos (getMarkerPos currentAOFL);} forEach ["sideMarker","jetaime"];
sideMarkerText = "Secure Chelonisi Camp";
"sideMarker" setMarkerText "Side Mission: Secure Chelonisi Camp";
[west,["tankTask"],["We have gotten reports that OpFor have sent some Spetsnaz at the Chelonisi Camp. Get over there and kill them all Private. Be careful, our operatives have said that those Spetsnaz are powerful as the Seals.","Side Mission: Secure Chelonisi Camp","jetaime"],(getMarkerPos "jetaime"),0,0,true,"target",true] call BIS_fnc_taskCreate;
sideMarkerText = "Secure Chelonisi Camp";
	sleep 10;

			Treshold = createTrigger ["EmptyDetector", getMarkerPos currentAOFL];
			Treshold setTriggerArea [800, 800, 0, false];
			Treshold setTriggerActivation ["GUER", "PRESENT", false];
			Treshold setTriggerStatements ["this","",""];
	

waitUntil {sleep 5;(count list Treshold < 5)};

deleteVehicle Treshold;

//[] call AW_fnc_SMhintSUCCESS;
sleep 10;
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
{ _x setMarkerPos [-10000,-10000,-10000]; } forEach ["sideMarker", "jetaime"];
["tankTask", "SUCCEEDED",true] call BIS_fnc_taskSetState;
sleep 5;
["tankTask",west] call bis_fnc_deleteTask;