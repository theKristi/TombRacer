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

		[Embed(source = '../../../../../images/Levels/TileSets/Background0.png')]private static var a:Class;
		[Embed(source = '../../../../../images/Levels/TileSets/Background1.png')]private static var b:Class;
		[Embed(source = '../../../../../images/Levels/TileSets/Background2.png')]private static var c:Class;
		[Embed(source = '../../../../../images/Levels/TileSets/Background3.png')]private static var d:Class;
		[Embed(source = '../../../../../images/Levels/TileSets/Background4.png')]private static var e:Class;
		[Embed(source = '../../../../../images/Levels/TileSets/Background5.png')]private static var f:Class;
		[Embed(source = '../../../../../images/Levels/TileSets/Background6.png')]private static var g:Class;
		[Embed(source = '../../../../../images/Levels/TileSets/Background7.png')]private static var h:Class;
		[Embed(source = '../../../../../images/Levels/TileSets/Background8.png')]private static var i:Class;

		[Embed(source = '../../../../../images/Levels/TileMaps/Background.csv', mimeType = 'application/octet-stream')]private static var listPara:Class;

		[Embed(source = '../../../../../images/Levels/TileMaps/Level0/Platforms.csv', mimeType = 'application/octet-stream')]private static var j:Class;
/*		[Embed(source = '../../../../../images/Levels/TileMaps/Level0/Spikes.csv', mimeType = 'application/octet-stream')]private static var j:Class;
		[Embed(source = '../../../../../images/Levels/TileMaps/Level0/Lava.csv', mimeType = 'application/octet-stream')]private static var j:Class;
		[Embed(source = '../../../../../images/Levels/TileMaps/Level0/Sand.csv', mimeType = 'application/octet-stream')]private static var j:Class;
		[Embed(source = '../../../../../images/Levels/TileMaps/Level0/Moss.csv', mimeType = 'application/octet-stream')]private static var j:Class;
		[Embed(source = '../../../../../images/Levels/TileMaps/Level0/Plates.csv', mimeType = 'application/octet-stream')]private static var j:Class;*/
		
		[Embed(source = '../../../../../images/Levels/TileMaps/Level1/Platforms.csv', mimeType = 'application/octet-stream')]private static var k:Class;
		[Embed(source = '../../../../../images/Levels/TileMaps/Level2/Platforms.csv', mimeType = 'application/octet-stream')]private static var l:Class;
		[Embed(source = '../../../../../images/Levels/TileMaps/Level3/Platforms.csv', mimeType = 'application/octet-stream')]private static var m:Class;
		[Embed(source = '../../../../../images/Levels/TileMaps/Level4/Platforms.csv', mimeType = 'application/octet-stream')]private static var n:Class;
		[Embed(source = '../../../../../images/Levels/TileMaps/Level5/Platforms.csv', mimeType = 'application/octet-stream')]private static var o:Class;
		[Embed(source = '../../../../../images/Levels/TileMaps/Level6/Platforms.csv', mimeType = 'application/octet-stream')]private static var p:Class;
		[Embed(source = '../../../../../images/Levels/TileMaps/Level7/Platforms.csv', mimeType = 'application/octet-stream')]private static var q:Class;
		[Embed(source = '../../../../../images/Levels/TileMaps/Level8/Platforms.csv', mimeType = 'application/octet-stream')]private static var r:Class;



		public function Loader():void
		{
			listSet = new Array(9);
			listSet[0] = a;
			listSet[1] = b;
			listSet[2] = c;
			listSet[3] = d;
			listSet[4] = e;
			listSet[5] = f;
			listSet[6] = g;
			listSet[7] = h;
			listSet[8] = i;

			listMap = new Array(9);
			listMap[0] = j
			listMap[1] = k
			listMap[2] = l
			listMap[3] = m
			listMap[4] = n
			listMap[5] = o
			listMap[6] = p
			listMap[7] = q
			listMap[8] = r
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
		 * @param	type - 0 for platforms, 1 for parallax background
		 * @return
		 */
		public function getMap(level:int,type:int):Class
		{
			if (type == 0)
			{
				trace("in Loader->getMap: " + listMap[level]);
				return listMap[level];
			}
			else
			{
				return listPara;
			}
		}

		///////////////////////////////////////////////////////////////////////////////////////////////////////////////

	}

}