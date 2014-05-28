package com.trdevt.sprites 
{
	import org.flixel.FlxG;
	import org.flixel.FlxObject;
	import org.flixel.FlxPoint;
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
		//HERE add the timer 
		private var _dashActive:Boolean = false;
		
		/**
		 * the counter variable is used to simulate the passage of time using the equation for pendulum motion
		 */
		protected var _counter:Number = 0;
		
		public var cooldown:int = 0;
		
		/**
		 * public signal for when the hero has died
		 */
		public var signalHeroHasDied:Signal;
		
		/**
		 * signal for the playstate that the player wants to whip
		 */
		public var signalHeroWhipped:Signal;
		
		public var signalHeroCJump:Signal;
		



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
			
			_heroState = HeroStates.HERO_NOT_SWING;
			
		}
		
		///////////////////////////////////////////////////////////////////////////////////////////////////////////////
		
		private function traceHeroStats():void 
		{
			trace("Hero Stats - pos: " + x + ", " + y + ", width X height: " + width + " X " + height+", velocity x,y: "+velocity.x+", "+velocity.y+", accel x,y: "+acceleration.x+", "+acceleration.y);
		}
		
		///////////////////////////////////////////////////////////////////////////////////////////////////////////////
		
		override public function update():void 
		{
			super.update();
			
			//traceHeroStats();
			
			
			if (_heroState == HeroStates.HERO_NOT_SWING)
			{
				moveHero();
			}
			else if (_heroState == HeroStates.HERO_SWING)
			{
				moveHeroSwing();
			}
			
			fireGrapple();

			//canonJump();
			dash();
			thisIsBullshit();
			selectAnimation();
			
			checkForHeroDeath();
			
			
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
			
				trace("Dash!");
			}
				
				
			//if (this.facing == FlxObject.LEFT)
			//{
				//velocity.x -= _jumpPower;
				//velocity.y -= _jumpPower;
			//}
			//else
			//{
				//velocity.x += _jumpPower;
				//velocity.y -= _jumpPower;
			//}
		}
		
		///////////////////////////////////////////////////////////////////////////////////////////////////////////////
		
		private function checkForHeroDeath():void 
		{
			if (x > FlxG.width || x < 0 || y > FlxG.height || y < 0)
			{
				signalHeroHasDied.dispatch();
			
				respawnHero();
			}
		}
		
		///////////////////////////////////////////////////////////////////////////////////////////////////////////////
		
		/**
		 * Forces the hero to respawn at his last checkpoint. If the hero has not seen a checkpoint yet, he will respawn at his original spawn point
		 */
		public function respawnHero():void 
		{
			this.x = _lastCheckPoint.x;
			this.y = _lastCheckPoint.y;
		}
		
		///////////////////////////////////////////////////////////////////////////////////////////////////////////////
		
		private function canonJump():void 
		{
			if (cooldown < 60)
				this.maxVelocity.x = 120;
			if (FlxG.keys.S)
			{
				signalHeroCJump.dispatch();
				var angle:Number = findAngleDegree(new FlxPoint(this.x, this.y), new FlxPoint(FlxG.mouse.x, FlxG.mouse.y));
				//the x direction doesn't work because of the max velocity
				velocity.x = - _jumpPower * Math.cos(angle * Math.PI / 180);
				velocity.y = _jumpPower * Math.sin(angle * Math.PI / 180);
				//if (this.facing == FlxObject.LEFT)
				//{
					//velocity.x -= _jumpPower;
					//velocity.y -= _jumpPower;
				//}
				//else
				//{
					//velocity.x += _jumpPower;
					//velocity.y -= _jumpPower;
				//}
				cooldown = 75;
			}
			if (cooldown != 0)
				cooldown--;
		}
		
		///////////////////////////////////////////////////////////////////////////////////////////////////////////////
		
		private function moveHeroSwing():void 
		{
			//acceleration.x = acceleration.y = velocity.x = velocity.y = drag.x = drag.y = 0;
			
			//var d_theta:Number;
			//var dx:Number = _swingCenter.x - this.x;
			//var dy:Number = _swingCenter.y - this.y;
			//var theta_curr:Number = -Math.atan2(dy, dx);
			//
			//d_theta = _swingMaxTheta * Math.sin(Math.sqrt(1 / _swingRadius));
			//
			//theta_curr += d_theta;
			
			//this.x = _swingRadius * Math.cos(theta_curr) + _swingCenter.x;
			//this.y = _swingRadius * Math.sin(theta_curr) + _swingCenter.y;
			
			
			//this.angle = Math.sin(_swingMaxTheta) * 45;
			//_swingMaxTheta += 0.1;
			
			//trace("Swing data - Radius: "+_swingRadius+", Center: "+_swingCenter.x+", "+_swingCenter.y+", swingMaxTheta: "+_swingMaxTheta * 180 / Math.PI + ", d_theta: "+ d_theta *180/Math.PI + ", curr angle: "+theta_curr*180/Math.PI);
			

			
			
			//if (this.x < _swingCenter.x)
			//{
				//_thetaAcceleration += 0.000001;
			//}
			//else
			//{
				//_thetaAcceleration -= 0.000001;
			//}
			//_thetaVelocity += _thetaAcceleration;
			//
			//
			//_thetaPosition += _thetaVelocity;
			//
			//
			//
			//this.x = _swingRadius * Math.cos(_thetaPosition)  + _swingCenter.x;
			//this.y = _swingRadius * Math.sin (_thetaPosition)  + _swingCenter.y;
			//
			//
			//
			//trace("Swing data - Radius: "+_swingRadius+", Center: "+_swingCenter.x+", "+_swingCenter.y+", _angularPosition: "+_thetaPosition + ", _angularVelocity: "+_thetaVelocity+ ", _angularAcceleration: "+_thetaAcceleration);
			//
			
			
			
			physicsOff();
			
			//the counter acts to keep time
			//Math.PI/4 makes a good amplitude
			_thetaPosition = -Math.sin(_counter) *_swingMaxTheta + Math.PI/2;
			
			//0.05 is an awesome rate for SHM
			_counter -= 0.05;
			
			this.x = _swingRadius * Math.cos(_thetaPosition) + _swingCenter.x;
			this.y = _swingRadius * Math.sin(_thetaPosition) + _swingCenter.y;
			
			
			if(FlxG.keys.SPACE)
			{
				velocity.y = -_jumpPower;
				_heroState = HeroStates.HERO_NOT_SWING;
				physicsOn();
			}
			
		}
		
		///////////////////////////////////////////////////////////////////////////////////////////////////////////////
		
		/**
		 * call this function if you would like the hero to stop swinging. it sets his state and turns his physics on
		 */
		public function stopSwinging():void 
		{
			_heroState = HeroStates.HERO_NOT_SWING;
			physicsOn();
		}
		
		///////////////////////////////////////////////////////////////////////////////////////////////////////////////
		
		//the following two functions can probably be removed
		//protected function rotate() :void
		//{
			 //// Calculate gravity per frame
			 ////var g_segment :Number = this.swf.gravity / this.swf.frame_rate;
			 //var g_segment:Number = .00000000001;
			 //var this_angle:Number = findAngleDegree(_swingCenter, new FlxPoint(this.x, this.y));
