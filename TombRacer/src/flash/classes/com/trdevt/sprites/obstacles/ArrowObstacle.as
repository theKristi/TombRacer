package com.trdevt.sprites.obstacles 
{
	/**
	 * ...
	 * @author Anthony Della Maggiora
	 */
	public class ArrowObstacle extends Obstacle 
	{
		[Embed(source = "../../../../../../images/SpriteSheets/ArrowSprite.png")] private var _arrowSprite:Class;
		private var _speed:Number;
		private var _direction:Number;
		public function ArrowObstacle(X:Number=0, Y:Number=0, direction:Number = 1) 
		{
			super(X, Y, _arrowSprite);
			
			this._speed = 7;
			this._direction = direction;
			
			this.loadGraphic(this._spriteSheet, true, false, 32, 15);
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
			this.kill();
		}
	}

}