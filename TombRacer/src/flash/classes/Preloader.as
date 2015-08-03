package
{
		import flash.display.Sprite;
        import org.flixel.system.*;
		import flash.display.Bitmap;
	import flash.display.BitmapData;
 
	public class Preloader extends FlxPreloader
	{
		[Embed(source = "../../images/background.png")] private static var prebgPNG:Class;
		
		protected var _background:Bitmap;
		/**
		 * @private
		 */
		
		
		public function Preloader():void
		{
			className = "Main";
			super();
		}
		override protected function create():void 
		{
		_buffer = new Sprite();
		addChild(_buffer);
		_width = stage.stageWidth/_buffer.scaleX;
			_height = stage.stageHeight/_buffer.scaleY;
			_buffer.addChild(new Bitmap(new BitmapData(_width,_height,false,0x00345e)));
		_background = new prebgPNG();
		_buffer.addChild(_background);
		}

		override protected function update(Percent:Number):void 
		{
			//Update the graphics...
		}
	}
}