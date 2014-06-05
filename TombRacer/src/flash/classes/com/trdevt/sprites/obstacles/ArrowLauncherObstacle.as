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
		private var _speed:uint;
		[Embed(source="../../../../../../images/SpriteSheets/ArrowTrapSheet.png")] private var _tempSheet:Class;
		
		public function ArrowLauncherObstacle(X:Number=0, Y:Number=0, direction:uint = FlxObject.NONE, speed:Number = 7) 
		{
			super(X, Y, _tempSheet);
			_direction = direction;
			_speed = speed;
			this.loadGraphic(this._spriteSheet, false, false, 32, 32);
			this.addAnimation("idle", [1]);
			this.play("idle");
			this.immovable = true;
		}
		
		public function launchArrow():ArrowObstacle
		{
			return new ArrowObstacle(x/32, y/32, _direction, _speed);
		}
		
	}

}