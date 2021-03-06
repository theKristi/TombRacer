package com.trdevt.gameState 
{
	import com.trdevt.Assets
	import mx.core.FlexSprite;
	import mx.events.FlexEvent;
	import org.flixel.FlxButton;
	import org.flixel.FlxG;
	import org.flixel.FlxSprite;
	import org.flixel.FlxState;
	import flash.ui.Mouse;
	import org.flixel.FlxText;
	import org.flixel.FlxSound; 
	/**
	 * ...
	 * @author Anthony Della Maggiora
	 */
	public class MenuState extends FlxState 
	{
		private var _fsMenuBackground:FlxSprite;
		
		private var _ftTitle:FlxSprite;
		
		private var _fbLevelSelect:FlxButton;
		
		private var _fbCredits:FlxButton;
		
		
		override public function create():void
		{
			_fsMenuBackground = new FlxSprite(0, 0, Assets.bgPNG);
			_ftTitle = new FlxSprite(324, 96);
			_ftTitle.loadGraphic(Assets.titlePNG);
			//_ftTitle.alignment = "center"; 
			
			_fbLevelSelect = new FlxButton(304, 235, "", _onLevelSelect);
			_fbLevelSelect.loadGraphic(Assets.levelSelectPNG, true, false, 662, 173);
			_fbLevelSelect.soundDown = (new FlxSound().loadEmbedded(Assets.buttonClick));
			
			_fbCredits = new FlxButton(304,416, "Credits", _onCredits);
			_fbCredits.loadGraphic(Assets.creditsPNG, true, false, 662, 173);
			_fbCredits.soundDown = (new FlxSound().loadEmbedded(Assets.buttonClick));
			//_fbLevelSelect.
			add(_fsMenuBackground);
			add(_ftTitle);
			add(_fbLevelSelect);
			add(_fbCredits);
		}
		
		/*=====================================================================*/
		
		private function _onLevelSelect():void
		{
			// Switch to level select state
			trace("Level Select pressed/n");
			FlxG.switchState(new SelectState(new XML()));
		}
		
		/*=====================================================================*/
		
		private function _onCredits():void 
		{
			trace("Credits pressed");
			FlxG.switchState(new CreditsState());
		}
		
	}

}