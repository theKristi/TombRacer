package com.trdevt.sprites 
{
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