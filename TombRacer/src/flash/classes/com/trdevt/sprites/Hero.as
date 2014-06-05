package com.trdevt.sprites 
{
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	import org.flixel.FlxG;
	import org.flixel.FlxObject;
	import org.flixel.FlxPoint;
	import org.flixel.FlxSprite;
	import org.flixel.FlxU;
	import org.osflash.signals.Signal;
	/**
	 * ...
	 * @author Jake
	 */
	public class Hero extends AbstractSprite
	{
		
		[Embed(source = '../../../../../images/SpriteSheets/IndieWalkSheet.png')] private static var _sheet:Class;
		
		protected var _jumpPower:Number;
		
		protected var _constAccel:Number;
		
		protected var _heroState:String;
		
		protected var _lastCheckPoint:FlxPoint;
		
		//the following are used for the swinging motions
		protected var _swingRadius:Number = 0;
		protected var _swingMaxTheta:Number = 0;
		protected var _swingCenter:FlxPoint;
		protected var _thetaPosition:Number = 0;
		protected var _thetaVelocity:Number = 0;
		protected var _thetaAcceleration:Number = 0;
		
		//following variables are for dashing
		//i am using the as3 timer because the flixel timer is not meant for use in game states according to the flixel API
		private var _dashTimer:Timer;
		private var _dashActive:Boolean = false;
		
		/**
		 * the counter variable is used to simulate the passage of time using the equation for pendulum motion
		 */
		protected var _counter:Number = 0;
		
		public var cooldown:int = 0;
		public var speedPercentage:Number = 1.0;
		public var fallSpeedPercentage:Number = 1.0;

		/**
		 * public signal for when the hero has died
		 */
		public var signalHeroHasDied:Signal;
		
		/**
		 * signal for the playstate that the player wants to whip
		 */
		public var signalHeroWhipped:Signal;
		
		public var signalHeroStoppedSwinging:Signal;
		
		public var signalHeroCJump:Signal;
		public var lastSlope:int;
		public var jumping:Boolean;



		///////////////////////////////////////////////////////////////////////////////////////////////////////////////
		
		/**
		 * constructor (mimics the FlxSprite consturctor)
		 * @param	X
		 * @param	Y
		 * @param	SimpleGraphic
		 */
		public function Hero(xmlTree:XML,X:Number=0,Y:Number=0,SimpleGraphic:Class=null) 
		{
			super(xmlTree, X, Y);
			
			_lastCheckPoint = new FlxPoint(X, Y);
			
			this.spriteSheet = _sheet;
			this.loadGraphic(_spriteSheet, true, true, 32, 32 + 16);
			this.addAnimation("walking", [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11], 15, true);
			this.addAnimation("idle", [12, 13], 1, true);
			this.addAnimation("jumpUp", [14], 1, false);
			this.addAnimation("jumpDown", [18] , 1 , false);
			this.addAnimation("death", [20, 21, 22, 23], 5, false);
			this.addAnimation("swing", [19], 1, false);
			
			this.play("idle");
			this.facing = FlxObject.RIGHT;
			
			signalHeroHasDied = new Signal();
			signalHeroWhipped = new Signal(FlxPoint);
			signalHeroCJump = new Signal();
			signalHeroStoppedSwinging = new Signal();
			
			_heroState = HeroStates.HERO_NOT_SWING;
			this.lastSlope = 0;
			this.jumping = false;
			
		}
		
		///////////////////////////////////////////////////////////////////////////////////////////////////////////////
		
		private function traceHeroStats():void 
		{
			//trace("Hero Stats - pos: " + x + ", " + y + ", width X height: " + width + " X " + height+", velocity x,y: "+velocity.x+", "+velocity.y+", accel x,y: "+acceleration.x+", "+acceleration.y);
		}
		
		///////////////////////////////////////////////////////////////////////////////////////////////////////////////
		
		override public function update():void 
		{
			super.update();
			
			////traceHeroStats();
			
			
			if (_heroState == HeroStates.HERO_NOT_SWING)
			{
				moveHero();
			}
			else if (_heroState == HeroStates.HERO_SWING)
			{
				moveHeroSwing();
			}
			
			fireGrapple();

			canonJump();
			dash();
	
			selectAnimation();
			
			checkForHeroDeath();
			
			
		}
		
		///////////////////////////////////////////////////////////////////////////////////////////////////////////////
		
		private function stopDashing(event:Event=null):void 
		{
			//trace("No dash!");
			_dashActive = false;
			
			_dashTimer.removeEventListener(TimerEvent.TIMER, stopDashing);
			
		}
		
		///////////////////////////////////////////////////////////////////////////////////////////////////////////////
		
		private function dash():void 
		{
			//end the dash after a certain amount of time
			
			//only dash while on the ground
			if (!isHeroOnGround() || _dashActive)
			{
				return;
			}
			
			if (FlxG.keys.justPressed("S"))
			{
				_dashActive = true;
			
				//trace("Dash!");
				
				if (facing == FlxObject.LEFT)
				{
					velocity.x -= _jumpPower*2;
				}
				else
				{
					velocity.x += _jumpPower*2;
				}
				
				_dashTimer = new Timer(2000, 1);
				
				_dashTimer.addEventListener(TimerEvent.TIMER, stopDashing);
				
				_dashTimer.start();
				
			}
	}
		
		///////////////////////////////////////////////////////////////////////////////////////////////////////////////
		
		private function checkForHeroDeath():void 
		{
			if (x > FlxG.width || x < 0 || y > FlxG.height || y < 0)
			{
			
				respawnHero();
			}
		}
		
		///////////////////////////////////////////////////////////////////////////////////////////////////////////////
		
		/**
		 * Forces the hero to respawn at his last checkpoint. If the hero has not seen a checkpoint yet, he will respawn at his original spawn point
		 */
		public function respawnHero():void 
		{
			//trace("Respawning at x:", _lastCheckPoint.x);
			//trace("Respawning at y:", _lastCheckPoint.y);
			
			this.x = _lastCheckPoint.x;
			this.y = _lastCheckPoint.y;

			//trace("Actual x:", this.x);
			//trace("Actual y:", this.y);

			this.x = _lastCheckPoint.x;
			this.y = _lastCheckPoint.y;
			
			velocity.x = velocity.y = acceleration.x = 0;
			
			_heroState = HeroStates.HERO_NOT_SWING;
			signalHeroStoppedSwinging.dispatch();
			
			signalHeroHasDied.dispatch();

		}
		
		///////////////////////////////////////////////////////////////////////////////////////////////////////////////
		
		private function canonJump():void 
		{
			//if (cooldown < 60)
				//this.maxVelocity.x = 120;
			if (FlxG.keys.G)
			{
				//signalHeroCJump.dispatch();
				var angle:Number = findAngleDegree(new FlxPoint(this.x, this.y), new FlxPoint(FlxG.mouse.x, FlxG.mouse.y));
				//the x direction doesn't work because of the max velocity
				velocity.x = - _jumpPower * Math.cos(angle * Math.PI / 180);
				velocity.y = _jumpPower * Math.sin(angle * Math.PI / 180);

				cooldown = 75;
			}
			//if (cooldown != 0)
				//cooldown--;
		}
		
		///////////////////////////////////////////////////////////////////////////////////////////////////////////////
		
		private function moveHeroSwing():void 
		{			
			physicsOff();
			
			//the counter acts to keep time
			//Math.PI/4 makes a good amplitude
			_thetaPosition = -Math.sin(_counter) * _swingMaxTheta + Math.PI / 2;
			
			//derivative of above
			_thetaVelocity = -_swingMaxTheta * _swingRadius * Math.cos(_counter);
			
			//0.05 is an awesome rate for SHM
			_counter -= 0.05;
			
			this.x = _swingRadius * Math.cos(_thetaPosition) + _swingCenter.x;
			this.y = _swingRadius * Math.sin(_thetaPosition) + _swingCenter.y;
			
			//check to end the swing
			//if(FlxG.keys.SPACE || FlxG.keys.W)
			if(FlxG.keys.justPressed("SPACE") || FlxG.keys.justPressed("W"))
			{
				velocity.y = -_jumpPower;
				velocity.x = _thetaVelocity * _swingRadius * 0.01; //physics! omega * r = v
				stopSwinging();
			}
			
		}
		
		///////////////////////////////////////////////////////////////////////////////////////////////////////////////
		
		/**
		 * call this function if you would like the hero to stop swinging. it sets his state and turns his physics on
		 */
		public function stopSwinging():void 
		{
			_heroState = HeroStates.HERO_NOT_SWING;
			signalHeroStoppedSwinging.dispatch();
			physicsOn();
		}
		
		///////////////////////////////////////////////////////////////////////////////////////////////////////////////
			
		private function physicsOff():void 
		{
			//this.immovable = true;
			this.moves = false;
		}
		
		///////////////////////////////////////////////////////////////////////////////////////////////////////////////
		
		private function physicsOn():void 
		{
			//this.immovable = false;
			this.moves = true;
		}
		
		///////////////////////////////////////////////////////////////////////////////////////////////////////////////
		
		private function findAngleDegree(center:FlxPoint, orbitPoint:FlxPoint):Number
		{
			var dx:Number = center.x - orbitPoint.x;
			var dy:Number = center.y - orbitPoint.y;
			
			var angleRad:Number = Math.atan2(dy, dx);
			
			var angleDeg:Number = angleRad * 180 / Math.PI;
			
			if (angleDeg  >= 0)
			{
				return -angleDeg + 360;
			}
			else
			{
				return -angleDeg;
			}
		}
		
		///////////////////////////////////////////////////////////////////////////////////////////////////////////////
		
		private function fireGrapple():void 
		{
			if (!canHeroSwing())
			{
				//return if i can't swing
				return;
			}
			
			if (FlxG.mouse.justPressed())
			{				
				var dx:Number = FlxG.mouse.x - this.x;
				var dy:Number = FlxG.mouse.y - this.y;
				var angleDeg:Number = Math.atan2(dy, dx) * 180 / Math.PI;
				
				////trace("angle to mouse is: " + angleDeg);
				
				
				
				_swingRadius = FlxU.getDistance(new FlxPoint(this.x, this.y), new FlxPoint(FlxG.mouse.x, FlxG.mouse.y));
				_swingMaxTheta = Math.atan(dx/dy);
				_swingCenter = new FlxPoint(FlxG.mouse.x, FlxG.mouse.y);
				_counter = 1;
				
				//can't swing longer than 4 blocks, or below yourself
				if (_swingRadius > 4 * 32 || _swingCenter.y > this.y)
				{
					return;
				}
				
				//can't swing if i didn't click on a tile... 
				//TODO: find a way to check out which tile i've clicked
				
				

				//trace("angle to swing center is: " + findAngleDegree(_swingCenter,new FlxPoint(this.x, this.y)));
				
				_heroState = HeroStates.HERO_SWING;
				signalHeroWhipped.dispatch(new FlxPoint(FlxG.mouse.x, FlxG.mouse.y));
			}
		}
		
		///////////////////////////////////////////////////////////////////////////////////////////////////////////////
		
		/**
		 * determines if the hero can swing or not based on his current state
		 * @return true for yes, false for no
		 */
		public function canHeroSwing():Boolean 
		{
			//hero is not already swinging, and hero is not on ground
			return (state != HeroStates.HERO_SWING && !isHeroOnGround());
		}
		
		///////////////////////////////////////////////////////////////////////////////////////////////////////////////
		
		private function selectState():void 
		{
			//this function sucks
			//gonna need to tweak this later
			//if (velocity.y != 0)
			//{
				//_heroState = HeroStates.HERO_AIR;
			//}
			//else
			//{
				//_heroState = HeroStates.HERO_GROUND;
			//}
			
		}
		
		///////////////////////////////////////////////////////////////////////////////////////////////////////////////
		
		private function selectAnimation():void 
		{
			//maxVelocity.x = 100000000;
			if (velocity.y < 0)
			{
				play("jumpDown");
			}
			else if (velocity.y > 0)
			{
				play("jumpUp");
			}
			else if(velocity.x == 0)
			{
				play("idle");
				//maxVelocity.x = 120;
			}
			else
			{
				play("walking");
				//maxVelocity.x = 120;
			}
			
			if (state == HeroStates.HERO_SWING)
			{
				////trace("angle pos cos: " + Math.cos(_thetaPosition));
				//var angleDist:Number = _swingMaxTheta - _thetaPosition + Math.PI;
				////trace("angle pos cos: " + Math.cos(_thetaPosition));
				////trace("thetaPos: "+_thetaPosition+", tangential velocity " + Math.sqrt(2*_swingRadius * (1 - Math.cos(_thetaPosition - Math.PI/2))));
				////trace("angle vel: " + _thetaVelocity);
				if (_thetaVelocity > 0)
					facing = FlxObject.RIGHT;
				else
					facing = FlxObject.LEFT;
				play("swing");
			}
		}
		
		///////////////////////////////////////////////////////////////////////////////////////////////////////////////
		
		private function moveHero():void 
		{
			//this line keeps the hero from continuously accelerating the last direction pressed
			//in other words, if not pressing a key then stop accelerating in the x direction
			if(velocity.y == 0)
			{
				this.jumping = false;
			}
			this.acceleration.x = 0;
				
			if(FlxG.keys.A || FlxG.keys.LEFT)
			{
				facing = FlxObject.LEFT;
				acceleration.x -= _constAccel;
				if (velocity.x > 0)
				{
					velocity.x *= 0.8;
				}
			}
			else if(FlxG.keys.D || FlxG.keys.RIGHT)
			{
				facing = FlxObject.RIGHT;
				acceleration.x += _constAccel;
				if (velocity.x < 0)
				{
					velocity.x *= 0.8;
				}
			}
			
			if((FlxG.keys.justPressed("W") || FlxG.keys.justPressed("SPACE") || FlxG.keys.justPressed("UP")) && (velocity.y == 0 || velocity.y == -6.4))
			{
				this.jumping = true;
				//trace(velocity.y);
				//Through testing I have determined that velocity increases by 12.8 every frame
				//Coincidentally, this is the vertical resolution divided by framerate. -Sawyer
				//Jump height is determined by a relationship between this value and acceleration.
				//Currenly the height is slightly over three blocks. -Sawyer
				y -= 1;
				velocity.y = -_jumpPower;
				//this.play("jumping", true);
			}
		}
		
		///////////////////////////////////////////////////////////////////////////////////////////////////////////////
		
		/**
		 * builds the hero class from the Hero node in the xml tree
		 * @param	xmlTree
		 */
		override protected function parseXML(xmlTree:XML):void 
		{
			//var attributes:Array = xmlTree
			
			//this code should not look like this... there is a bug with iterating over inheritted attributes using this["attrName"]
		
			drag.x = 			xmlTree.@["drag.x"];
			acceleration.y = 	xmlTree.@["acceleration.y"];
			maxVelocity.x =		xmlTree.@["maxVelocity.x"];
			maxVelocity.y = 	xmlTree.@["maxVelocity.y"];
			_jumpPower = 		xmlTree.@["_jumpPower"];
			_constAccel =		xmlTree.@["_constAccel"];
			

			
		}
		
		///////////////////////////////////////////////////////////////////////////////////////////////////////////////
		
		public function isHeroOnGround():Boolean 
		{
			return (velocity.y == 0);
		}
		
		///////////////////////////////////////////////////////////////////////////////////////////////////////////////
		
		public function get state():String 
		{
			return _heroState;
		}
		
		///////////////////////////////////////////////////////////////////////////////////////////////////////////////
		
		/**
		 * updates this hero's respawn to the given point
		 * @param	newPoint
		 */
		public function updateCheckPoint(newPoint:FlxPoint):void 
		{
			//trace("Updating checkpoint x: ", newPoint.x);
			//trace("Updating checkpoint y: ", newPoint.y);
			_lastCheckPoint = newPoint;
		}
		
		///////////////////////////////////////////////////////////////////////////////////////////////////////////////
	}

}
