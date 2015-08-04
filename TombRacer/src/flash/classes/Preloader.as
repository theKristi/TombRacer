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
		protected var _bar:Sprite;
		
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
		_buffer.addChild(new Bitmap(new BitmapData(_width, _height, false, 0x00345e)));
		
		_background = new prebgPNG();
		_buffer.addChild(_background);
		
		_bar = new Sprite();
		addChild(_bar);
		_bar.graphics.lineStyle(3, 0x000000);
		_bar.graphics.beginGradientFill("linear", new Array(0xf7dc67,0x9f7102, 0xce9f2d, 0xe4ba44, 0xf7dc67, 0x9f7102, 0xce9f2d, 0xe4ba44), new Array(1, 1, 1, 1, 1, 1, 1, 1), new Array(6.25, 6, 6, 6, 6, 6, 6, 6));
		_bar.graphics.drawRoundRect(0, 0, 300, 10, 10);
		_bar.x = _width / 2 - _bar.width / 2;
		_bar.y = _height / 2 - _bar.height / 2;
		}

		override protected function update(Percent:Number):void 
		{
			//Update the graphics...
		}
	}
}