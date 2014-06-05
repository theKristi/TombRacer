package 
{
	import com.trdevt.gameState.Loader;
	import com.trdevt.util.LocalSharedObjectManager;
	import org.flixel.FlxGame;
	import org.flixel.FlxG;
	import com.trdevt.gameState.TitleState;
	import com.trdevt.util.XMLManager;
	/**
	 * Drives the TombRacer project.
	 * 
	 * @author Kristi Marks
	 */
	[SWF(backgroundColor = "#FFFFFF", width = "1280", height = "768", frameRate = "30")]
	[Frame(factoryClass = "Preloader")] //Tells Flixel to use the default preloader 
	
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
			
			XMLManager.instance.init("config.xml");
			LocalSharedObjectManager.instance.init("LSO");
			Loader.instance.init();
		}
	}
}

