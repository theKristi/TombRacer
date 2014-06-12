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
	import org.flixel.FlxU;
	import org.flixel.FlxSound;
	import org.flixel.FlxSprite;
	import org.flixel.FlxState;
	import flash.ui.Mouse;
	import org.flixel.FlxText;
	import com.trdevt.util.XMLManager;
	import com.trdevt.util.LocalSharedObjectManager;
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
			var xmlLevels:XMLList = XMLManager.instance.xmlConfig.levels.level;
			_buildScreen(xmlLevels.length());
		
			
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
			
			var clearbutton:FlxButton = new FlxButton(5, .83 * FlxG.height, "", clearSharedData);
			clearbutton.loadGraphic(Assets.clearButton, true, false, 176, 108);
			add(fsMenuBackground);
			add(_ftHeader);
			add(_fbBack);
			add (clearbutton);
			_levels = new Array();
			var xCoords:Array = new Array();
			for (var i:int = 0; i < numberOfLevels; i++ )
			{
				var cx:int = 0;
				var button:LevelButton;
				if (i < numberOfLevels / 2)
				{
					cx = (i * 184) + 256;
					xCoords.push(cx);
					button = new LevelButton(cx, 166, "", i);
					button.onUp=function handler():void { goToLevel(this.goto); }
				}
				else 
					button = new LevelButton(xCoords[i - numberOfLevels / 2], 366, "" , i, function handler():void { goToLevel(this.goto); } );
			
				if (!locked(i))
				{
					button.loadGraphic(Assets.levelPNG, true, false, 163, 195);
					_levels.push(button);
					add(button);
					//add levelbg
					var buttonbg:FlxSprite = new FlxSprite(button.x + 10, button.y + 10, Assets.levelGraphics[i]);
					add(buttonbg);
					getResults(button, i);
				
				}
				else 
				{
					button.loadGraphic(Assets.levelLockedPNG, false, false, 163, 198);
					button.onUp=function handler():void { }
					_levels.push(button);
					add(button);
				}
			}
			
			
		}
		/*=====================================================================*/
		
		private function clearSharedData():void
		{
			//clear data
			//switchstate to select state
			LocalSharedObjectManager.instance.resetSharedOBject();
			FlxG.switchState(new SelectState(XMLManager.instance.xmlConfig));
		}
		
		/*=====================================================================*/
		
		private function _onBack():void
		{
			FlxG.switchState(new MenuState());
		}
		public static function goToLevel(eLevelnum:uint=0):void
		{
			//trace("going to level:"+ eLevelnum);
			FlxG.switchState(new PlayState(XMLManager.instance.xmlConfig, eLevelnum));
		}
		
		private function locked(i:int):Boolean
		{
			var res:Boolean = false;
			if (i!=0&&LocalSharedObjectManager.instance.getValue("Level" + (i - 1) + "fastestTime") == "00:00.00")
				res = true;
			return res;
			
		}		/*=====================================================================*/
		private function getTime(eLevel:int):String
		{
			var stringFastest:String = LocalSharedObjectManager.instance.getValue("Level" + eLevel + "fastestTime");
		
			return stringFastest;
		}
		
		/*=====================================================================*/
		private function getTrophy(eLevel:int):Class
		{
			 
			var trophyGraphic:Class;
			var trophy:FlxSprite;
			
			//look in sharedObject for trophy and time
			var stringTrophy:String = LocalSharedObjectManager.instance.getValue("Level" + eLevel + "trophy");
			if (stringTrophy != "grayed")
			{
				
				if (stringTrophy == "gold")
					trophyGraphic = Assets.SmallGold;
				if (stringTrophy == "silver")
					trophyGraphic= Assets.SmallSilver;
				if (stringTrophy == "bronze")
					trophyGraphic = Assets.SmallBronze;
			}
			else
			{
				trophyGraphic = Assets.SmallGrayed;
			}
			
			return trophyGraphic;
			
		}
		
/*=====================================================================*/
		private function getResults(eButton:LevelButton, eLevel:int):void
		{  
		  var trophy:FlxSprite = new FlxSprite(eButton.x + 15, eButton.y + 138, getTrophy(eLevel));
			 add(trophy);
		  var fastest:FlxText = new FlxText(eButton.x + 12, eButton.y + 138,eButton.width,getTime(eLevel), true);
		  fastest.setFormat( "sffedora", 20, 0xffffff, "center");
		  add(fastest);
			
		}
		
		
		override protected function parseXML(xmlTree:XML):void 
		{
			//stub, gets rid of warning
		}
		
	}//end class

}