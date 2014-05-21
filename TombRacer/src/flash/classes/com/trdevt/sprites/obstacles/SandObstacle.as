package com.trdevt.sprites.obstacles 
{
	import com.trdevt.sprites.Hero;
	/**
	 * ...
	 * @author Anthony Della Maggiora
	 */
	public class SandObstacle extends Obstacle 
	{
		
		public function SandObstacle(X:Number=0, Y:Number=0, SimpleGraphic:Class=null) 
		{
			super(X, Y, SimpleGraphic);
			
			this.immovable = true;
			
			//this.loadGraphic(this._spriteSheet, true, false, 32, 32);
			//this.addAnimation("idle", [1]);
			//this.play("idle");
		}
		
		override public function onPlayerCollision(player:Hero):void
		{
			player.y -= 2;
		}
		
	}

}