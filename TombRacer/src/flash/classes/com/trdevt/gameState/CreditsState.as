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
		private var _fsBackground:FlxSprite;
		[Embed(source="../../../../../images/background.png")] private var bgPNG:Class;
		private var _fsBackdrop:FlxSprite;
		[Embed(source = '/CreditsScreen/CreditsBackbrop.png')] private var backdropPNG:Class;
		private var _fsHeader:FlxSprite;
		[Embed(source = '/CreditsScreen/CreditsHeader.png')] private var headerPNG:Class;
		private var _fbBack:FlxButton;
		[Embed(source = '/CreditsScreen/backButton.png')] private var backPNG:Class;
		private var _fsDev1:FlxSprite;
		[Embed(source="../../../../../images/CreditsScreen/AnthonyDella.png")]private var dev1PNG:Class;
		private var _fsDev2:FlxSprite;
		[Embed(source="../../../../../images/CreditsScreen/jakeAR.png")] private var dev2PNG:Class;
		private var _fsDev3:FlxSprite;
		[Embed(source="../../../../../images/CreditsScreen/SawyerZock.png")] private var dev3PNG:Class;
		private var _fsDev4:FlxSprite;
		//[Embed(source = '/dev4.png')] private var dev4PNG:Class;
		private var _ftDev1Desc:FlxText;
		private var _ftDev2Desc:FlxText;
		private var _ftDev3Desc:FlxText;
		private var _ftDev4Desc:FlxText;
		
		override public function create():void 
		{
			// Create Background
			_fsBackground = new FlxSprite(0, 0, bgPNG);
			
			_fsHeader = new FlxSprite(304, 21);
			_fsHeader.loadGraphic(headerPNG);
			
			// Create Backdrop
			_fsBackdrop = new FlxSprite(36,184);
			_fsBackdrop.loadGraphic(backdropPNG);
			
			// Create Back Button
			_fbBack = new FlxButton(1018, 635, "", _onBack);
			_fbBack.loadGraphic(backPNG, true, false, 176, 108);
			
			// Create Dev Portraits
			_fsDev1 = new FlxSprite(25, 200);
			_fsDev2 = new FlxSprite(_fsDev1.x + 150, _fsDev1.y);
			_fsDev3 = new FlxSprite(_fsDev2.x + 150, _fsDev1.y);
			_fsDev4 = new FlxSprite(_fsDev3.x + 150, _fsDev1.y);
			
			// Create Dev Descriptions
			_ftDev1Desc = new FlxText(_fsDev1.x, _fsDev1.y + 30, 40, "Dev1");
			_ftDev2Desc = new FlxText(_fsDev2.x, _fsDev2.y + 30, 40, "Dev2");
			_ftDev3Desc = new FlxText(_fsDev3.x, _fsDev3.y + 30, 40, "Dev3");
			_ftDev4Desc = new FlxText(_fsDev4.x, _fsDev4.y + 30, 40, "Dev4");
			
			// Add All Objects To State
			add(_fsBackground);
			add(_fsBackdrop);
			add(_fsHeader);
			add(_fbBack);
			add(_fsDev1);
			add(_fsDev2);
			add(_fsDev3);
			add(_fsDev4);
			add(_ftDev1Desc);
			add(_ftDev2Desc);
			add(_ftDev3Desc);
			add(_ftDev4Desc);
		}
		
		/*=====================================================================*/
		
		// Switch to menu state when back button is pressed
		private function _onBack():void
		{		
			FlxG.switchState(new MenuState());
		}
	}//end class

}