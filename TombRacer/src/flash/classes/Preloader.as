package
{
		import flash.display.Sprite;
		import flash.geom.Matrix;
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
		protected var _innerBar:Sprite;
		protected var _outerBar:Sprite;
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
		
		_innerBar = new Sprite();
		addChild(_innerBar);
		var mat:Matrix;
		mat = new Matrix();
		mat.createGradientBox(300,20, -90*Math.PI/180);
		
		_outerBar = new Sprite();
		addChild(_outerBar);
		_outerBar.graphics.lineStyle(3, 0x636363);
		_outerBar.graphics.drawRoundRect(0, 3, 300, 20, 20);
		_outerBar.x = _width / 2 - _outerBar.width / 2;
		_outerBar.y = _height / 2 - _outerBar.height / 2;
		
		_innerBar.graphics.beginGradientFill("linear", new Array(0xf7dc67,0x9f7102, 0xce9f2d, 0xe4ba44, 0xf7dc67, 0x9f7102, 0xce9f2d, 0xe4ba44), new Array(1, 1, 1, 1, 1, 1, 1, 1), new Array(0, 32, 64, 96, 128, 160, 192, 224),mat);
		_innerBar.graphics.drawRoundRect(0, 0, 0, 20, 20);
		_innerBar.x = _width / 2 - _outerBar.width / 2;
		_innerBar.y = _height / 2 - _outerBar.height / 2;
		
		
		}

		override protected function update(Percent:Number):void 
		{
			_innerBar.width = Percent * (_outerBar.width);
		}
	}
}