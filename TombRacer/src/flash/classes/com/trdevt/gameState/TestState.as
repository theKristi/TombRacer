package com.trdevt.gameState 
{
	import com.trdevt.sprites.Hero;
	import flash.ui.Mouse;
	import org.flixel.FlxG;
	import org.flixel.FlxObject;
	import org.flixel.FlxSprite;
	import org.flixel.FlxState;
	import org.flixel.FlxText;
	import org.flixel.FlxTilemap;
	import org.flixel.FlxButton;
	/**
	 * ...
	 * @author Jake
	 */
	public class TestState extends FlxState
	{
		[Embed(source = '../../../../../images/Levels/TileSets/TileSet_Main.png')]private static var _testTiles:Class;
		
		[Embed(source = '../../../../../images/Levels/TileMaps/Level4.csv', mimeType = 'application/octet-stream')]private static var _testMap:Class;
		
		protected var _player:Hero;
		
		private var _collisionMap:FlxTilemap;
		
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
			
			_player = new Hero(32*(14), 32*(4));
			
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
		
	}

}