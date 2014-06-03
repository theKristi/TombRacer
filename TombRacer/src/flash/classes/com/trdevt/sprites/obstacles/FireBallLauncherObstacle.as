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
		private var _launchTimer:FlxTimer;
		private var _direction:uint;
		
		public function FireBallLauncherObstacle(X:Number=0, Y:Number=0, direction:uint = FlxObject.NONE) 
		{
			super(X, Y);

		}
		
		public function launchFireball():FireballObstacle
		{
			return new FireballObstacle(x, y, _direction);
		}
	}

}