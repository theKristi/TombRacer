package com.trdevt.gameState 
{
	import mx.core.FlexSprite;
	import mx.events.FlexEvent;
	import org.flixel.FlxButton;
	import org.flixel.FlxG;
	import org.flixel.FlxSprite;
	import org.flixel.FlxState;
	import flash.ui.Mouse;
	import org.flixel.FlxText;
	/**
	 * ...
	 * @author Anthony Della Maggiora
	 */
	public class MenuState extends FlxState 
	{
		[Embed(source = '/background.png')] private var bgPNG:Class;
		
		private var _ftTitle:FlxSprite;
		[Embed(source = '/MenuScreen/title.png')] private var titlePNG:Class;
		private var _fbLevelSelect:FlxButton;
		[Embed(source = '/MenuScreen/LevelSelectButton.png')] private var levelSelectPNG:Class;
		private var _fbCredits:FlxButton;
		[Embed(source = '/MenuScreen/CreditsButton.png')] private var creditsPNG:Class;
		
		override public function create():void
		{
			var fsMenuBackground:FlxSprite = new FlxSprite(0, 0, bgPNG);
			_ftTitle = new FlxSprite(324, 96);
			_ftTitle.loadGraphic(titlePNG);
			//_ftTitle.alignment = "center"; 
			
			_fbLevelSelect = new FlxButton(304, 235, "Level Select", _onLevelSelect);
			_fbLevelSelect.loadGraphic(levelSelectPNG);
			
			_fbCredits = new FlxButton(304,416, "Credits", _onCredits);
			_fbCredits.loadGraphic(creditsPNG);
			//_fbLevelSelect.
			add(fsMenuBackground);
			add(_ftTitle);
			add(_fbLevelSelect);
			add(_fbCredits);
		}
		
		/*=====================================================================*/
		
		private function _onLevelSelect():void
		{
			// Switch to level select state
			trace("Level Select pressed/n");
			//FlxG.switchState(new PlayState());
		}
		
		/*=====================================================================*/
		
		private function _onCredits():void 
		{
			trace("Credits pressed");
			FlxG.switchState(new CreditsState());
		}
		
	}

}