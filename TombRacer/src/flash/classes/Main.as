package 
{
	import org.flixel.FlxGame;
	import org.flixel.FlxG;
	import com.trdevt.gameState.MenuState;
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
			super(100, 100, MenuState,1,60,60,true);
			FlxG.width = 1280;
			FlxG.height = 768;
		}
	}
}

