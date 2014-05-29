﻿package 
{
	import org.flixel.FlxGame;
	import org.flixel.FlxG;
	import com.trdevt.gameState.TitleState;
	import com.trdevt.Assets;
	import org.flixel.FlxSound;
	/**
	 * Drives the TombRacer project.
	 * 
	 * @author Kristi Marks
	 */
	[SWF(backgroundColor = "#FFFFFF", width = "1280", height = "768", frameRate = "30")]
	public class Main extends FlxGame
	{
		
		
		/* ---------------------------------------------------------------------------------------- */
		
		/**
		 * Constructs the Main object.
		 */
		
		
		public function Main()
		{
			super(1280,768, TitleState,1,60,30,true);
			FlxG.width = 1280;
			FlxG.height = 768;
			//var s:FlxSound	= new FlxSound();
			//s.loadEmbedded(Assets.bgMusic, true);
			//FlxG.play = s;
			
			
		}
	}
}

