package com.trdevt.sprites 
{
	import org.flixel.FlxObject;
	import org.flixel.FlxPoint;
	import org.flixel.FlxSprite;
	import org.flixel.FlxG;
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
		
		protected var _whip:FlxSprite;
		
		protected var _swingRadius:Number = 0;
		protected var _swingMaxTheta:Number = 0;
		protected var _swingCenter:FlxPoint;
		protected var _thetaPosition:Number = 0;
		protected var _thetaVelocity:Number = 0;
		protected var _thetaAcceleration:Number = 0;
		
		/**
		 * public signal for when the hero has died
		 */
		public var signalHeroHasDied:Signal;
		
		/**
		 * signal for the playstate that the player wants to whip
		 */
		public var signalHeroWhipped:Signal;

		///////////////////////////////////////////////////////////////////////////////////////////////////////////////
		
		/**
		 * constructor (mimics the FlxSprite consturctor)
		 * @param	X
		 * @param	Y
		 * @param	SimpleGraphic
		 */
		public function Hero(xmlTree:XML,X:Number=0,Y:Number=0,SimpleGraphic:Class=null) 
		{
			//super(X, Y);
			super(xmlTree, X, Y);
			
			this.spriteSheet = _sheet;
			this.loadGraphic(_spriteSheet, true, true, 32, 32 + 16);
			this.addAnimation("walking", [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11], 15, true);
			this.addAnimation("idle", [12, 13], 1, true);
			this.addAnimation("jumpUp", [14], 1, false);
			this.addAnimation("jumpDown", [18] , 1 , false);
			//this.addAnimation("jumping", [14, 18], 2, false);
			
			this.play("idle");
			this.facing = FlxObject.RIGHT;
			
			signalHeroHasDied = new Signal();
			signalHeroWhipped = new Signal(FlxPoint);
			
			_heroState = HeroStates.HERO_NOT_SWING;
			
			//_whip = new FlxSprite(0, 0);
			//_whip.width = 800;
			//_whip.height = 600;
			//
			////this is bad, remove after testing
			//FlxG.state.add(_whip);
			//_whip.drawLine(400, 0, 400, 600, FlxG.RED,10);
			
			//this.drag.x = 640;
			//this.acceleration.y = 800;//Got it just about how fast real gravity is, seems good. -Sawyer
			//this.maxVelocity.x = 150;//A value of 64 seems to be synched with the distance traveled. -Sawyer
			//this.maxVelocity.y = 10000000;//A low max velocity makes things floaty i.e. terminal velocity. Considering the
											////size of our maps terminal velocity should never be reached. -Sawyer
		}
		
		///////////////////////////////////////////////////////////////////////////////////////////////////////////////
		
		override public function update():void 
		{
			super.update();
			
			
			if (_heroState == HeroStates.HERO_NOT_SWING)
			{
				//trace("moving while not swinging!");
				moveHero();
			}
			else if (_heroState == HeroStates.HERO_SWING)
			{
				//trace("moving while swinging!");
				moveHeroSwing();
				//other move func here
			}
			
			//fireGrapple();

			//canonJump();
			
			selectAnimation();
			
			selectState();
			
		}
		
		///////////////////////////////////////////////////////////////////////////////////////////////////////////////
		
		private function canonJump():void 
		{
			if (FlxG.mouse.justPressed())
			{
				var angle = findAngleDegree(new FlxPoint(this.x, this.y), new FlxPoint(FlxG.mouse.x, FlxG.mouse.y));
				//the x direction doesn't work because of the max velocity
				velocity.x = - _jumpPower* 5 * Math.cos(angle * Math.PI / 180);
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
			}
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
			
			
			
			this.immovable = true;
			
			rotate();
			
			if(FlxG.keys.A)
			{
				_heroState = HeroStates.HERO_NOT_SWING;
				this.immovable = false;
			}
			
		}
		
		protected function rotate() :void
		{
			 // Calculate gravity per frame
			 //var g_segment :Number = this.swf.gravity / this.swf.frame_rate;
			 var g_segment:Number = .00000000001;
			 var this_angle:Number = findAngleDegree(_swingCenter, new FlxPoint(this.x, this.y));

			 // Calculate current angle in radians for use with sin
			 var r_angle :Number = this_angle * (Math.PI / 180);
			 
			 // Use our equation to get the additional change to velocity (in degrees, not radians)
			 _thetaVelocity += (g_segment / _swingRadius) * Math.sin(r_angle) * (180 / Math.PI);
			 this.setAngle(this_angle - _thetaVelocity);
		}

		public function setAngle(n :Number) :void
		{
			this.x = _swingRadius * Math.cos(n * Math.PI / 180) + _swingCenter.x;
			this.y = _swingRadius * Math.sin(n * Math.PI / 180) + _swingCenter.y;
			
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
				_swingMaxTheta = -Math.atan2(dy, dx);
				_swingCenter = new FlxPoint(FlxG.mouse.x, FlxG.mouse.y);
				//change following line latr
				_thetaPosition =   angleDeg + 180 ;
				_thetaVelocity = 0;// this.velocity.x * 0.00001;
				_thetaAcceleration = 0;
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
		}
		
		///////////////////////////////////////////////////////////////////////////////////////////////////////////////
		
		private function moveHero():void 
		{
			//this line keeps the hero from continuously accelerating the last direction pressed
			this.acceleration.x = 0;
				
			if(FlxG.keys.A)
			{
				facing = FlxObject.LEFT;
				acceleration.x -= _constAccel;
			}
			else if(FlxG.keys.D)
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
	}

}