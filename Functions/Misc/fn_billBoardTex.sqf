/*
Author: BACONMOP
usage:
0:position to spawn
*/
params ["_billBoard"];
_imageList = [1,2,3,4,5,6,7];
_bills = _imageList call BIS_fnc_selectRandom;
if (_bills == 1) then {_billBoard setObjectTexture [0,"media\Billboards\bill5.paa"]};
if (_bills == 2) then {_billBoard setObjectTexture [0,"media\Billboards\bill6.paa"]};
if (_bills == 3) then {_billBoard setObjectTexture [0,"media\Billboards\bill7.paa"]};
if (_bills == 4) then {_billBoard setObjectTexture [0,"media\Billboards\bill6.paa"]};
if (_bills == 5) then {_billBoard setObjectTexture [0,"media\Billboards\bill5.paa"]};
if (_bills == 6) then {_billBoard setObjectTexture [0,"media\Billboards\bill6.paa"]};
if (_bills == 7) then {_billBoard setObjectTexture [0,"media\Billboards\bill7.paa"]};
