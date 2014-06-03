package com.trdevt.sprites.obstacles 
{
	import org.flixel.FlxObject;
	import org.flixel.FlxSprite;
	
	/**
	 * ...
	 * @author Anthony Della Maggiora
	 */
	public class FireballObstacle extends Obstacle 
	{
		
		[Embed(source="../../../../../../images/SpriteSheets/LavaSheet.png")] private var _tempFireballSheet:Class;
		private var _speed;
		private var _direction;
		public function FireballObstacle(X:Number = 0, Y:Number = 0, direction:uint = FlxObject.NONE ) 
		{
			super(X, Y, _tempFireballSheet);
			this._speed = 5;
			this._direction = direction;
			
			this.loadGraphic(this._spriteSheet, true, false, 32, 32);
			this.addAnimation("idle", [1]);
			this.play("idle");
		}
		
		override public function update():void
		{
			super.update();
			if (_direction == FlxObject.NONE)
			{
				return;
			}
			else if (_direction == FlxObject.UP)
			{
				this.y -= _speed;
			}
			else if (_direction == FlxObject.DOWN)
			{
				this.y += _speed;
			}
			else if (_direction == FlxObject.LEFT)
			{
				this.x -= _speed;
			}
			else if (_direction == FlxObject.RIGHT)
			{
				this.x += _speed;
			}
			
		}
		
		override public function onCollision():void
		{
			this.kill();
		}
		
	}

}