package com.trdevt.gameState 
{
	import org.flixel.FlxButton;
	import org.flixel.FlxSprite;
	import org.flixel.FlxState;
	import org.flixel.FlxText;
	import org.flixel.FlxG;
	
	/**
	 * ...
	 * @author Anthony Della Maggiora
	 */
	public class CreditsState extends FlxState 
	{
		private var _fsMenuBackground:FlxSprite;
		[Embed(source = '/background.png')] private var bgPNG:Class;
		
		private var _fsHeader:FlxSprite;
		[Embed(source = '/CreditsScreen/CreditsHeader.png')] private var headerPNG:Class;
		private var _fbBack:FlxButton;
		[Embed(source = '/CreditsScreen/backButton.png')] private var backPNG:Class;
		private var _fsDev1:FlxSprite;
		//[Embed(source = '/dev1.png')] private var dev1PNG:Class;
		private var _fsDev2:FlxSprite;
		//[Embed(source = '/dev2.png')] private var dev2PNG:Class;
		private var _fsDev3:FlxSprite;
		//[Embed(source = '/dev3.png')] private var dev3PNG:Class;
		private var _fsDev4:FlxSprite;
		//[Embed(source = '/dev4.png')] private var dev4PNG:Class;
		
		override public function create():void 
		{
			_fsMenuBackground = new FlxSprite(0, 0, bgPNG);
			
			_fsHeader = new FlxSprite(304, 21);
			_fsHeader.loadGraphic(headerPNG);
			
			
			
			_fbBack = new FlxButton(1018, 635, "", _onBack);
			_fbBack.loadGraphic(backPNG, true, false, 176, 108);
			
			add(_fsMenuBackground);
			add(_fsHeader);
			add(_fbBack);
		}
		
		/*=====================================================================*/
		
		private function _onBack():void
		{
			FlxG.switchState(new MenuState());
		}
	}//end class

}