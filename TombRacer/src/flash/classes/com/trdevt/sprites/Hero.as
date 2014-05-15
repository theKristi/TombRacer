package com.trdevt.sprites 
{
	import org.flixel.FlxObject;
	import org.flixel.FlxSprite;
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
			
			
		}
		
		
	}

}