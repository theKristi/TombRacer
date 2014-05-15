package com.trdevt.gameState 
{
	import com.trdevt.sprites.Hero;
	import org.flixel.FlxG;
	import org.flixel.FlxObject;
	import org.flixel.FlxSprite;
	import org.flixel.FlxState;
	import org.flixel.FlxText;
	import org.flixel.FlxTilemap;
	
	/**
	 * ...
	 * @author Jake
	 */
	public class TestState extends FlxState
	{
		[Embed(source = '../../../../../images/Levels/TileSets/TileSet_Main.png')]private static var _testTiles:Class;
		
		[Embed(source = '../../../../../images/Levels/TileMaps/TileMap_Test.csv', mimeType = 'application/octet-stream')]private static var _testMap:Class;
		
		protected var _player:Hero;
		
		private var _collisionMap:FlxTilemap;
		
		override public function create():void 
		{
			super.create();
			
			trace("test");
			
			var text = new FlxText(10, 10, 100, "Testing!");
			
			FlxG.bgColor = FlxG.BLUE;
			FlxG.mouse.show();
			
			_collisionMap = new FlxTilemap();
			
			_collisionMap.loadMap(new _testMap(), _testTiles, 32, 32);
			add(_collisionMap);
			
			_player = new Hero(32, 64+32);
			
			add(_player);
			
			//add(text);
		}
		
		override public function update():void 
		{
			super.update();
			
			
		}

		
	}

}