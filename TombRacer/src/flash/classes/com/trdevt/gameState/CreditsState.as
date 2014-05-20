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
		[Embed(source ='/CreditsScreen/CreditsBackbrop.png')] private var backdropPNG:Class;
		private var _fsHeader:FlxSprite;
		[Embed(source ='/CreditsScreen/CreditsHeader.png')] private var headerPNG:Class;
		private var _fbBack:FlxButton;
		[Embed(source = '/CreditsScreen/backButton.png')] private var backPNG:Class;
		private var _fsDev1:FlxSprite;
		[Embed(source='/CreditsScreen/AnthonyDellaCredit.png')]private var dev1PNG:Class;
		private var _fsDev2:FlxSprite;
		[Embed(source='/CreditsScreen/KristiMarksCredit.png')] private var dev2PNG:Class;
		private var _fsDev3:FlxSprite;
		[Embed(source='/CreditsScreen/JakeLongworthCredit.png')] private var dev3PNG:Class;
		private var _fsDev4:FlxSprite;
		[Embed(source ='/CreditsScreen/SawyerZockCredit.png')] private var dev4PNG:Class;
		
		
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
			_fsDev1 = new FlxSprite(52, 241);
			_fsDev1.loadGraphic(dev1PNG);
			
			_fsDev2 = new FlxSprite(256, 241);
			_fsDev2.loadGraphic(dev2PNG);
			
			_fsDev3 = new FlxSprite(430, 241);
			_fsDev3.loadGraphic(dev3PNG);
			
			_fsDev4 = new FlxSprite(630, 241);
			_fsDev4.loadGraphic(dev4PNG);
			
			
			
			// Add All Objects To State
			add(_fsBackground);
			add(_fsBackdrop);
			add(_fsHeader);
			add(_fbBack);
			add(_fsDev1);
			add(_fsDev2);
			add(_fsDev3);
			add(_fsDev4);
			
		}
		
		/*=====================================================================*/
		
		// Switch to menu state when back button is pressed
		private function _onBack():void
		{		
			FlxG.switchState(new MenuState());
		}
	}//end class

}