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
		_background = new prebgPNG();
		_buffer.addChild(_background);
		}

		override protected function update(Percent:Number):void 
		{
			//Update the graphics...
		}
	}
}