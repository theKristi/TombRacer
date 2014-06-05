package com.trdevt.gameState 
{
	import com.trdevt.sprites.Hero;
	import com.trdevt.sprites.HeroStates;
	import com.trdevt.sprites.obstacles.ArrowLauncherObstacle;
	import com.trdevt.sprites.obstacles.ArrowObstacle;
	import com.trdevt.sprites.obstacles.BatObstacle;
	import com.trdevt.sprites.obstacles.CrushGuyObstacle;
	import com.trdevt.sprites.obstacles.FireBallLauncherObstacle;
	import com.trdevt.sprites.obstacles.FireballObstacle;
	import com.trdevt.sprites.obstacles.Obstacle;
	import com.trdevt.util.LocalSharedObjectManager;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.sampler.NewObjectSample;
	import flash.utils.Timer;
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
		
		protected var _ftScore:FlxText;
		protected var _fireballTimer:Timer;
		protected var _arrowTimer:Timer;
		protected var _currentLevelNum:Number;
		
		//class files will be loaded from the parse function
		protected var _tileMapCollisionFile:Class;
		protected var _tileSetCollsionFile:Class;
		protected var _tileMapCollision:FlxTilemap;
		
		protected var _fgBatCollision:FlxGroup;
		protected var _fgFireballCollision:FlxGroup;
		protected var _fgArrowCollision:FlxGroup;
		protected var _fgFireballLauncher:FlxGroup;
		protected var _fgArrowLauncher:FlxGroup;
		protected var _fgCrushGuyCollision:FlxGroup;
		
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
		

		protected var _startTime:Number;
		protected var _endTime:Number;
		protected var _stepTime:Number;
		protected var _finalTime:Number;
		
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
			
			
			
			
			//Test Obstacles
			_fgBatCollision.add(new BatObstacle(5, 5, FlxObject.UP));
			//_fgBatCollision.add(new BatObstacle(3, 7, FlxObject.RIGHT));
			//_fgBatCollision.add(new BatObstacle(7, 9, FlxObject.LEFT));
			
			//_fgFireballLauncher.add(new FireBallLauncherObstacle(2, 2, FlxObject.LEFT));
			//_fgArrowCollision.add(new ArrowObstacle(5, 4));
			
			//_fgFireballCollision.add(new FireballObstacle(5 , 3, FlxObject.RIGHT));
			
			//_fgArrowLauncher.add(new ArrowLauncherObstacle(2, 2, FlxObject.DOWN));
			
			//_fgCrushGuyCollision.add(new CrushGuyObstacle(2, 3));
			add(_fgBatCollision);
			add(_fgFireballCollision);
			add(_fgArrowCollision);
			add(_fgFireballLauncher);
			add(_fgArrowLauncher);
			add(_fgCrushGuyCollision);
			
			createWhipCanvas();
			
			add(_player);
			_player.signalHeroWhipped.add(drawWhip);
			_player.signalHeroCJump.add(removeLimit);
			
			add(_ftScore);
			
		}
		
		/**
		 * false for invalid swing, true for valid swing.
		 * @param	p
		 * @return
		 */
		private function checkValidSwing(p:FlxPoint):Boolean
		{
			//17 is a floor tile on level0
			var tileNum:uint = _tileMapCollision.getTile(p.x / 32, p.y / 32);
			// add the other valid swings in here please, just copy paste the block types you want to swing on
			switch(tileNum)
			{
				case 17: return true;
				case 2: return true;
				case 41: return true;
				case 33: return true;
				case 25: return true;
				default: return false;
			}
			
		}
		
		public function removeLimit():void
		{
			_player.maxVelocity.x = 100000;
		}
		
		
		override public function update():void 
		{

			super.update();

			_finalTime += FlxG.elapsed;
			_ftScore.text = FlxU.formatTime(_finalTime);
			FlxG.collide(_player, _fgFireballLauncher);
			FlxG.collide(_player, _fgArrowLauncher);
			if (FlxG.collide(_player, _tileMapCollision))
			{
				_player.stopSwinging();
			}
			
			FlxG.collide(_fgBatCollision, _tileMapCollision, onBatCollision);
			
			if (FlxG.overlap(_player, _fgBatCollision))
			{
				_player.respawnHero();
			}
			FlxG.collide(_fgBatCollision, _tileMapCollision, onBatCollision);
			
			FlxG.overlap(_player, _fgArrowCollision, onArrowOverlap);
			FlxG.collide(_fgArrowCollision, _tileMapCollision, onArrowCollision);
			
			FlxG.overlap(_player, _fgFireballCollision, onFireballOverlap);
			FlxG.collide(_fgFireballCollision, _tileMapCollision, onFireballCollision);
			
			FlxG.overlap(_player, _fgCrushGuyCollision, onCrushGuyOverlap);
			FlxG.collide(_fgCrushGuyCollision, _tileMapCollision, onCrushGuyCollision);
			
			if (_player.state == HeroStates.HERO_SWING)
			{
				updateWhip();
			}
			if (FlxG.keys.R)
				FlxG.switchState(new SelectState(new XML()));
			
			
		}
		
		public function onCrushGuyOverlap(player:Hero, guy:CrushGuyObstacle)
		{
			_player.respawnHero();
		}
		
		public function onCrushGuyCollision(guy:CrushGuyObstacle, stuff:FlxObject = null)
		{
			guy.onCollision();
		}
		
		public function onFireballOverlap(player:Hero, fireball:FireballObstacle)
		{
			_fgFireballCollision.remove(fireball);
			fireball.onCollision();
			_player.respawnHero();
			
		}
		
		public function onArrowOverlap(player:Hero, arrow:ArrowObstacle)
		{
			_fgArrowCollision.remove(arrow);
			arrow.onCollision();
			_player.respawnHero();
			
		}
		
		public function onArrowCollision(arrow:ArrowObstacle, player:FlxObject = null):void
		{
			arrow.onCollision();
			_fgArrowCollision.remove(arrow);
		}
		
		public function onFireballCollision(fireball:FireballObstacle, map:FlxObject = null):void
		{
			fireball.onCollision();
			_fgFireballCollision.remove(fireball);
		}
		
		public function onBatCollision(bat:BatObstacle, map:FlxObject = null)
		{
			bat.onCollision();
		}
		
		public function onLaunchFireball(e:Event):void
		{
			for each (var launcher:FireBallLauncherObstacle in _fgFireballLauncher.members) 
			{
				_fgFireballCollision.add(launcher.launchFireball());
			}
		}
		
		public function onLaunchArrow(e:Event):void
		{
			for each (var launcher:ArrowLauncherObstacle in _fgArrowLauncher.members)
			{
				_fgArrowCollision.add(launcher.launchArrow());
			}
		}
		
		///////////////////////////////////////////////////////////////////////////////////////////////////////////////
		
		/**
		 * this function handles when the level is completed
		 */
		protected function levelComplete():void 
		{
			FlxG.switchState(new ResultsState(_finalTime, _currentLevelNum));
		}
		
		///////////////////////////////////////////////////////////////////////////////////////////////////////////////
		
		override protected function parseXML(xmlTree:XML):void 
		{
			_tileMapCollision = new FlxTilemap();
			_tileMapBackground = new FlxTilemap();
			
			_fgBatCollision = new FlxGroup(20);
			_fgFireballCollision = new FlxGroup(50);
			_fgArrowCollision = new FlxGroup(20);
			_fgFireballLauncher = new FlxGroup(20);
			_fgArrowLauncher = new FlxGroup(50);
			_fgCrushGuyCollision = new FlxGroup(20);

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
			_tileMapCollision.setTileProperties(7, FlxObject.FLOOR, collideSpike); 
			_tileMapCollision.setTileProperties(15, FlxObject.FLOOR, collideSpike);
			_tileMapCollision.setTileProperties(22, FlxObject.FLOOR, collideSpike);
			_tileMapCollision.setTileProperties(23, FlxObject.CEILING, collideSpike);
			_tileMapCollision.setTileProperties(30, FlxObject.FLOOR, collideSpike);
			_tileMapCollision.setTileProperties(31, FlxObject.CEILING, collideSpike);
			_tileMapCollision.setTileProperties(38, FlxObject.CEILING, collideSpike);
			_tileMapCollision.setTileProperties(39, FlxObject.FLOOR, collideSpike);
			_tileMapCollision.setTileProperties(46, FlxObject.CEILING, collideSpike);
			_tileMapCollision.setTileProperties(47, FlxObject.FLOOR, collideSpike);
			_tileMapCollision.setTileProperties(55, FlxObject.CEILING, collideSpike);
			_tileMapCollision.setTileProperties(63, FlxObject.CEILING, collideSpike);
			// Moss Collisions
			_tileMapCollision.setTileProperties(51, FlxObject.CEILING, collideMoss);
			_tileMapCollision.setTileProperties(52, FlxObject.CEILING, collideMoss);
			_tileMapCollision.setTileProperties(53, FlxObject.CEILING, collideMoss);
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
			
			// Add dynamic obstacles
			//FlxObject.DOWN	0x1000
			//FlxObject.UP		0x0100
			//FlxObject.RIGHT	0x0010
			//FlxObject.LEFT 	0x0001
			var xTile:Number = xmlTree.levels.level[_currentLevelNum].heroPosition.@["x"];
			var yTile:Number = xmlTree.levels.level[_currentLevelNum].heroPosition.@["y"];
			
			var heroXmlTree:XML = new XML(xmlTree.hero.toXMLString());
			var fireballXml:XML = new XML(xmlTree.levels.level[_currentLevelNum].fireballObstacles);
			for (var i:int = 0; i < fireballXml.*.length(); i++)
			{
				_fgFireballLauncher.add(new FireBallLauncherObstacle(fireballXml.fireball[i].@x, fireballXml.fireball[i].@y, fireballXml.fireball[i].@direction));
			}
			
			var arrowtrapXml:XML = new XML(xmlTree.levels.level[_currentLevelNum].arrowtrapObstacles);
			for (var i:int = 0; i < arrowtrapXml.*.length(); i++)
			{
				_fgArrowLauncher.add(new ArrowLauncherObstacle(arrowtrapXml.arrowtrap[i].@x, arrowtrapXml.arrowtrap[i].@y, arrowtrapXml.arrowtrap[i].@direction));
			}
			
			var crushGuyXml:XML = new XML(xmlTree.levels.level[_currentLevelNum].crushguyObstacles);
			for (var i:int = 0; i < crushGuyXml.*.length(); i++)
			{
				_fgCrushGuyCollision.add(new CrushGuyObstacle(crushGuyXml.crushguy[i].@x, crushGuyXml.crushguy[i].@y));
			}
			//trace(fireballXml.fireball[0].@x);
			_player = new Hero(heroXmlTree, _collisionTileWidth * xTile, _collisionTileHeight * yTile);
			_fireballTimer = new Timer(800);
			_fireballTimer.addEventListener(TimerEvent.TIMER, onLaunchFireball);
			_fireballTimer.start();
			
			_arrowTimer = new Timer(800);
			_arrowTimer.addEventListener(TimerEvent.TIMER, onLaunchArrow);
			_arrowTimer.start();
			
			_finalTime = 0;
			_startTime = FlxG.elapsed;
			//_timer.start(10000, 1);
			_ftScore = new FlxText(0, 0, 100, FlxU.formatTime(0, true));
			//add(_ftScore);
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
			_player.respawnHero();
		}
		
		private function collideLava(Tile:FlxTile, player:FlxObject):void
		{
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
			_whipCanvas.drawLine(_player.x + (_player.width * 0.5), _player.y, _whipCenter.x, _whipCenter.y, 0xfff4a460); //brown
			
		}
		
		///////////////////////////////////////////////////////////////////////////////////////////////////////////////
		
	}

}
