package com.trdevt.gameState 
{
	import com.trdevt.Assets
	import com.trdevt.util.XMLManager;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
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
	public class SelectState extends AbstractState 
	{
		/**
		 * This global var is just for testing purposes. remove it later on
		 */
		public var loader:URLLoader;
		
		
		
		private var _ftHeader:FlxSprite;
		
		
		private var _fbLevel1:FlxButton;
		private var _fbLevel2:FlxButton;
		
		private var _fbBack:FlxButton;
		
		
		
		public function SelectState(xmlTree:XML):void 
		{
			super(xmlTree);
		}
		
		override public function create():void 
		{
			var fsMenuBackground:FlxSprite = new FlxSprite(0, 0, Assets.bgPNG);
			_ftHeader = new FlxSprite(288,3);
			_ftHeader.loadGraphic(Assets.levelheaderPNG);
			
			_fbBack = new FlxButton(.85 * FlxG.width, .83 * FlxG.height, "Back", _onBack);
			_fbBack.loadGraphic(Assets.backPNG, true, false, 176, 108);
			_fbLevel1 = new FlxButton(186, 166,"" ,goToLevel);
			_fbLevel1.loadGraphic(Assets.levelPNG, true, false, 163,195);
			
			_fbLevel2 = new FlxButton(382, 166,"" ,goToLevel);
			_fbLevel2.loadGraphic(Assets.levelPNG, true, false, 163,195);
			add(fsMenuBackground);
			add(_ftHeader);
			add(_fbBack);
			add(_fbLevel1);
			add(_fbLevel2);
		}
		
		/*=====================================================================*/
		
		private function _onBack():void
		{
			FlxG.switchState(new MenuState());
		}
		private function goToLevel(eLevelnum:uint=0):void
		{
			//FlxG.switchState(new TestState())
			FlxG.switchState (new PlayState(XMLManager.instance.xmlConfig, eLevelnum));
		}
			
		override protected function parseXML(xmlTree:XML):void 
		{
			//do nothing
		}
	}//end class

}