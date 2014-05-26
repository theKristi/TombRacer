package com.trdevt.gameState 
{
	import com.trdevt.sprites.Hero;
	import com.trdevt.sprites.HeroStates;
	import com.trdevt.sprites.obstacles.ArrowObstacle;
	import com.trdevt.sprites.obstacles.BatObstacle;
	import com.trdevt.sprites.obstacles.FireballObstacle;
	import com.trdevt.sprites.obstacles.Obstacle;
	import org.flixel.FlxG;
	import org.flixel.FlxGroup;
	import org.flixel.FlxObject;
	import org.flixel.FlxPoint;
	import org.flixel.FlxSprite;
	import org.flixel.FlxTileblock;
	import org.flixel.FlxTilemap;
	import org.flixel.FlxTimer;
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
		
		protected var _tmLavaCollision:FlxTilemap;
		protected var _tmSpikeCollision:FlxTilemap;
		protected var _tmSandCollision:FlxTilemap;
		protected var _tmMossCollision:FlxTilemap;
		protected var _tmSwitchCollision:FlxTilemap;
		
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
			add(_tmLavaCollision);
			add(_tmMossCollision);
			add(_tmSandCollision);
			add(_tmSpikeCollision);
			add(_tmSwitchCollision);
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
			_player.signalHeroHasDied.add(toCheckpoint);
			_player.signalHeroCJump.add(removeLimit);
			
			
			
		}
		public function removeLimit():void
		{
			_player.maxVelocity.x = 100000;
		}
		
		public function toCheckpoint():void
		{
			_player.x = 32 * _player.checkpointX;
			_player.y = 32 * _player.checkpointY;
		}
		
		///////////////////////////////////////////////////////////////////////////////////////////////////////////////
		
		override public function update():void 
		{
			super.update();
			
			if (FlxG.collide(_player, _tileMapCollision))
			{
				_player.stopSwinging();
			}
			
			FlxG.collide(_player, _tmLavaCollision, onPlayerCollision)
			
			if (FlxG.collide(_player, _tmSpikeCollision))
			{
				if (_player.isTouching(FlxObject.FLOOR))
					_player.signalHeroHasDied.dispatch();
			}
			
			if (FlxG.collide(_player, _tmMossCollision))
			{
				_player.speedPercentage = .5;
			}
			else
			{
				_player.speedPercentage = 1.0;
			}
			
			if (FlxG.collide(_player, _tmSandCollision))
			{
				_player.speedPercentage = .5;
				_player.acceleration.y = .5
			}
			else
			{
				_player.speedPercentage = 1.0;
			}
			
			FlxG.overlap(_player, _fgBatCollision, onPlayerCollision);
			FlxG.collide(_fgBatCollision, _tileMapCollision, onObstacleCollision);
			
			FlxG.overlap(_player, _fgArrowCollision, onArrowCollision);
			FlxG.collide(_fgArrowCollision, _tileMapCollision, onObstacleCollision);
			
			FlxG.overlap(_player, _fgFireballCollision, onFireballCollision);
			FlxG.collide(_fgFireballCollision, _tileMapCollision, onObstacleCollision);
			
			if (_player.state == HeroStates.HERO_SWING)
			{
				updateWhip();
			}
			
			
			
			// the following code will go in the player; he knows when he's died in this case
			//if (_player.x > FlxG.width || _player.x < 0 || _player.y > FlxG.height || _player.y < 0)
				//_player.signalHeroHasDied.dispatch();
		}
		
		public function onPlayerCollision(player:Hero, obstacle:Obstacle):void
		{
			player.signalHeroHasDied.dispatch();
		}
		
		public function onObstacleCollision(obstacle:Obstacle, wall:FlxObject):void
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
			//test code below, the results screen may want xml in the future
			//FlxG.switchState(new ResultsState( new XML("") , _finalScore));
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
			//_tileMapBackground.loadMap(new _tileMapBackgroundFile(), _tileSetBackgroundFile, _backgroundTileWidth, _backgroundTileHeight);
			
			
			var xTile:Number = xmlTree.levels.levelTest.heroPosition.@["x"];
			var yTile:Number = xmlTree.levels.levelTest.heroPosition.@["y"];
			
			var heroXmlTree:XML = new XML(xmlTree.hero.toXMLString());

			
			_player = new Hero(heroXmlTree, _collisionTileWidth * xTile, _collisionTileHeight * yTile);
			
			
			
			//do the loadMaps here to keep from using copious amounts of attributes (tile width and height, etc)
			//_tileMapCollision.loadMap(new _tileMapCollisionFile(), _tileSetCollsionFile, _collisionTileWidth, _collisionTileHeight);
			//_tileMapBackground.loadMap(new _tileMapBackgroundFile(), _tileSetBackgroundFile, _backgroundTileWidth, _backgroundTileHeight);
			
		}
		
		///////////////////////////////////////////////////////////////////////////////////////////////////////////////
		
		private function createWhipCanvas():void 
		{
			_whipCanvas = new FlxSprite(0, 0);
			_whipCanvas.makeGraphic(FlxG.width, FlxG.height, 0x00000000);
			
			add(_whipCanvas);
			
		}
		
		///////////////////////////////////////////////////////////////////////////////////////////////////////////////
		
		private function drawWhip(whipDest:FlxPoint):void 
		{
			trace("in PlayState, got signal to draw whip ending at: " + whipDest.x + ", " + whipDest.y);			
			//if (_player.isHeroOnGround())
			//{
				//return;
			//}
			//hero is in the air at this point
			_whipCanvas.fill(0x00000000);
			_whipCanvas.drawLine(_player.x + (_player.width * 0.5), _player.y + (_player.height * 0.5), whipDest.x, whipDest.y,  0xfff4a460); //brown
			_whipCenter = whipDest;
			
			
		}
		
		///////////////////////////////////////////////////////////////////////////////////////////////////////////////
		
		private function updateWhip():void 
		{
			_whipCanvas.fill(0x00000000);
			_whipCanvas.drawLine(_player.x + (_player.width * 0.5), _player.y + (_player.height * 0.5), _whipCenter.x, _whipCenter.y, 0xfff4a460); //brown
			
		}
		
		///////////////////////////////////////////////////////////////////////////////////////////////////////////////
	}

}
