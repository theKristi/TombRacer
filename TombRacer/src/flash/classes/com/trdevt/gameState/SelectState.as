package com.trdevt.gameState 
{
	import com.trdevt.Assets
	import com.trdevt.Buttons.LevelButton;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import mx.core.FlexSprite;
	import mx.events.FlexEvent;
	import org.flixel.FlxButton;
	import org.flixel.FlxG;
	import org.flixel.FlxSound;
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
		
		
		private var _levels:Array;
		private var _fbLevel1:FlxButton;
		//private var _fbLevel3:FlxButton;
		//private var _fbLevel4:FlxButton;
		
		private var _fbBack:FlxButton;
		
		
		
		public function SelectState(xmlTree:XML):void 
		{
			super(xmlTree);
		}
		
		override public function create():void 
		{
			_buildScreen(4);
			
			
		}
		/*=====================================================================*/
		
		private function _buildScreen(numberOfLevels:int):void
		{
			var fsMenuBackground:FlxSprite = new FlxSprite(0, 0, Assets.bgPNG);
			_ftHeader = new FlxSprite(288,3);
			_ftHeader.loadGraphic(Assets.levelheaderPNG);
			
			_fbBack = new FlxButton(.85 * FlxG.width, .83 * FlxG.height, "Back", _onBack);
			_fbBack.loadGraphic(Assets.backPNG, true, false, 176, 108);
			_fbBack.soundDown = (new FlxSound().loadEmbedded(Assets.buttonClick));
			
			add(fsMenuBackground);
			add(_ftHeader);
			add(_fbBack);
			_levels = new Array();
			for (var i:int = 0; i < numberOfLevels; i++ )
			{
				
			var button:LevelButton = new LevelButton((i * 184) + 256, 166, "" ,function handler():void { goToLevel(i); }, i);
			//trace("i1: " + i);
			//_fbLevel1.onDown = function ():void { goToLevel(i); }
			//trace("i2: " + i);
			button.loadGraphic(Assets.levelPNG, true, false, 163, 195);
			_levels.push(button);
			add(button);
			}
			
			
		}
		
		/*=====================================================================*/
		
		private function _onBack():void
		{
			FlxG.switchState(new MenuState());
		}
		private function goToLevel(eLevelnum:uint=0):void
		{
			trace("levelNum: " + eLevelnum);
			//FlxG.switchState(new TestState())
			//Following code is just for testing the test state. Load up xml and pass it in
			loader = new URLLoader();
			//loader.addEventListener(Event.COMPLETE, urlLoadComplete(loader));
			loader.addEventListener(Event.COMPLETE, function han():void{urlLoadComplete(null,eLevelnum)});
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
		private function urlLoadComplete(event:Event, level:int):void 
		{
			var xmlTree:XML = new XML(loader.data);
			
			//FlxG.switchState(new TestState(xmlTree));
			FlxG.switchState(new PlayState(xmlTree, level));
			
			loader.removeEventListener(Event.COMPLETE, urlLoadComplete);
			loader.removeEventListener(IOErrorEvent.IO_ERROR, urlLoadError);
		}
		
		override protected function parseXML(xmlTree:XML):void 
		{
			//do nothing
		}
	}//end class

}