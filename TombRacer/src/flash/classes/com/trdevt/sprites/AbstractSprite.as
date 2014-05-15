package com.trdevt.sprites 
{
	import org.flixel.FlxSprite;
	/**
	 * ...
	 * @author Jake
	 */
	public class AbstractSprite extends FlxSprite
	{
		
		protected var  _spriteSheet:Class=null;
		
		///////////////////////////////////////////////////////////////////////////////////////////////////////////////
		
		/**
		 * constructor (mimics the FlxSprite consturctor)
		 * @param	X
		 * @param	Y
		 * @param	SimpleGraphic
		 */
		public function AbstractSprite(X:Number=0,Y:Number=0,SimpleGraphic:Class=null) 
		{
			super(X, Y, SimpleGraphic);
			
			_spriteSheet = SimpleGraphic;
			
		}
		
		///////////////////////////////////////////////////////////////////////////////////////////////////////////////
		
		/**
		 * the sprite sheet for this sprite
		 */
		public function get spriteSheet():Class
		{
			return _spriteSheet;
		}
		
		///////////////////////////////////////////////////////////////////////////////////////////////////////////////
		
		/**
		 * the sprite sheet for this sprite
		 */
		public function set spriteSheet(sheet:Class):void 
		{
			_spriteSheet = sheet;
		}
		
		///////////////////////////////////////////////////////////////////////////////////////////////////////////////
		
		/**
		 * moves the sprite around. Override this if you want the sprite to move in a predetermined way
		 */
		public function move():void 
		{
			trace("Warning! calling a stubbed function move() in AbstractSprite!");
		}
		
		///////////////////////////////////////////////////////////////////////////////////////////////////////////////
		
		/**
		 * instructs this object to build itself using values stored in the xml. The xml should have attribute names that match the attributes of this object
		 * @param	xmlTree
		 */
		public function buildFromXML(xmlTree:XML):void 
		{
			trace("Warning! calling a stubbed function buildFromXML(xmlTree:XML) in AbstractSprite!");
		}
		
		///////////////////////////////////////////////////////////////////////////////////////////////////////////////
		
	}

}