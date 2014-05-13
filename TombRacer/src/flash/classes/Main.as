package 
{
	import org.flixel.FlxGame;
	import com.trdevt.gameState.MenuState;
	/**
	 * Drives the TombRacer project.
	 * 
	 * @author Kristi Marks
	 */
	
	public class Main extends FlxGame
	{
		
		
		/* ---------------------------------------------------------------------------------------- */
		
		/**
		 * Constructs the Main object.
		 */
		
		[SWF(backgroundColor="#000000", width="1280", height="768", frameRate="29")]
		public function Main()
		{
			super(1280, 768, MenuState);
			
		}
	}
}

