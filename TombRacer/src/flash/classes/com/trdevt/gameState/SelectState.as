package com.trdevt.gameState 
{
	import com.trdevt.Assets
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
			//Following code is just for testing the test state. Load up xml and pass it in
			loader = new URLLoader();
			//loader.addEventListener(Event.COMPLETE, urlLoadComplete(loader));
			loader.addEventListener(Event.COMPLETE, urlLoadComplete);
			loader.addEventListener(IOErrorEvent.IO_ERROR, urlLoadError);
			loader.load(new URLRequest("config.xml"));
		}
		
		/**
		 * this function is for testing and can be removed later on
		 * @param	event
		 */
		private function urlLoadError(event:Event):void 
		{
			trace("Oh no!" + event.toString());
		}
		
		/**
		 * this function is for testing and can be removed later on
		 * @param	loader
		 * @param	event
		 */
		private function urlLoadComplete(event:Event):void 
		{
			var xmlTree:XML = new XML(loader.data);
			
			//FlxG.switchState(new TestState(xmlTree));
			FlxG.switchState(new PlayState(xmlTree, 0));
			
			loader.removeEventListener(Event.COMPLETE, urlLoadComplete);
			loader.removeEventListener(IOErrorEvent.IO_ERROR, urlLoadError);
		}
		
		override protected function parseXML(xmlTree:XML):void 
		{
			//do nothing
		}
	}//end class

}