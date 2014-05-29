package com.trdevt.gameState 
{
	import org.flixel.FlxButton;
	import org.flixel.FlxSprite;
	import org.flixel.FlxState;
	import org.flixel.FlxText;
	import org.flixel.FlxG;
	import com.trdevt.Assets;
	
	/**
	 * ...
	 * @author Anthony Della Maggiora
	 */
	public class ResultsState extends FlxState 
	{
		
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
			var fsBackground:FlxSprite = new FlxSprite(0, 0, Assets.bgPNG);
			add(fsBackground);
			var header:FlxSprite = new FlxSprite(300, 20, Assets.ResultsHeader);
			var backCurtain:FlxSprite = new FlxSprite(30, 184, Assets.ResultsBack);
			var LevelSelect:FlxButton = new FlxButton(161, 643, "", function handler():void { FlxG.switchState(new SelectState(new XML() ))});
			LevelSelect.loadGraphic(Assets.LevelSelectSmall, true, false, 355, 143);
			if (_levelPlayed !== 8)
			{
			var Next:FlxButton = new FlxButton(775, 643, "",_gotoNext);
				Next.loadGraphic(Assets.NextLevelButton, true, false, 314, 143);
				add(Next);
			}
				var fastest:FlxText = new FlxText(35, 200, 600,"Fastest Time: "+_resultsInSeconds.toString(),true);
			fastest.setFormat( "sffedora", 55, 0xffffff, "center");
				
			
			add(header);
			add(backCurtain);
			add(LevelSelect);
			
			add(fastest);
			
			
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