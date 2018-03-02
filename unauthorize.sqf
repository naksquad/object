waitUntil {!isNull player};
if (local player) then
{
	_dest = "teleportDestinatio";
	_dir = random 359;
	
		if (getPlayerUID player in nastyfunction) then
		{
			
			hint format ["Welcome to NAK ELITE SQUAD HQ %2",_name, name player];
        }
			else 
		{
            player SetPos [(getMarkerPos _dest select 0)-10*sin(_dir),(getMarkerPos _dest select 1)-10*cos(_dir)];
		    titleText ["You have entered a restricted access area. You do not have permission to enter NAK SQUAD HQ, check WWW.NAKSQUAD.NET.","BLACK FADED", 1];
        	
		};
	    	
};


//76561198036205616
