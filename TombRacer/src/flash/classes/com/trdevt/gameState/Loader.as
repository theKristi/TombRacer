package com.trdevt.gameState 
{

	/**
	 * ...
	 * @author Sawyer
	 */
	public class Loader
	{
		public var listSet:Array;
		public var listMap:Array;

		[Embed(source = '../../../../../images/Levels/TileSets/TileSet_Main.png')]private static var _tileSet:Class;

		[Embed(source = '../../../../../images/Levels/TileSets/Background0.png')]private static var aaa:Class;
		[Embed(source = '../../../../../images/Levels/TileSets/Background1.png')]private static var bbb:Class;
		[Embed(source = '../../../../../images/Levels/TileSets/Background2.png')]private static var ccc:Class;
		[Embed(source = '../../../../../images/Levels/TileSets/Background3.png')]private static var ddd:Class;
		[Embed(source = '../../../../../images/Levels/TileSets/Background4.png')]private static var eee:Class;
		[Embed(source = '../../../../../images/Levels/TileSets/Background5.png')]private static var fff:Class;
		[Embed(source = '../../../../../images/Levels/TileSets/Background6.png')]private static var ggg:Class;
		[Embed(source = '../../../../../images/Levels/TileSets/Background7.png')]private static var hhh:Class;
		[Embed(source = '../../../../../images/Levels/TileSets/Background8.png')]private static var iii:Class;

		[Embed(source = '../../../../../images/Levels/TileMaps/Background.csv', mimeType = 'application/octet-stream')]private static var paraMap:Class;

		[Embed(source = '../../../../../images/Levels/TileMaps/Level0/Platforms.csv', mimeType = 'application/octet-stream')]private static var jp:Class;
		[Embed(source = '../../../../../images/Levels/TileMaps/Level0/Spikes.csv', mimeType = 'application/octet-stream')]private static var jspike:Class;
		[Embed(source = '../../../../../images/Levels/TileMaps/Level0/Lava.csv', mimeType = 'application/octet-stream')]private static var jlava:Class;
		[Embed(source = '../../../../../images/Levels/TileMaps/Level0/Sand.csv', mimeType = 'application/octet-stream')]private static var jsand:Class;
		[Embed(source = '../../../../../images/Levels/TileMaps/Level0/Moss.csv', mimeType = 'application/octet-stream')]private static var jmoss:Class;
		[Embed(source = '../../../../../images/Levels/TileMaps/Level0/Plates.csv', mimeType = 'application/octet-stream')]private static var jplate:Class;
		
		[Embed(source = '../../../../../images/Levels/TileMaps/Level1/Platforms.csv', mimeType = 'application/octet-stream')]private static var kp:Class;
		[Embed(source = '../../../../../images/Levels/TileMaps/Level1/Spikes.csv', mimeType = 'application/octet-stream')]private static var kspike:Class;
		[Embed(source = '../../../../../images/Levels/TileMaps/Level1/Lava.csv', mimeType = 'application/octet-stream')]private static var klava:Class;
		[Embed(source = '../../../../../images/Levels/TileMaps/Level1/Sand.csv', mimeType = 'application/octet-stream')]private static var ksand:Class;
		[Embed(source = '../../../../../images/Levels/TileMaps/Level1/Moss.csv', mimeType = 'application/octet-stream')]private static var kmoss:Class;
		[Embed(source = '../../../../../images/Levels/TileMaps/Level1/Plates.csv', mimeType = 'application/octet-stream')]private static var kplate:Class;
		
		[Embed(source = '../../../../../images/Levels/TileMaps/Level2/Platforms.csv', mimeType = 'application/octet-stream')]private static var lp:Class;
		[Embed(source = '../../../../../images/Levels/TileMaps/Level2/Spikes.csv', mimeType = 'application/octet-stream')]private static var lspike:Class;
		[Embed(source = '../../../../../images/Levels/TileMaps/Level2/Lava.csv', mimeType = 'application/octet-stream')]private static var llava:Class;
		[Embed(source = '../../../../../images/Levels/TileMaps/Level2/Sand.csv', mimeType = 'application/octet-stream')]private static var lsand:Class;
		[Embed(source = '../../../../../images/Levels/TileMaps/Level2/Moss.csv', mimeType = 'application/octet-stream')]private static var lmoss:Class;
		[Embed(source = '../../../../../images/Levels/TileMaps/Level2/Plates.csv', mimeType = 'application/octet-stream')]private static var lplate:Class;
		
		[Embed(source = '../../../../../images/Levels/TileMaps/Level3/Platforms.csv', mimeType = 'application/octet-stream')]private static var mp:Class;
		[Embed(source = '../../../../../images/Levels/TileMaps/Level3/Spikes.csv', mimeType = 'application/octet-stream')]private static var mspike:Class;
		[Embed(source = '../../../../../images/Levels/TileMaps/Level3/Lava.csv', mimeType = 'application/octet-stream')]private static var mlava:Class;
		[Embed(source = '../../../../../images/Levels/TileMaps/Level3/Sand.csv', mimeType = 'application/octet-stream')]private static var msand:Class;
		[Embed(source = '../../../../../images/Levels/TileMaps/Level3/Moss.csv', mimeType = 'application/octet-stream')]private static var mmoss:Class;
		[Embed(source = '../../../../../images/Levels/TileMaps/Level3/Plates.csv', mimeType = 'application/octet-stream')]private static var mplate:Class;
		
		[Embed(source = '../../../../../images/Levels/TileMaps/Level4/Platforms.csv', mimeType = 'application/octet-stream')]private static var np:Class;
		[Embed(source = '../../../../../images/Levels/TileMaps/Level4/Spikes.csv', mimeType = 'application/octet-stream')]private static var nspike:Class;
		[Embed(source = '../../../../../images/Levels/TileMaps/Level4/Lava.csv', mimeType = 'application/octet-stream')]private static var nlava:Class;
		[Embed(source = '../../../../../images/Levels/TileMaps/Level4/Sand.csv', mimeType = 'application/octet-stream')]private static var nsand:Class;
		[Embed(source = '../../../../../images/Levels/TileMaps/Level4/Moss.csv', mimeType = 'application/octet-stream')]private static var nmoss:Class;
		[Embed(source = '../../../../../images/Levels/TileMaps/Level4/Plates.csv', mimeType = 'application/octet-stream')]private static var nplate:Class;
		
		[Embed(source = '../../../../../images/Levels/TileMaps/Level5/Platforms.csv', mimeType = 'application/octet-stream')]private static var op:Class;
		[Embed(source = '../../../../../images/Levels/TileMaps/Level5/Spikes.csv', mimeType = 'application/octet-stream')]private static var ospike:Class;
		[Embed(source = '../../../../../images/Levels/TileMaps/Level5/Lava.csv', mimeType = 'application/octet-stream')]private static var olava:Class;
		[Embed(source = '../../../../../images/Levels/TileMaps/Level5/Sand.csv', mimeType = 'application/octet-stream')]private static var osand:Class;
		[Embed(source = '../../../../../images/Levels/TileMaps/Level5/Moss.csv', mimeType = 'application/octet-stream')]private static var omoss:Class;
		[Embed(source = '../../../../../images/Levels/TileMaps/Level5/Plates.csv', mimeType = 'application/octet-stream')]private static var oplate:Class;
		
		[Embed(source = '../../../../../images/Levels/TileMaps/Level6/Platforms.csv', mimeType = 'application/octet-stream')]private static var pp:Class;
		[Embed(source = '../../../../../images/Levels/TileMaps/Level6/Spikes.csv', mimeType = 'application/octet-stream')]private static var pspike:Class;
		[Embed(source = '../../../../../images/Levels/TileMaps/Level6/Lava.csv', mimeType = 'application/octet-stream')]private static var plava:Class;
		[Embed(source = '../../../../../images/Levels/TileMaps/Level6/Sand.csv', mimeType = 'application/octet-stream')]private static var psand:Class;
		[Embed(source = '../../../../../images/Levels/TileMaps/Level6/Moss.csv', mimeType = 'application/octet-stream')]private static var pmoss:Class;
		[Embed(source = '../../../../../images/Levels/TileMaps/Level6/Plates.csv', mimeType = 'application/octet-stream')]private static var pplate:Class;
		
		[Embed(source = '../../../../../images/Levels/TileMaps/Level7/Platforms.csv', mimeType = 'application/octet-stream')]private static var qp:Class;
		[Embed(source = '../../../../../images/Levels/TileMaps/Level7/Spikes.csv', mimeType = 'application/octet-stream')]private static var qspike:Class;
		[Embed(source = '../../../../../images/Levels/TileMaps/Level7/Lava.csv', mimeType = 'application/octet-stream')]private static var qlava:Class;
		[Embed(source = '../../../../../images/Levels/TileMaps/Level7/Sand.csv', mimeType = 'application/octet-stream')]private static var qsand:Class;
		[Embed(source = '../../../../../images/Levels/TileMaps/Level7/Moss.csv', mimeType = 'application/octet-stream')]private static var qmoss:Class;
		[Embed(source = '../../../../../images/Levels/TileMaps/Level7/Plates.csv', mimeType = 'application/octet-stream')]private static var qplate:Class;
		
		[Embed(source = '../../../../../images/Levels/TileMaps/Level8/Platforms.csv', mimeType = 'application/octet-stream')]private static var rp:Class;
		[Embed(source = '../../../../../images/Levels/TileMaps/Level8/Spikes.csv', mimeType = 'application/octet-stream')]private static var rspike:Class;
		[Embed(source = '../../../../../images/Levels/TileMaps/Level8/Lava.csv', mimeType = 'application/octet-stream')]private static var rlava:Class;
		[Embed(source = '../../../../../images/Levels/TileMaps/Level8/Sand.csv', mimeType = 'application/octet-stream')]private static var rsand:Class;
		[Embed(source = '../../../../../images/Levels/TileMaps/Level8/Moss.csv', mimeType = 'application/octet-stream')]private static var rmoss:Class;
		[Embed(source = '../../../../../images/Levels/TileMaps/Level8/Plates.csv', mimeType = 'application/octet-stream')]private static var rplate:Class;
		

		public function Loader():void
		{
			var coder:String = "jklmnopqrstuvwxyz";
			
			listSet = new Array(9);
			listSet[0] = aaa;
			listSet[1] = bbb;
			listSet[2] = ccc;
			listSet[3] = ddd;
			listSet[4] = eee;
			listSet[5] = fff;
			listSet[6] = ggg;
			listSet[7] = hhh;
			listSet[8] = iii;

			listMap = new Array(9);
			for (var count:int = 0; count < 9; count++)
			{
				listMap[count] = new Array(9);
				//listMap[count][0] = Loader.class.getField(coder.charAt(count) + "p");
			}
			listMap[0][0] = jp;
			listMap[0][1] = jspike;
			listMap[0][2] = jlava;
			listMap[0][3] = jsand; 
			listMap[0][4] = jmoss; 
			listMap[0][5] = jplate;
			
			listMap[1][0] = kp;
			listMap[1][1] = kspike;
			listMap[1][2] = klava;
			listMap[1][3] = ksand; 
			listMap[1][4] = kmoss; 
			listMap[1][5] = kplate;
			
			listMap[2][0] = lp;
			listMap[2][1] = lspike;
			listMap[2][2] = llava;
			listMap[2][3] = lsand; 
			listMap[2][4] = lmoss; 
			listMap[2][5] = lplate;
			
			listMap[3][0] = mp;
			listMap[3][1] = mspike;
			listMap[3][2] = mlava;
			listMap[3][3] = msand; 
			listMap[3][4] = mmoss; 
			listMap[3][5] = mplate;
			
			listMap[4][0] = np;
			listMap[4][1] = nspike;
			listMap[4][2] = nlava;
			listMap[4][3] = nsand; 
			listMap[4][4] = nmoss; 
			listMap[4][5] = nplate;
			
			listMap[5][0] = op;
			listMap[5][1] = ospike;
			listMap[5][2] = olava;
			listMap[5][3] = osand; 
			listMap[5][4] = omoss; 
			listMap[5][5] = oplate;
			
			listMap[6][0] = pp;
			listMap[6][1] = pspike;
			listMap[6][2] = plava;
			listMap[6][3] = psand; 
			listMap[6][4] = pmoss; 
			listMap[6][5] = pplate;
			
			listMap[7][0] = qp;
			listMap[7][1] = qspike;
			listMap[7][2] = qlava;
			listMap[7][3] = qsand; 
			listMap[7][4] = qmoss; 
			listMap[7][5] = qplate;
			
			listMap[8][0] = rp;
			listMap[8][1] = rspike;
			listMap[8][2] = rlava;
			listMap[8][3] = rsand; 
			listMap[8][4] = rmoss; 
			listMap[8][5] = rplate;
			
		}

		/**
		 * gets the tile set
		 * @param	level
		 * @param	type - 0 for platforms, 1 for parallax background
		 * @return
		 */
		public function getSet(level:int,type:int):Class
		{
			if (type == 0)
			{
				return _tileSet;
			}
			else
			{
				return listSet[level];
			}
		}

		/**
		 * gets the tile map
		 * @param	level
		 * @param	type - -1 for parallax, 0 for platforms, 1 for spikes, 2 for lava, 3 for sand, 5 for moss, 6 for pressure plate
		 * @return
		 */
		public function getMap(level:int,type:int):Class
		{
			if (type != -1)
			{

				return listMap[level][type];
			}
			else
			{
				return paraMap;
			}
		}
		///////////////////////////////////////////////////////////////////////////////////////////////////////////////

	}

}