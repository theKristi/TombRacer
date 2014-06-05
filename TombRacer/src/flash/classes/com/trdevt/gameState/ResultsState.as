package com.trdevt.gameState 
{
	import org.flixel.FlxButton;
	import org.flixel.FlxSprite;
	import org.flixel.FlxState;
	import org.flixel.FlxText;
	import org.flixel.FlxG;
	import org.flixel.FlxU;
	import com.trdevt.Assets;
	import com.trdevt.util.XMLManager;
	import com.trdevt.util.LocalSharedObjectManager;
	
	/**
	 * ...
	 * @author Anthony Della Maggiora
	 */
	public class ResultsState extends FlxState 
	{
		[Embed(source = "../../../../../sounds/treasure.mp3")] private var _treasureSound:Class;

		
		private var _resultsInSeconds:Number 
		
		private var _levelPlayed:int;
		
		public function ResultsState(seconds:Number, LevelPlayed:int):void 
		{
			super();
			_resultsInSeconds = seconds;
			_levelPlayed = LevelPlayed;
		}
		override public function create():void 
		{
			_buildScreen();
			
			FlxG.play(_treasureSound);
		}
		
		/*=====================================================================*/
		
		private function _buildScreen():void
		{
			var fsBackground:FlxSprite = new FlxSprite(0, 0, Assets.bgPNG);
			add(fsBackground);
			var header:FlxSprite = new FlxSprite(300, 20, Assets.ResultsHeader);
			var backCurtain:FlxSprite = new FlxSprite(30, 184, Assets.ResultsBack);
			var LevelSelect:FlxButton = new FlxButton(161, 643, "", function handler():void { FlxG.switchState(new SelectState(XMLManager.instance.xmlConfig))});
			LevelSelect.loadGraphic(Assets.LevelSelectSmall, true, false, 355, 143);
			if (_levelPlayed !== 7)
			{
			var Next:FlxButton = new FlxButton(775, 643, "",_gotoNext);
				Next.loadGraphic(Assets.NextLevelButton, true, false, 314, 143);
				add(Next);
			}
			
				var xmlLevels:XMLList = XMLManager.instance.xmlConfig.levels.level;
				
				var Yours:FlxText = new FlxText(300, 550, 600,"Your Time: "+FlxU.formatTime(_resultsInSeconds,true),true);
				Yours.setFormat( "sffedora", 55, 0xffffff, "center");
				
				var partime:int=int(xmlLevels[_levelPlayed].@par);
				var par:FlxText = new FlxText(300, 450, 600,"Par Time: "+FlxU.formatTime(partime,true),true);
				par.setFormat( "sffedora", 55, 0xffffff, "center");
				
				var rank:FlxText = new FlxText(190, 200, 600,"Rank: ",true);
				rank.setFormat( "sffedora", 55, 0xffffff, "center");
				var trophy:FlxSprite = new FlxSprite(570, 200, getTrophyGraphic(partime));
				
				var currentFastest:int=getFastestTime();
				if (currentFastest > _resultsInSeconds|| currentFastest==0)
				{
					LocalSharedObjectManager.instance.setValue("Level" + _levelPlayed + "fastestTime", _resultsInSeconds.toString());
					LocalSharedObjectManager.instance.setValue("Level" + _levelPlayed+"trophy",getTrophy(partime));
				}
				
				var fastest:FlxText = new FlxText(300, 350, 650,"fastest Time: "+FlxU.formatTime(getFastestTime(),true),true);
				fastest.setFormat( "sffedora", 55, 0xffffff, "center");
			
			add(header);
			add(backCurtain);
			add(LevelSelect);
			add(par);
			add(Yours);
			add(fastest);
			add(rank);
			add(trophy);
		}
		/*=====================================================================*/
		private function getTrophyGraphic(parTime:int):Class
		{
			var t:String = getTrophy(parTime);
			var res:Class;
			if (t == "gold")
				res= Assets.GoldTrophy;
			if (t == "silver")
				res= Assets.SilverTrophy;
			if (t == "bronze")
				res = Assets.BronzeTrophy;
			return res;
		}
		/*=====================================================================*/
		private function getTrophy(parTime:int):String
		{
			if (_resultsInSeconds <= parTime / 3)
				return "gold";
			if (_resultsInSeconds <= (parTime / 3)*2)
				return "silver";
			else return "bronze";
		}
		/*=====================================================================*/
		private function getSavedTrophy():int
		{
			return int (LocalSharedObjectManager.instance.getValue("Level" + _levelPlayed+"trophy"));
		}
		/*=====================================================================*/
		private function getFastestTime():int
		{
			return int (LocalSharedObjectManager.instance.getValue("Level" + _levelPlayed+"fastestTime"));
		}
		/*=====================================================================*/
		private function _gotoNext():void
		{
			trace("going to"+ _levelPlayed++);
			SelectState.goToLevel(_levelPlayed++);
			
		}	
		private function _onBack():void
		{
			//FlxG.switchState(new SelectState());
		}
	}//end class

}