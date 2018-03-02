class AW
{
	tag = "AW";
	class functions
	{
		file = "functions";
	};

	class vehicleFunctions
	{
		file = "functions\Vehicle";
		class vsetup02 {};
		class vmonitor {};
		class vBasemonitor {};
		class SMhintSUCCESS {};
        class createCrew {};
	};

	class unitFunctions
	{
		file = "functions\Units";
		class setskill1 {};
		class setskill2 {};
		class setskill3 {};
		class setskill4 {};
		class setskill5 {};
        class buildingDefenders {};
        class cqbPlacement {};
		class ai_spawn {};
		class airCav {};
		class smenemyeast {};
		class smenemyeastintel {};
		class factionDefine {};
        class sideMissionEnemy {};
        class PTenemyEAST {};
		class smenemy {};
	};

	class supportFunctions
	{
		file = "functions\Supports";
		class enemycas {};
	};

	class locationFunctions
	{
		file = "functions\Location";
		class findWaterLocation {};
	};

	class messageFunctions
	{
		file = "functions\Messages";
		class globalHint {};
		class globalnotification {};
	};

	class cleanupFunctions
	{
		file = "functions\Cleanup";
		class smdelete {};
		class aodelete {};
	};

	class miscFunctions
	{
		file = "functions\Misc";
		class aoenemy {};
		class addaction {};
		class addactiongetintel {};
		class addactionsurrender {};
		class taskPatrol {};
        class smSucSwitch {};
        class billBoardTex {};
	};
	
};

class derp
{
	tag = "derp";

	class AI {
        file = "functions\AI";
        class mainAOSpawnHandler {};
		class defendAOSpawnHandler {};
		class wadja {};
		class wadjaBright {};
		class jumeaux {};
		class papa {};
        class AISkill {};
		class AIOccupyBuilding {};
		class arrayShuffle {};
		class maman {};
    };

};


class CHVD
{
	tag = "CHVD";
	class functions
	{
		file = "functions\CHVD";
		class onSliderChange {};
		class onLBSelChanged {};
		class onLBSelChanged_syncmode {};
		class onEBinput {};
		class onEBterrainInput {};
		class onEBinput_syncmode {};
		class selTerrainQuality {};
		class updateTerrain {};
		class updateSettings {};
		class updateVehType {};
		class fovViewDistance {};
		class UAVstatus {};
		class openDialog {};
		class localize {};
		class trueZoom {};
		class keyBindings {};
		class keyDown {};
		class keyDownTerrain {};
		class init {postInit = 1;};
	};
};
