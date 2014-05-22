package com.trdevt.sprites.obstacles 
{
	/**
	 * ...
	 * @author Anthony Della Maggiora
	 */
	public class BatObstacle extends Obstacle 
	{
		
		
		private var _speed;
		private var _direction;
		public function BatObstacle(X:Number=0, Y:Number=0, SimpleGraphic:Class=null) 
		{
			super(X, Y, SimpleGraphic);
			this._speed = 5;
			this._direction = 1;
		}
		
		override public function move():void
		{
			this.x += _speed * direction;
		}
		
		public function onCollision():void
		{
			_direction *= -1;
		}
		
		override public function onPlayerCollision(player:Hero):void 
		{
			player.kill();
		}
	}

}