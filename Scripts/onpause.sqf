disableSerialization;
waitUntil{!isNull (findDisplay 49)};
_0 = ((findDisplay 49) displayCtrl 2) ctrlEnable false;
_0 = ((findDisplay 49) displayCtrl 2) ctrlSetText "WWW.NAKSQUAD.NET";
_0 = ((findDisplay 49) displayCtrl 103) ctrlEnable false;
_0 = ((findDisplay 49) displayCtrl 103) ctrlSetText "ts3.naksquad.net";
_0 = ((findDisplay 49) displayCtrl 122) ctrlEnable false;
_0 = ((findDisplay 49) displayCtrl 122) ctrlSetText "nak anti hack online";
_0 = ((findDisplay 49) displayCtrl 523) ctrlSetText localize "STR_DOM_MISSIONSTRING_2";
_0 = ((findDisplay 49) displayCtrl 120) ctrlEnable false;
_0 = ((findDisplay 49) displayCtrl 120) ctrlSetText localize "STR_DOM_MISSIONSTRING_3";
waitUntil{isNull (findDisplay 49)}
