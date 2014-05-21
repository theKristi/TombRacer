package com.trdevt.sprites.obstacles 
{
	import com.trdevt.sprites.Hero;
	/**
	 * ...
	 * @author Anthony Della Maggiora
	 */
	public class LavaObstacle extends Obstacle 
	{
		[Embed(source = "../../../../../../images/SpriteSheets/LavaSheet.png")] private var _lavaSpriteSheet:Class;
		public function LavaObstacle(X:Number=0, Y:Number=0) 
		{
			super(X, Y, _lavaSpriteSheet);
			
			this.immovable = true;
			
			this.loadGraphic(this._spriteSheet, true, false, 32, 32);
			this.addAnimation("idle", [1]);
			this.play("idle");
			
		}
		
		override public function onPlayerCollision(player:Hero):void
		{
			player.kill();
		}
	}

}