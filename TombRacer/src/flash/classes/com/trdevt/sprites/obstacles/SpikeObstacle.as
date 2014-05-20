package com.trdevt.sprites.obstacles 
{
	import com.trdevt.sprites.Hero;
	import org.flixel.FlxObject;
	/**
	 * ...
	 * @author Anthony Della Maggiora
	 */
	public class SpikeObstacle extends Obstacle 
	{
		[Embed(source = "../../../../../../images/SpriteSheets/SpikesSheet.png")] private var _spikeSpriteSheet:Class;
		public function SpikeObstacle(X:Number=0, Y:Number=0, SimpleGraphic:Class=null) 
		{
			super(X, Y, _spikeSpriteSheet);
			this.loadGraphic(this._spriteSheet, true, false, 32, 32);
			this.addAnimation("idle", [1]);
			this.play("idle");
			
		}
		
		override public function onPlayerCollision(player:Hero):void
		{
			if (player.isTouching(FlxObject.CEILING);
				player.alive = false;
		}
	}

}