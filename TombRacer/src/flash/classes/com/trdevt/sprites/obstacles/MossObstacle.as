package com.trdevt.sprites.obstacles 
{
	import com.trdevt.sprites.Hero;
	import org.flixel.FlxObject;
	/**
	 * ...
	 * @author Anthony Della Maggiora
	 */
	public class MossObstacle extends Obstacle 
	{
		[Embed(source = "../../../../../../images/SpriteSheets/MossSheet.png")] private var _mossSpriteSheet:Class;
		public function MossObstacle(X:Number=0, Y:Number=0, SimpleGraphic:Class=null) 
		{
			super(X, Y, _mossSpriteSheet);
			this.loadGraphic(this._spriteSheet, true, false, 32, 32);
			this.addAnimation("idle", [1]);
			this.play("idle");
			
		}
		
		override public function onPlayerCollision(player:Hero):void
		{
			if (player.isTouching(FlxObject.CEILING);
			{
				this.acceleration.y = 400;
				this.maxVelocity.x = 75;
			}
		}
		
		
	}

}