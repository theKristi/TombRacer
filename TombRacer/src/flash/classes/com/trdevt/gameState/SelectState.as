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
	 * @author Kristi Marks
	 */
	public class SelectState extends FlxState 
	{
		[Embed(source = '/background.png')] private var bgPNG:Class;
		
		private var _ftHeader:FlxSprite;
		[Embed(source = '/LevelSelectScreen/LevelSelectHeader.png')] private var headerPNG:Class;
		
		private var _fbLevel:FlxButton;
		[Embed(source = '/LevelSelectScreen/LevelUnlocked_notplayed_sheet.png')] private var levelPNG:Class;
		private var _fbBack:FlxButton;
		[Embed(source = '/LevelSelectScreen/backButton.png')] private var backPNG:Class;
				
		override public function create():void 
		{
			var fsMenuBackground:FlxSprite = new FlxSprite(0, 0, bgPNG);
			_ftHeader = new FlxSprite(288,3);
			_ftHeader.loadGraphic(headerPNG);
			
			_fbBack = new FlxButton(1029, 620, "Back", _onBack);
			_fbBack.loadGraphic(backPNG, true, false, 176, 108);
			_fbLevel = new FlxButton(186, 166,"" ,goToLevel);
			_fbLevel.loadGraphic(levelPNG, true, false, 163,195);
			
			add(fsMenuBackground);
			add(_ftHeader);
			add(_fbBack);
			add(_fbLevel)
		}
		
		/*=====================================================================*/
		
		private function _onBack():void
		{
			FlxG.switchState(new MenuState());
		}
		private function goToLevel(eLevelnum:uint=0):void
		{
			FlxG.switchState(new TestState())
		}
	}//end class

}