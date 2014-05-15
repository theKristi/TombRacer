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
		[Embed(source = '/background.png')] private var bgPNG:Class;
		
		private var _ftTitle:FlxText;
		[Embed(source = '/buttonGraphicPH.png')] private var textPNG:Class;
		private var _fbBack:FlxButton;
		[Embed(source = '/buttonGraphicPH.png')] private var backPNG:Class;
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
			_ftTitle = new FlxText(0, 0, FlxG.width, "Credits", true);
			_ftTitle.alignment = "center";
			
			_fbBack = new FlxButton(.9 * FlxG.width, .9 * FlxG.height, "Back", _onBack);
			
			add(_ftTitle);
			add(_fbBack);
		}
		
		/*=====================================================================*/
		
		private function _onBack():void
		{
			FlxG.switchState(new MenuState());
		}
	}//end class

}