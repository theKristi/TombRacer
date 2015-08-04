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
		protected var _outerBar:Sprite;
		protected var _innerBar:Sprite;
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
		
		_outerBar = new Sprite();
		addChild(_outerBar);
		_outerBar.graphics.lineStyle(3, 0x636363);
		
		_outerBar.graphics.drawRoundRect(0, 0, 300, 20, 20);
		_outerBar.x = _width / 2 - _outerBar.width / 2;
		_outerBar.y = _height / 2 - _outerBar.height / 2;
		
		_innerBar = new Sprite();
		addChild(_innerBar);
		_innerBar.graphics.lineStyle();
		_innerBar.graphics.drawRoundRect(0, 0, 30, 20, 20);
		_innerBar.x = (_width / 2 - _innerBar.width / 2)+3;
		_innerBar.y = (_height / 2 - _innerBar.height / 2)+3;
		
		var mat:Matrix;
		mat = new Matrix();
		mat.createGradientBox(300, 20, -90 * Math.PI / 180);
		
		_innerBar.graphics.beginGradientFill("linear", new Array(0xf7dc67,0x9f7102, 0xce9f2d, 0xe4ba44, 0xf7dc67, 0x9f7102, 0xce9f2d, 0xe4ba44), new Array(1, 1, 1, 1, 1, 1, 1, 1), new Array(0, 32, 64, 96, 128, 160, 192, 224),mat);
		
		
		}

		override protected function update(Percent:Number):void 
		{
			//Update the graphics...
			_innerBar.scaleX=(Percent * _outerBar.width - 3);
		}
	}
}