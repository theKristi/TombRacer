package com.trdevt.gameState 
{
	import mx.events.FlexEvent;
	import org.flixel.FlxButton;
	import org.flixel.FlxG;
	import org.flixel.FlxState;
	/**
	 * ...
	 * @author Anthony Della Maggiora
	 */
	public class MenuState extends FlxState 
	{
		
		override public function create():void
		{
			var buttonArray:Array;
			var textArray:Array;
			// Create Title Graphic
			
			// Create level select button
			/*	Button should be centered on screen
			 * 
			 */
			var buttonWidth = 100;
			var levelSelectX = (FlxG.width / 2);// - (buttonWidth / 2);
			
			var levelSelectY = (FlxG.width * (2 / 3)) + 20;
			
			var levelSelect:FlxButton = new FlxButton(levelSelectX, 20, "Level Select", onLevelSelect);
			//levelSelect.loadGraphic(
			this.add(levelSelect); 
			// Create credits button
		}
		
		/*=====================================================================*/
		
		private function onLevelSelect()
		{
			// Switch to level select state
			trace("Level Select pressed/n");
			//FlxG.switchState(new PlayState());
		}
		
	}

}