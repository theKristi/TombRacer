package
{
        import org.flixel.system.*;
 
	public class Preloader extends FlxPreloader
	{
		[Embed(source="../../images/background.png")] private static var prebgPNG:Class;
		
		public function Preloader():void
		{
			className = "Main";
			super();
		}
		override protected function create():void 
		{
				
		
		}

		override protected function update(Percent:Number):void 
		{
			//Update the graphics...
		}
	}
}