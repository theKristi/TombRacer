package com.trdevt.sprites 
{
	import org.flixel.FlxObject;
	import org.flixel.FlxSprite;
	import org.flixel.FlxG;
	/**
	 * ...
	 * @author Jake
	 */
	public class Hero extends AbstractSprite
	{
		
		[Embed(source = '../../../../../images/SpriteSheets/IndieWalkSheet.png')] private static var _sheet:Class;
		
		protected var _jumpPower:Number;
		
		protected var _constAccel:Number;

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
			this.addAnimation("jumping", [14, 18], 2, false);
			
			this.play("idle");
			this.facing = FlxObject.RIGHT;
			
			
			
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
			//code taken from flixel feature tutorial
			this.acceleration.x = 0;
			
						
			if(FlxG.keys.LEFT)
			{
				facing = FlxObject.LEFT;
				acceleration.x -= _constAccel;
			}
			else if(FlxG.keys.RIGHT)
			{
				facing = FlxObject.RIGHT;
				acceleration.x += _constAccel;
				
			}
			if(FlxG.keys.justPressed("UP") && velocity.y == 0)
			{
				//Through testing I have determined that velocity increases by 12.8 every frame
				//Coincidentally, this is the vertical resolution divided by framerate. -Sawyer
				//Jump height is determined by a relationship between this value and acceleration.
				//Currenly the height is slightly over three blocks. -Sawyer
				y -= 1;
				velocity.y = -_jumpPower;
				//this.play("jumping", true);
			}
			
			if (velocity.y != 0)
			{
				play("jumping");
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
		
		
	}

}