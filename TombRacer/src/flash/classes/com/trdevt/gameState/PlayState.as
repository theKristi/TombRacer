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
	{
		
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
		
		protected var _touchingMoss:Boolean = false;
		protected var _touchingSand:Boolean = false;
		
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
			
			add(_tileMapCollision);

			//add(_tileMapBackground);
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
			//_player.signalHeroHasDied.add(toCheckpoint);
			_player.signalHeroCJump.add(removeLimit);
			
			
			
		}
		public function removeLimit():void
		{
			_player.maxVelocity.x = 100000;
		}
		
		//public function toCheckpoint():void
		//{
			//
			////_player.x = 32 * _player.checkpointX;
			////_player.y = 32 * _player.checkpointY;
		//}
		
		///////////////////////////////////////////////////////////////////////////////////////////////////////////////
		
		override public function update():void 
		{
			_touchingMoss = false;
			_touchingSand = false;
			super.update();
			
			if (FlxG.collide(_player, _tileMapCollision))
			{
				_player.stopSwinging();
			}
			
			if (_touchingMoss)
			{
				_player.touchingMoss = true;
				if (_touchingSand)
				{
					_player.touchingSand = true;;
				}
				else
				{
					_player.touchingSand = false;
				}
			}
			else
			{
				_player.touchingMoss = false;
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
			if (FlxG.keys.R)
				FlxG.switchState(new SelectState(new XML()));
			
			
			
			// the following code will go in the player; he knows when he's died in this case
			//if (_player.x > FlxG.width || _player.x < 0 || _player.y > FlxG.height || _player.y < 0)
				//_player.signalHeroHasDied.dispatch();
		}
		
		public function onPlayerCollision(tile:FlxTile, player:Hero):void
		{
			player.signalHeroHasDied.dispatch();
		}
		
		public function onMossCollision(tile:FlxTile, player:Hero):void
		{
			_touchingMoss = true;
		}
		
		public function onSandCollision(tile:FlxTile, player:Hero):void
		{
			_touchingSand = true;
			_touchingMoss = true;
		}
		
		public function onTorchCollision(torch:FlxTile, player:Hero):void
		{
			_tileMapCollision.setTile(torch.x / 32, torch.y / 32, 64, true);
			_tileMapCollision.draw();
			//torch.allowCollisions = FlxObject.NONE;
			player.updateCheckPoint(new FlxPoint(player.x, player.y - 1));
		}
		
		public function onObstacleCollision(obstacle:Obstacle, object:FlxObject)
		{
			obstacle.onCollision();
		}
		
		public function onArrowCollision(arrow:ArrowObstacle, player:Hero):void
		{
			arrow.onCollision();
			player.signalHeroHasDied.dispatch();
		}
		
		public function onFireballCollision(fireball:FireballObstacle, player:Hero):void
		{
			fireball.onCollision();
			player.signalHeroHasDied.dispatch();
		}
		
		///////////////////////////////////////////////////////////////////////////////////////////////////////////////
		
		/**
		 * this function handles when the level is completed
		 */
		protected function levelComplete():void 
		{
FlxG.switchState(new ResultsState());
		}
		
		///////////////////////////////////////////////////////////////////////////////////////////////////////////////
		
		override protected function parseXML(xmlTree:XML):void 
		{
			//load the map and sets from the Loader class
			//map = Loader.getMap(_currentLevelNum)
			//set = Loader.getSet(_currentLevelNum)
			
			var l:Loader = new Loader();
			
			_tileMapCollisionFile = l.getMap(_currentLevelNum, 0);
			_tileSetCollsionFile = l.getSet(_currentLevelNum, 0);
			
			_tileMapCollision = new FlxTilemap();

			//_tileMapBackground = new FlxTilemap();
			
			//change this
			_backgroundTileHeight = _backgroundTileWidth = _collisionTileWidth = _collisionTileHeight = 32;
			
			_tileMapCollision.loadMap(new _tileMapCollisionFile(), _tileSetCollsionFile, _collisionTileWidth, _collisionTileHeight);
			// Lava Collisions
			_tileMapCollision.setTileProperties(62, FlxObject.ANY, onPlayerCollision);
			_tileMapCollision.setTileProperties(54, FlxObject.ANY, onPlayerCollision);
			// Spike Collisions
			_tileMapCollision.setTileProperties(7, FlxObject.FLOOR, onPlayerCollision); // One of the spikes
			_tileMapCollision.setTileProperties(15, FlxObject.FLOOR, onPlayerCollision);
			_tileMapCollision.setTileProperties(22, FlxObject.FLOOR, onPlayerCollision);
			_tileMapCollision.setTileProperties(23, FlxObject.CEILING, onPlayerCollision);
			_tileMapCollision.setTileProperties(30, FlxObject.FLOOR, onPlayerCollision);
			_tileMapCollision.setTileProperties(31, FlxObject.FLOOR, onPlayerCollision);
			_tileMapCollision.setTileProperties(38, FlxObject.CEILING, onPlayerCollision);
			_tileMapCollision.setTileProperties(39, FlxObject.FLOOR, onPlayerCollision);
			_tileMapCollision.setTileProperties(46, FlxObject.CEILING, onPlayerCollision);
			_tileMapCollision.setTileProperties(47, FlxObject.FLOOR, onPlayerCollision);
			_tileMapCollision.setTileProperties(55, FlxObject.CEILING, onPlayerCollision);
			_tileMapCollision.setTileProperties(63, FlxObject.CEILING, onPlayerCollision);
			// Moss Collisions
			_tileMapCollision.setTileProperties(51, FlxObject.CEILING, onMossCollision);
			_tileMapCollision.setTileProperties(52, FlxObject.CEILING, onMossCollision);
			_tileMapCollision.setTileProperties(53, FlxObject.CEILING, onMossCollision);
			// Switch Collisions
			_tileMapCollision.setTileProperties(48, FlxObject.CEILING, onSandCollision);
			_tileMapCollision.setTileProperties(49, FlxObject.CEILING, onSandCollision);
			_tileMapCollision.setTileProperties(50, FlxObject.CEILING, onSandCollision);
			// Sand Collisions
			_tileMapCollision.setTileProperties(8, FlxObject.ANY, onPlayerCollision);
			// Torch Collisions
			_tileMapCollision.setTileProperties(64, FlxObject.NONE);
			_tileMapCollision.setTileProperties(65, FlxObject.ANY, onTorchCollision);
			
			_tileMapCollision.setTileProperties(54, 0);
			_tileMapCollision.setTileProperties(62, 0, collideLava);
			
			_tileMapCollision.setTileProperties(48, 0, collideVictory);
			_tileMapCollision.setTileProperties(49, 0, collideVictory);
			_tileMapCollision.setTileProperties(50, 0, collideVictory);
			
			var xTile:Number = xmlTree.levels.levelTest.heroPosition.@["x"];
			var yTile:Number = xmlTree.levels.levelTest.heroPosition.@["y"];
			
			var heroXmlTree:XML = new XML(xmlTree.hero.toXMLString());

			
			_player = new Hero(heroXmlTree, _collisionTileWidth * xTile, _collisionTileHeight * yTile);
			
			//do the loadMaps here to keep from using copious amounts of attributes (tile width and height, etc)
			//_tileMapCollision.loadMap(new _tileMapCollisionFile(), _tileSetCollsionFile, _collisionTileWidth, _collisionTileHeight);
			//_tileMapBackground.loadMap(new _tileMapBackgroundFile(), _tileSetBackgroundFile, _backgroundTileWidth, _backgroundTileHeight);
			

		}
		
		///////////////////////////////////////////////////////////////////////////////////////////////////////////////
		private function collideTrampoline(Tile:FlxTile, player:FlxObject):void
		{
			player.velocity.y -= 50;
		}
		
		private function collideSand(Tile:FlxTile, player:FlxObject):void
		{
			if((player as FlxSprite).facing == FlxObject.LEFT && player.velocity.x != 0)
				player.velocity.x *= 0.8;
			if((player as FlxSprite).facing == FlxObject.RIGHT && player.velocity.x != 0)
				player.velocity.x *= 0.8;
		}
		
		private function collideSpike(Tile:FlxTile, player:FlxObject):void
		{
			_player.signalHeroHasDied.dispatch();
			_player.respawnHero();
		}
		
		private function collideLava(Tile:FlxTile, player:FlxObject):void
		{
			_player.signalHeroHasDied.dispatch();
			_player.respawnHero();
		}
		
		private function collideMoss(Tile:FlxTile, player:FlxObject):void
		{
			if((player as FlxSprite).facing == FlxObject.LEFT && player.velocity.x != 0)
				player.velocity.x *= 0.8;
			if((player as FlxSprite).facing == FlxObject.RIGHT && player.velocity.x != 0)
				player.velocity.x *= 0.8;
		}
		
		private function collideWaypoint(Tile:FlxTile, player:FlxObject):void
		{
			(player as Hero).updateCheckPoint(new FlxPoint(player.x, player.y - 1));
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
			//_whipCanvas.drawLine(_player.x + (_player.width * 0.5), _player.y + (_player.height * 0.5), _whipCenter.x, _whipCenter.y, 0xfff4a460); //brown
			_whipCanvas.drawLine(_player.x + (_player.width * 0.5), _player.y, _whipCenter.x, _whipCenter.y, 0xfff4a460); //brown
			
		}
		
		///////////////////////////////////////////////////////////////////////////////////////////////////////////////
		
	}

}
