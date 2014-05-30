package com.trdevt.gameState 
{
	import com.trdevt.sprites.Hero;
	import com.trdevt.sprites.HeroStates;
	import com.trdevt.sprites.obstacles.ArrowObstacle;
	import com.trdevt.sprites.obstacles.BatObstacle;
	import com.trdevt.sprites.obstacles.FireballObstacle;
	import com.trdevt.sprites.obstacles.Obstacle;
	import com.trdevt.util.LocalSharedObjectManager;
	import mx.core.FlexSprite;
	import org.flixel.FlxG;
	import org.flixel.FlxGroup;
	import org.flixel.FlxObject;
	import org.flixel.FlxPoint;
	import org.flixel.FlxSprite;
	import org.flixel.FlxTileblock;
	import org.flixel.FlxTilemap;
	import org.flixel.FlxTimer;
	import org.flixel.system.FlxTile;
	import org.flixel.system.*;
	import org.flixel.*;

	/**
	 * ...
	 * @author Jake
	 */
	public class PlayState extends AbstractState
	{	//spikeDeath.mp3
		[Embed(source = "../../../../../sounds/deaths/lavaDeath.mp3")] private var _lavaDeathSound:Class;
		[Embed(source = "../../../../../sounds/deaths/lavaDeath.mp3")] private var _sandSound:Class;
		[Embed(source = "../../../../../sounds/deaths/lavaDeath.mp3")] private var _mossSound:Class;
		[Embed(source = "../../../../../sounds/deaths/spikeDeath.mp3")] private var _spikeSound:Class;
		//		[Embed(source = '../../../../../images/SpriteSheets/IndieWalkSheet.png')] private static var _sheet:Class;

		
		protected var _timer:FlxTimer;
		protected var _currentLevelNum:Number;
		
		//class files will be loaded from the parse function
		protected var _tileMapCollisionFile:Class;
		protected var _tileSetCollsionFile:Class;
		protected var _tileMapCollision:FlxTilemap;
		
		protected var _fgBatCollision:FlxGroup;
		protected var _fgFireballCollision:FlxGroup;
		protected var _fgArrowCollision:FlxGroup;
		
		protected var _tileMapBackgroundFile:Class;
		protected var _tileSetBackgroundFile:Class;
		protected var _tileMapBackground:FlxTilemap;
		
		protected var _collisionTileWidth:Number;
		protected var _collisionTileHeight:Number;
		
		protected var _backgroundTileWidth:Number;
		protected var _backgroundTileHeight:Number;
		
		protected var _player:Hero;
		protected var constAccel:Number;
		protected var _playerMaxSpeedy:Number;
		
		protected var _respawnX:Number;
		protected var _respawnY:Number;
		

		
		protected var _finalScore:Number;
		
		protected var _whipCanvas:FlxSprite;
		protected var _whipCenter:FlxPoint;
		
		///////////////////////////////////////////////////////////////////////////////////////////////////////////////
		
		public function PlayState(xmlTree:XML, levelNum:Number) 
		{
			_currentLevelNum = levelNum;
			
			super(xmlTree);
			
			
		}
		
		///////////////////////////////////////////////////////////////////////////////////////////////////////////////
		
		override public function create():void 
		{
			super.create();
			
			FlxG.bgColor =  0xff0069b4; //hot pink default bg color
			
			add(_tileMapBackground);
			add(_tileMapCollision);
			
			
			_fgBatCollision = new FlxGroup(20);
			_fgFireballCollision = new FlxGroup(50);
			_fgArrowCollision = new FlxGroup(10);
			
			//Test Obstacles
			//_fgBatCollision.add(new BatObstacle(5, 5));
			//_fgBatCollision.add(new BatObstacle(3, 7));
			//_fgBatCollision.add(new BatObstacle(7, 9));
			
			//_fgArrowCollision.add(new ArrowObstacle(5, 4));
			
			//_fgFireballCollision.add(new FireballObstacle(5 , 3));
			
			add(_fgBatCollision);
			add(_fgFireballCollision);
			add(_fgArrowCollision);
			
			createWhipCanvas();
			
			add(_player);
			_player.signalHeroWhipped.add(drawWhip);
			_player.signalHeroCJump.add(removeLimit);
			
			
			
		}
		public function removeLimit():void
		{
			_player.maxVelocity.x = 100000;
		}
		
		
		override public function update():void 
		{

			super.update();
			
			if (FlxG.collide(_player, _tileMapCollision))
			{
				_player.stopSwinging();
			}
			
			
			
			
			//FlxG.overlap(_player, _fgBatCollision, onPlayerCollision);
			//FlxG.collide(_fgBatCollision, _tileMapCollision, onObstacleCollision);
			
			//FlxG.overlap(_player, _fgArrowCollision, onArrowCollision);
			//FlxG.collide(_fgArrowCollision, _tileMapCollision, onObstacleCollision);
			
			//FlxG.overlap(_player, _fgFireballCollision, onFireballCollision);
			//FlxG.collide(_fgFireballCollision, _tileMapCollision, onObstacleCollision);
			
			if (_player.state == HeroStates.HERO_SWING)
			{
				updateWhip();

			}
			else
			{
				_whipCanvas.fill(0x00000000);

			}
			if (FlxG.keys.O)
				FlxG.switchState(new ResultsState(0,_currentLevelNum));
			if (FlxG.keys.R)
				FlxG.switchState(new SelectState(new XML()));
			
			
		}
		
		
		public function onArrowCollision(arrow:ArrowObstacle, player:Hero):void
		{
			arrow.onCollision();
		}
		
		public function onFireballCollision(fireball:FireballObstacle, player:Hero):void
		{
			fireball.onCollision();
		}
		
		///////////////////////////////////////////////////////////////////////////////////////////////////////////////
		
		/**
		 * this function handles when the level is completed
		 */
		protected function levelComplete():void 
		{
			FlxG.switchState(new ResultsState(0,_currentLevelNum));
		}
		
		///////////////////////////////////////////////////////////////////////////////////////////////////////////////
		
		override protected function parseXML(xmlTree:XML):void 
		{
			_tileMapCollision = new FlxTilemap();
			_tileMapBackground = new FlxTilemap();

			var l:Loader = new Loader();

			_tileMapCollisionFile = l.getMap(_currentLevelNum, 0);
			_tileSetCollsionFile = l.getSet(_currentLevelNum, 0);
			
			_tileSetBackgroundFile = l.getSet(_currentLevelNum, 1);
			_tileMapBackgroundFile = l.getMap(_currentLevelNum, 1);
			
			
			
			_backgroundTileWidth = 1280;
			_backgroundTileHeight = 768;
			
			_collisionTileWidth = _collisionTileHeight = 32;
			
			_tileMapCollision.loadMap(new _tileMapCollisionFile(), _tileSetCollsionFile, _collisionTileWidth, _collisionTileHeight);
			
			_tileMapBackground.loadMap(new _tileMapBackgroundFile(), _tileSetBackgroundFile, _backgroundTileWidth, _backgroundTileHeight);
			
			
			// Lava Collisions
			_tileMapCollision.setTileProperties(62, FlxObject.NONE, collideLava);
			_tileMapCollision.setTileProperties(54, FlxObject.NONE);
			// Spike Collisions
			_tileMapCollision.setTileProperties(7, FlxObject.ANY, collideSpike); 
			_tileMapCollision.setTileProperties(15, FlxObject.ANY, collideSpike);
			_tileMapCollision.setTileProperties(22, FlxObject.ANY, collideSpike);
			_tileMapCollision.setTileProperties(23, FlxObject.ANY, collideSpike);
			_tileMapCollision.setTileProperties(30, FlxObject.ANY, collideSpike);
			_tileMapCollision.setTileProperties(31, FlxObject.ANY, collideSpike);
			_tileMapCollision.setTileProperties(38, FlxObject.ANY, collideSpike);
			_tileMapCollision.setTileProperties(39, FlxObject.ANY, collideSpike);
			_tileMapCollision.setTileProperties(46, FlxObject.ANY, collideSpike);
			_tileMapCollision.setTileProperties(47, FlxObject.ANY, collideSpike);
			_tileMapCollision.setTileProperties(55, FlxObject.ANY, collideSpike);
			_tileMapCollision.setTileProperties(63, FlxObject.ANY, collideSpike);
			// Moss Collisions
			_tileMapCollision.setTileProperties(51, FlxObject.ANY, collideMoss);
			_tileMapCollision.setTileProperties(52, FlxObject.ANY, collideMoss);
			_tileMapCollision.setTileProperties(53, FlxObject.ANY, collideMoss);
			// Switch Collisions
			_tileMapCollision.setTileProperties(48, FlxObject.NONE);
			_tileMapCollision.setTileProperties(49, FlxObject.NONE);
			_tileMapCollision.setTileProperties(50, FlxObject.NONE);
			// Sand Collisions
			_tileMapCollision.setTileProperties(8, FlxObject.ANY, collideSand);
			// Torch Collisions
			_tileMapCollision.setTileProperties(64, FlxObject.NONE);
			_tileMapCollision.setTileProperties(65, FlxObject.NONE, collideWaypoint);
			
			//Victory
			_tileMapCollision.setTileProperties(48, FlxObject.NONE, collideVictory);
			_tileMapCollision.setTileProperties(49, FlxObject.NONE, collideVictory);
			_tileMapCollision.setTileProperties(50, FlxObject.NONE, collideVictory);
			
			//halfblock
			_tileMapCollision.setTileProperties(1, FlxObject.NONE);
			_tileMapCollision.setTileProperties(3, FlxObject.NONE);
			_tileMapCollision.setTileProperties(9, FlxObject.NONE);
			_tileMapCollision.setTileProperties(11, FlxObject.NONE);
			_tileMapCollision.setTileProperties(16, FlxObject.NONE);
			_tileMapCollision.setTileProperties(18, FlxObject.NONE);
			_tileMapCollision.setTileProperties(24, FlxObject.NONE);
			_tileMapCollision.setTileProperties(26, FlxObject.NONE);
			_tileMapCollision.setTileProperties(32, FlxObject.NONE);
			_tileMapCollision.setTileProperties(34, FlxObject.NONE);
			_tileMapCollision.setTileProperties(40, FlxObject.NONE);
			_tileMapCollision.setTileProperties(42, FlxObject.NONE);
			
			_tileMapCollision.setTileProperties(66, FlxObject.NONE, collideTrampoline);
			
			var xTile:Number = xmlTree.levels.levelTest.heroPosition.@["x"];
			var yTile:Number = xmlTree.levels.levelTest.heroPosition.@["y"];
			
			var heroXmlTree:XML = new XML(xmlTree.hero.toXMLString());

			
			_player = new Hero(heroXmlTree, _collisionTileWidth * xTile, _collisionTileHeight * yTile);
			

		}
		
		///////////////////////////////////////////////////////////////////////////////////////////////////////////////
		private function collideTrampoline(Tile:FlxTile, player:FlxObject):void
		{
			(player as Hero).velocity.y -= 50;
			
			
			
		}
		
		private function collideSand(Tile:FlxTile, player:FlxObject):void
		{
			if((player as FlxSprite).facing == FlxObject.LEFT && player.velocity.x != 0)
				player.velocity.x *= 0.8;
			if((player as FlxSprite).facing == FlxObject.RIGHT && player.velocity.x != 0)
				player.velocity.x *= 0.8;
			
			//FlxG.play(_sandSound);
		}
		
		
		private function collideSpike(Tile:FlxTile, player:FlxObject):void
		{
			_player.respawnHero();
			FlxG.play(_spikeSound);
		}
		
		private function collideLava(Tile:FlxTile, player:FlxObject):void
		{
			_player.respawnHero();
			FlxG.play(_lavaDeathSound);
		}
		
		private function collideMoss(Tile:FlxTile, player:FlxObject):void
		{
			if((player as FlxSprite).facing == FlxObject.LEFT && player.velocity.x != 0)
				player.velocity.x *= 0.8;
			if((player as FlxSprite).facing == FlxObject.RIGHT && player.velocity.x != 0)
				player.velocity.x *= 0.8;
				
			//FlxG.play(_mossSound);
		}
		
		private function collideWaypoint(Tile:FlxTile, player:FlxObject):void
		{
			(player as Hero).updateCheckPoint(new FlxPoint(player.x, player.y - 32));
			_tileMapCollision.setTileByIndex(Tile.mapIndex, 64);

		}
		
		private function collideVictory(Tile:FlxTile, player:FlxObject):void
		{
			//Do something pretty
			levelComplete();
		}
		
		
		private function createWhipCanvas():void 
		{
			_whipCanvas = new FlxSprite(0, 0);
			_whipCanvas.makeGraphic(FlxG.width, FlxG.height, 0x00000000);
			
			add(_whipCanvas);
			
		}
		
		///////////////////////////////////////////////////////////////////////////////////////////////////////////////
		
		private function drawWhip(whipDest:FlxPoint):void 
		{
			//check if whip is possible here, if not, tell hero to stop swinging
			//TODO: check to see if the player can actually swing, and if they can't, drop them like a bad habit

			trace("in PlayState, got signal to draw whip ending at: " + whipDest.x + ", " + whipDest.y);			

			_whipCanvas.fill(0x00000000);			
			_whipCanvas.drawLine(_player.x + (_player.width * 0.5), _player.y + (_player.height * 0.5), whipDest.x, whipDest.y,  0xfff4a460); //brown
			_whipCenter = whipDest;
			
		}
		
		///////////////////////////////////////////////////////////////////////////////////////////////////////////////
		
		private function updateWhip():void 
		{
			_whipCanvas.fill(0x00000000);
			_whipCanvas.drawLine(_player.x + (_player.width * 0.5), _player.y, _whipCenter.x, _whipCenter.y, 0xfff4a460); //brown
			
		}
		
		///////////////////////////////////////////////////////////////////////////////////////////////////////////////
		
	}

}
