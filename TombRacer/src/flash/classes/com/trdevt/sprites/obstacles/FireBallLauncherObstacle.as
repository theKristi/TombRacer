package com.trdevt.sprites.obstacles 
{
	import org.flixel.FlxObject;
	import org.flixel.FlxTimer;
	/**
	 * ...
	 * @author Anthony Della Maggiora
	 */
	public class FireBallLauncherObstacle extends Obstacle 
	{
		//private var _launchTimer:FlxTimer;
		private var _direction:uint;
		[Embed(source="../../../../../../images/SpriteSheets/FireballTrapSprite.png")] private var _tempSheet:Class;
		
		public function FireBallLauncherObstacle(X:Number=0, Y:Number=0, direction:uint = FlxObject.NONE) 
		{
			super(X, Y, _tempSheet);
			_direction = direction;
			this.loadGraphic(this._spriteSheet);
			this.addAnimation("idle", [1]);
			this.play("idle");
		}
		
		public function launchFireball():FireballObstacle
		{
			return new FireballObstacle(x/32, y/32, _direction);
		}
	}

}