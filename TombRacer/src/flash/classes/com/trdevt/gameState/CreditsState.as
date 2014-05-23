package com.trdevt.gameState 
{
	import com.trdevt.Assets;
	import flash.geom.Rectangle;
	import org.flixel.FlxButton;
	import org.flixel.FlxSprite;
	import org.flixel.FlxState;
	import org.flixel.FlxText;
	import org.flixel.FlxG;
	import org.flixel.plugin.photonstorm.FlxScrollingText;
	
	
	/**
	 * ...
	 * @author Anthony Della Maggiora
	 */
	public class CreditsState extends FlxState 
	{
		private var _fsHeader:FlxSprite;
		private var _fsBackground:FlxSprite;
		public var _fsBackdrop:FlxSprite;
		public var _fbBack:FlxButton;
		public var _fsDev1:FlxSprite;
		public var _fsDev2:FlxSprite;
		public var _fsDev3:FlxSprite;
		public var _fsDev4:FlxSprite;
		public var _fsScroll:FlxSprite;
		
		private var credits:Array;
		
		private var creditSpeed:int = 2;
		private var maxy:int = 525;
		override public function create():void 
		{
			credits = new Array();
			// Create Background
			_fsBackground = new FlxSprite(0, 0, Assets.bgPNG);
			
			_fsHeader = new FlxSprite(304, 21,Assets.creditsheaderPNG);
			
			
			// Create Backdrop
			_fsBackdrop = new FlxSprite(36,184,Assets.backdropPNG);
			
			// Create Back Button
			_fbBack = new FlxButton(1018, 635, "", _onBack);
			_fbBack.loadGraphic(Assets.backPNG, true, false, 176, 108);
			
			_fsScroll = new FlxSprite(853, 203, Assets.scrollerOutlinePNG);
			
			var credit1:FlxText = new FlxText(855, maxy, 379, "hellooo\nworld",true);
			credit1.setFormat( "sffedora", 28, 0xffffff, "center");
			credits.push(credit1);
			
			// Create Dev Portraits
			_fsDev1 = new FlxSprite(52, 241,Assets.dev1PNG);
			
			_fsDev2 = new FlxSprite(256, 241,Assets.dev2PNG);
			
			_fsDev3 = new FlxSprite(430, 241, Assets.dev3PNG);
			
			_fsDev4 = new FlxSprite(630, 241,Assets.dev4PNG);
			
			
			
			
			// Add All Objects To State
			add(_fsBackground);
			add(_fsBackdrop);
			add(_fsHeader);
			add(_fbBack);
			add(_fsDev1);
			add(_fsDev2);
			add(_fsDev3);
			add(_fsDev4);
			add(_fsScroll);
			add(credit1);
			
		}
		/*=====================================================================*/
		
		//animate scrolling credits
		override public function update():void
		{
			for (var i:int = 0; i < credits.length; i++ )
			{
				var credit:FlxText = FlxText(credits[i]);
				if (credit.y<=maxy&&credit.y>=203)
				{
					credit.y -= creditSpeed;
				}
				else
				{
					credit.visible = false;
					credit.y = maxy;
				}
			}
			super.update();
		}
		
		/*=====================================================================*/
		
		// Switch to menu state when back button is pressed
		private function _onBack():void
		{		
			FlxG.switchState(new MenuState());
		}
	}//end class

}