//
			 //// Calculate current angle in radians for use with sin
			 //var r_angle :Number = this_angle * (Math.PI / 180);
			 //
			 //// Use our equation to get the additional change to velocity (in degrees, not radians)
			 //_thetaVelocity += (g_segment / _swingRadius) * Math.sin(r_angle) * (180 / Math.PI);
			 //this.setAngle(this_angle - _thetaVelocity);
		//}
//
		//public function setAngle(n :Number) :void
		//{
			//this.x = _swingRadius * Math.cos(n * Math.PI / 180) + _swingCenter.x;
			//this.y = _swingRadius * Math.sin(n * Math.PI / 180) + _swingCenter.y;
			//
		//}
		
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
		
		
		
		//best function name ever
		private function thisIsBullshit():void
		{
			if ( FlxG.mouse.justPressed() )
			{
				var targetPoint:FlxPoint = FlxG.mouse.getWorldPosition();
				//var playerPos:FlxPoint = new FlxPoint(x, y);
				signalHeroWhipped.dispatch(targetPoint);
				
			}
		}
		///////////////////////////////////////////////////////////////////////////////////////////////////////////////
		
		private function fireGrapple():void 
		{
			if (isHeroOnGround())
				return;
				//do nothing if i am on the ground
			
			if (FlxG.mouse.justPressed())
			{
				var dx:Number = FlxG.mouse.x - this.x;
				var dy:Number = FlxG.mouse.y - this.y;
				var angleDeg:Number = Math.atan2(dy, dx) * 180 / Math.PI;
				
				trace("angle to mouse is: " + angleDeg);
				
				signalHeroWhipped.dispatch(new FlxPoint(FlxG.mouse.x, FlxG.mouse.y));
				
				//for testing assume the grapple was valid
				_swingRadius = FlxU.getDistance(new FlxPoint(this.x, this.y), new FlxPoint(FlxG.mouse.x, FlxG.mouse.y));
				_swingMaxTheta = Math.atan(dx/dy);
				_swingCenter = new FlxPoint(FlxG.mouse.x, FlxG.mouse.y);
				_counter = 1;
				//change following line latr
				//_thetaPosition =   angleDeg + 180 ;
				//_thetaVelocity = 0;// this.velocity.x * 0.00001;
				//_thetaAcceleration = 0;
				//_angularAcceleration = _angularVelocity = _angularPosition = 0;
				
				trace("angle to swing center is: " + findAngleDegree(_swingCenter,new FlxPoint(this.x, this.y)));
				
				_heroState = HeroStates.HERO_SWING;
			}
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
			}
			else
			{
				play("walking");
			}
			
			if (state == HeroStates.HERO_SWING)
			{
				//HERE add facing code with if statement for variable
				play("swing");
			}
		}
		
		///////////////////////////////////////////////////////////////////////////////////////////////////////////////
		
		private function moveHero():void 
		{
			//this line keeps the hero from continuously accelerating the last direction pressed
			//in other words, if not pressing a key then stop accelerating in the x direction
			this.acceleration.x = 0;
				
			if(FlxG.keys.A || FlxG.keys.LEFT)
			{
				facing = FlxObject.LEFT;
				acceleration.x -= _constAccel;
			}
			else if(FlxG.keys.D || FlxG.keys.RIGHT)
			{
				facing = FlxObject.RIGHT;
				acceleration.x += _constAccel;
				
			}
			if((FlxG.keys.justPressed("W") || FlxG.keys.justPressed("SPACE")) && velocity.y == 0)
			{
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
			_lastCheckPoint = newPoint;
		}
		
		///////////////////////////////////////////////////////////////////////////////////////////////////////////////
	}

}
