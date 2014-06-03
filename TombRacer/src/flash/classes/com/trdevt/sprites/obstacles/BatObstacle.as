package com.trdevt.sprites.obstacles 
{
	import org.flixel.FlxObject;
	/**
	 * ...
	 * @author Anthony Della Maggiora
	 */
	public class BatObstacle extends Obstacle 
	{
		[Embed(source="../../../../../../images/SpriteSheets/bat.png")] private var _tempBatSheet:Class;
		private var _speed;
		private var _direction:uint;
		public function BatObstacle(X:Number=0, Y:Number=0, direction:uint = FlxObject.NONE) 
		{
			super(X, Y, _tempBatSheet);
			this._speed = 5;
			this._direction = direction;
			this.facing = _direction;
			this.loadGraphic(this._spriteSheet, true, true, 32, 32);
			this.addAnimation("moving", [2, 3, 4, 5], 8);
			this.play("moving");
		}
		
		override public function update():void
		{
			super.update();
			//this.facing = _direction
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
			if (_direction == FlxObject.NONE)
			{
				return;
			}
			else if (_direction == FlxObject.UP)
			{
				_direction = FlxObject.DOWN;
			}
			else if (_direction == FlxObject.DOWN)
			{
				_direction = FlxObject.UP;
			}
			else if (_direction == FlxObject.LEFT)
			{
				_direction = FlxObject.RIGHT;
			}
			else if (_direction == FlxObject.RIGHT)
			{
				_direction = FlxObject.LEFT;
			}
		}
	}

}