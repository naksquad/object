 //nasty code plus nasty badass ai will be fun aka nak
 private _claws = ["lhotel"];
 currentAOFL = _claws call BIS_fnc_selectRandom;  
 sleep 5; 
 _pos = getMarkerPos currentAOFL; _mainUnits = [_pos, [true, true, true, true, true, true, true, true]] call derp_fnc_wadja;

 // now let tell some folks about what poppin lets lie lol about ai skill ----------------------------

 // Breifing and Markers ---------------------------
{_x setMarkerPos (getMarkerPos currentAOFL);} forEach ["sideMarker","sideCircles"];
sideMarkerText = "Secure Hotel Resort";
"sideMarker" setMarkerText "Side Mission: Secure Hotel Resort";
[west,["tankTask"],["We have gotten reports that OpFor have sent some Spetsnaz at the Hotel Resort. Get over there and kill them all Private. Be careful, our operatives have said that those Spetsnaz are powerful as the Seals.","Side Mission: Secure Hotel Resort","sideCircles"],(getMarkerPos "sideCircles"),0,0,true,"kill",true] call BIS_fnc_taskCreate;
sideMarkerText = "Secure Hotel Resort";
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
{ _x setMarkerPos [-10000,-10000,-10000]; } forEach ["sideMarker", "sideCircles"];
["tankTask", "SUCCEEDED",true] call BIS_fnc_taskSetState;
sleep 5;
["tankTask",west] call bis_fnc_deleteTask;