package com.trdevt.sprites.obstacles 
{
	import org.flixel.FlxObject;
	/**
	 * ...
	 * @author Anthony Della Maggiora
	 */
	public class ArrowLauncherObstacle extends Obstacle 
	{
		private var _direction:uint;
		[Embed(source="../../../../../../images/SpriteSheets/ArrowTrapSheet.png")] private var _tempSheet:Class;
		
		public function ArrowLauncherObstacle(X:Number=0, Y:Number=0, direction:uint = FlxObject.NONE) 
		{
			super(X, Y, _tempSheet);
			_direction = direction;
			this.loadGraphic(this._spriteSheet, false, false, 32, 32);
			this.addAnimation("idle", [1]);
			this.play("idle");
		}
		
		public function launchArrow():ArrowObstacle
		{
			return new ArrowObstacle(x/32, y/32, _direction);
		}
		
	}

}