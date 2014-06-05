package  com.trdevt.gameState 
{
	import flash.geom.Rectangle;
	import org.flixel.FlxButton;
	import org.flixel.FlxSprite;
	import org.flixel.FlxState;
	import org.flixel.FlxText;
	import org.flixel.FlxG;
	import org.flixel.plugin.photonstorm.FlxScrollingText;
	///import com.treefortress.sound.SoundAS;
	import com.trdevt.Assets;
	
	/**
	 * ...
	 * @author Kristi Marks
	 */
	public class TitleState extends FlxState  
	{
		private var _fsBackground:FlxSprite;
		
		private var _fsPressMsg:FlxSprite;
		
		private var _fsTitle:FlxSprite;
		
		
		
		override public function create():void
		{
			_fsBackground = new FlxSprite(0, 0, Assets.bgPNG);
			_fsTitle = new FlxSprite(319, 240,Assets.titlePNG);
			_fsPressMsg = new FlxSprite(230, 405, Assets.pressPNG);
			
		
			add(_fsBackground);
			add(_fsTitle);
			add(_fsPressMsg);
			//SoundAS.loadSound("./Audio/Music.mp3", "music");
			//SoundAS.playLoop("music");
			FlxG.playMusic(Assets.bgMusic,.1);
		}
		override public function update():void
		{
			if (FlxG.keys.any()||FlxG.mouse.justReleased())
				FlxG.switchState(new MenuState());
		}
		
	}
	
}