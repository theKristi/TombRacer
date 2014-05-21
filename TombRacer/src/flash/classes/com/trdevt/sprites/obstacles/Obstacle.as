package com.trdevt.sprites.obstacles 
{
	import com.trdevt.sprites.AbstractSprite;
	import com.trdevt.sprites.Hero;
	/**
	 * ...
	 * @author Anthony Della Maggiora
	 */
	public class Obstacle extends AbstractSprite 
	{
		
		public function Obstacle(X:Number=0, Y:Number=0, SimpleGraphic:Class=null) 
		{
			super(X, Y, SimpleGraphic);
			
		}
		
		//==========================================================================
		
		public function onPlayerCollision(player:Hero):void {}
	}
}