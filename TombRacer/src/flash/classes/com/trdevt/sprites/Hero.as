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

		
		/**
		 * constructor (mimics the FlxSprite consturctor)
		 * @param	X
		 * @param	Y
		 * @param	SimpleGraphic
		 */
		public function Hero(X:Number=0,Y:Number=0,SimpleGraphic:Class=null) 
		{
			super(X, Y);
			
			this.spriteSheet = _sheet;
			this.loadGraphic(_spriteSheet, true, true, 32, 32 + 16);
			this.addAnimation("walking", [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11], 15, true);
			this.addAnimation("idle", [12, 13], 1, true);
			
			this.play("idle");
			this.facing = FlxObject.RIGHT;
			
			
			this.drag.x = 640;
			this.acceleration.y = 420;
			this.maxVelocity.x = 80;
			this.maxVelocity.y = 200;
			
			
		}
		
		override public function update():void 
		{
			super.update();
			//code taken from flixel feature tutorial
			this.acceleration.x = 0;
			if(FlxG.keys.LEFT)
			{
				facing = FlxObject.LEFT;
				acceleration.x -= drag.x;
			}
			else if(FlxG.keys.RIGHT)
			{
				facing = FlxObject.RIGHT;
				acceleration.x += drag.x;
			}
			if(FlxG.keys.justPressed("UP") && velocity.y == 0)
			{
				y -= 1;
				velocity.y = -200;
			}
			
			if(velocity.x == 0)
			{
				play("idle");
			}
			else
			{
				play("walking");
			}
			
		}
		
		
	}

}