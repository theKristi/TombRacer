package com.trdevt.gameState 
{
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
		
		[Embed(source = '/background.png')] private var bgPNG:Class;
		
		private var _ftHeader:FlxSprite;
		[Embed(source = '/LevelSelectScreen/LevelSelectHeader.png')] private var headerPNG:Class;
		
		private var _fbLevel:FlxButton;
		[Embed(source = '/LevelSelectScreen/LevelUnlocked_notplayed_sheet.png')] private var levelPNG:Class;
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
		
		public function SelectState(xmlTree:XML):void 
		{
			super(xmlTree);
		}
		
		override public function create():void 
		{
			var fsMenuBackground:FlxSprite = new FlxSprite(0, 0, bgPNG);
			_ftHeader = new FlxSprite(288,3);
			_ftHeader.loadGraphic(headerPNG);
			
			_fbBack = new FlxButton(.9 * FlxG.width, .9 * FlxG.height, "Back", _onBack);
			
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
			FlxG.switchState(new PlayState(xmlTree, 1));
			
			loader.removeEventListener(Event.COMPLETE, urlLoadComplete);
			loader.removeEventListener(IOErrorEvent.IO_ERROR, urlLoadError);
		}
		
		override protected function parseXML(xmlTree:XML):void 
		{
			//do nothing
		}
	}//end class

}