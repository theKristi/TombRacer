package com.trdevt.gameState 
{
	import com.trdevt.sprites.Hero;
	import org.flixel.FlxButton;
	import org.flixel.FlxG;
	import org.flixel.FlxText;
	import org.flixel.FlxTilemap;
	/**
	 * ...
	 * @author Jake
	 */
	public class TestState extends AbstractState
	{
		[Embed(source = '../../../../../images/Levels/TileSets/TileSet_Main.png')]private static var _testTiles:Class;
		
		[Embed(source = '../../../../../images/Levels/TileMaps/MovementMap.csv', mimeType = 'application/octet-stream')]private static var _testMap:Class;
		//Current TileMaps:  -Sawyer
		//Level2		Needs to be fixed, wrong resolution
		//Level4		Fixed, end inaccessible until collision with transparency is disabled
		//MovementMap	Use this to test player movement, will update with a whip section upon addition
		protected var _player:Hero;
		
		private var _collisionMap:FlxTilemap;
		
		public function TestState(xmlTree:XML):void 
		{
			super(xmlTree);
		}
		
		override public function create():void 
		{
			super.create();
			
			trace("test");
			
			var text:FlxText = new FlxText(10, 10, 100, "Testing!");
			
			FlxG.bgColor = FlxG.BLUE;
			//FlxG.mouse.show();
			//Mouse.hide();
			
			
			_collisionMap = new FlxTilemap();
			
			_collisionMap.loadMap(new _testMap(), _testTiles, 32, 32);
			add(_collisionMap);
			
			
			
			
			//_player = new Hero(32*(14), 32*(4));
			
			add(_player);
			
			add(new FlxButton(.9 * FlxG.width, .9 * FlxG.height, "Result Test", onResultClick));
		}
		
		override public function update():void 
		{
			super.update();
			
			FlxG.collide(_player, _collisionMap);
			
		}
		
		protected function onResultClick():void 
		{
			FlxG.switchState(new ResultsState());
		}
		
		///////////////////////////////////////////////////////////////////////////////////////////////////////////////
		
		/**
		 * builds test state from data in the xml tree
		 * @param	xmlTree
		 */
		override protected function parseXML(xmlTree:XML):void 
		{
			var xTile:Number;
			var yTile:Number;
			var heroXmlTree:XML;
			
			xTile = xmlTree.levels.levelTest.heroPosition.@["x"];
			yTile = xmlTree.levels.levelTest.heroPosition.@["y"];
			
			heroXmlTree = new XML(xmlTree.hero.toXMLString());
			
			//trace("TestState->parseXML test: " + xmlTree);
			//trace("parsing xml for TestState. x: " + xTile+", y:" + yTile+", hero xml tree:#" +heroXmlTree+"#");
			
			_player = new Hero(heroXmlTree, 32 * xTile, 32 * yTile);
			
			//_player = new Hero(32*(14), 32*(4));
		}
		
		///////////////////////////////////////////////////////////////////////////////////////////////////////////////
		
	}

}