package com.trdevt.gameState 
{
	import org.flixel.FlxState;
	/**
	 * ...
	 * @author Jake
	 */
	public class AbstractState extends FlxState
	{
		
		public function AbstractState(xmlTree:XML) 
		{
			parseXML(xmlTree);
		}
		
		
		///////////////////////////////////////////////////////////////////////////////////////////////////////////////
		
		/**
		 * This function should be overriden to determine how to parse xml data in building the state
		 * @param	xmlTree
		 */
		protected function parseXML(xmlTree:XML):void 
		{
			trace("Warning! parseXML called from AbstractState should be overridden!");
		}
		
		///////////////////////////////////////////////////////////////////////////////////////////////////////////////
		
	}

}