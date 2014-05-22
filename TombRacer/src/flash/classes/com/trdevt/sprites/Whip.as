package com.trdevt.sprites 
{
	import org.flixel.FlxCamera;
	import org.flixel.FlxG;
	import org.flixel.FlxPoint;
	import org.flixel.FlxSprite;
	/** may not need this class
	 * ...
	 * @author Jake
	 */
	public class Whip extends FlxSprite
	{
		///////////////////////////////////////////////////////////////////////////////////////////////////////////////
		
		public function Whip():void 
		{
			super(0, 0);
			
			this.makeGraphic(FlxG.width, FlxG.height, 0x00000000);
		}
		
	}

}