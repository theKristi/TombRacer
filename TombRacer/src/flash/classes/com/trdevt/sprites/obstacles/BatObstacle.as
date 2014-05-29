package com.trdevt.sprites.obstacles 
{
	/**
	 * ...
	 * @author Anthony Della Maggiora
	 */
	public class BatObstacle extends Obstacle 
	{
		[Embed(source="../../../../../../images/SpriteSheets/LavaSheet.png")] private var _tempBatSheet:Class;
		private var _speed;
		private var _direction;
		public function BatObstacle(X:Number=0, Y:Number=0) 
		{
			super(X, Y, _tempBatSheet);
			this._speed = 5;
			this._direction = 1;
			
			this.loadGraphic(this._spriteSheet, true, false, 32, 32);
			this.addAnimation("idle", [1]);
			this.play("idle");
		}
		
		override public function update():void
		{
			super.update();
			this.x += _speed * _direction;
		}
		
		override public function onCollision():void
		{
			_direction *= -1;
		}
	}

}