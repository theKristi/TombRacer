package com.trdevt.Buttons
{
	import org.flixel.FlxButton;
	
	/**
	 * ...
	 * @author Kristi
	 */
	public class LevelButton extends FlxButton  
	{
		public var goto:int;
		public function LevelButton(x:int, y:int, label:String,go:int,handle:Function=null)
		{
		super(x,y,label,handle);
		goto = go;
		//trace(handle);
		
		}
		
	}
	
}