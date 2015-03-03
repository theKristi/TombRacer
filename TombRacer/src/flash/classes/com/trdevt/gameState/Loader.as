package com.trdevt.gameState 
{

	/**
	 * ...
	 * @author Sawyer
	 */
	public class Loader
	{
		//singleton code here
		private var _loader:Loader = null;
		private static const _instance			:Loader = new Loader( SingletonLock );		
		
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
		
		[Embed(source = '../../../../../images/Levels/TileMaps/Level0/Platforms.csv', mimeType = 'application/octet-stream')]private static var j:Class;
		[Embed(source = '../../../../../images/Levels/TileMaps/Level1/Platforms.csv', mimeType = 'application/octet-stream')]private static var k:Class;		
		[Embed(source = '../../../../../images/Levels/TileMaps/Level2/Platforms.csv', mimeType = 'application/octet-stream')]private static var l:Class;		
		[Embed(source = '../../../../../images/Levels/TileMaps/Level3/Platforms.csv', mimeType = 'application/octet-stream')]private static var m:Class;		
		[Embed(source = '../../../../../images/Levels/TileMaps/Level4/Platforms.csv', mimeType = 'application/octet-stream')]private static var n:Class;		
		[Embed(source = '../../../../../images/Levels/TileMaps/Level5/Platforms.csv', mimeType = 'application/octet-stream')]private static var o:Class;		
		[Embed(source = '../../../../../images/Levels/TileMaps/Level6/Platforms.csv', mimeType = 'application/octet-stream')]private static var p:Class;		
		[Embed(source = '../../../../../images/Levels/TileMaps/Level7/Platforms.csv', mimeType = 'application/octet-stream')]private static var q:Class;		
		[Embed(source = '../../../../../images/Levels/TileMaps/Level8/Platforms.csv', mimeType = 'application/octet-stream')]private static var r:Class;		

		public function Loader($lock:Class) 
		{
			if ($lock != SingletonLock)
				throw new Error("Loader is a singleton and should not be instantiated. Use Loader.instance instead");
				
				
		}
		
		public function init():void 
		{			
			trace("initializing the Loader!");
			
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
	
			listMap[0] = j;
			listMap[1] = k;
			listMap[2] = l;
			listMap[3] = m;
			listMap[4] = n;
			listMap[5] = o;
			listMap[6] = p;
			listMap[7] = q;
			listMap[8] = r;
			
			
		}

		public static function get instance():Loader
		{			
			return _instance;
		}

		//public function Loader():void
		//{
			//
			//listSet = new Array(9);
			//listSet[0] = aaa;
			//listSet[1] = bbb;
			//listSet[2] = ccc;
			//listSet[3] = ddd;
			//listSet[4] = eee;
			//listSet[5] = fff;
			//listSet[6] = ggg;
			//listSet[7] = hhh;
			//listSet[8] = iii;
//
			//listMap = new Array(9);
	//
			//listMap[0] = j;
			//listMap[1] = k;
			//listMap[2] = l;
			//listMap[3] = m;
			//listMap[4] = n;
			//listMap[5] = o;
			//listMap[6] = p;
			//listMap[7] = q;
			//listMap[8] = r;
			//
			//
		//}

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
		 * @param	type - 0 for platforms, anything else for parallax
		 * @return
		 */
		public function getMap(level:int,type:int):Class
		{
			if (type == 0)
			{

				return listMap[level];
			}
			else
			{
				return paraMap;
			}
		}
		///////////////////////////////////////////////////////////////////////////////////////////////////////////////

	}

}

class SingletonLock {} // Do nothing, this is just to prevent external instantiation.
