package  com.trdevt.gameState 
{
	import flash.geom.Rectangle;
	import org.flixel.FlxButton;
	import org.flixel.FlxSprite;
	import org.flixel.FlxState;
	import org.flixel.FlxText;
	import org.flixel.FlxG;
	import org.flixel.plugin.photonstorm.FlxScrollingText;
	import com.treefortress.sound.SoundAS;

	
	/**
	 * ...
	 * @author Kristi Marks
	 */
	public class TitleState extends FlxState  
	{
		private var _fsBackground:FlxSprite;
		[Embed(source = "../../../../../images/background.png")] private var bgPNG:Class;
		
		private var _fsPressMsg:FlxSprite;
		[Embed(source = "../../../../../images/PressAnyKey.png")] private var pressPNG:Class;
		
		private var _fsTitle:FlxSprite;
		[Embed(source = '/MenuScreen/title.png')] private var titlePNG:Class;
		
		
		override public function create():void
		{
			_fsBackground = new FlxSprite(0, 0, bgPNG);
			_fsTitle = new FlxSprite(319, 240,titlePNG);
			_fsPressMsg = new FlxSprite(230, 405, pressPNG);
			
		
			add(_fsBackground);
			add(_fsTitle);
			add(_fsPressMsg);
			SoundAS.loadSound("./Audio/Music.mp3", "music");
			SoundAS.playLoop("music");
			
		}
		override public function update():void
		{
			if (FlxG.keys.any()||FlxG.mouse.justReleased())
				FlxG.switchState(new MenuState());
		}
		
	}
	
}