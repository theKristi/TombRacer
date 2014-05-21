package com.trdevt.sprites.obstacles 
{
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
			
		}
		
	}

}