package
{
	import flash.display.Sprite;
	
	import Alien3D.Application;
	
	[SWF(backgroundColor="#000000", width="1280", height="720", frameRate="60")]
	public class Test extends Sprite
	{
		private var _application:Application;
		
		public function Test()
		{
			this._application = new Application;
			this._application.initialize();
		}
	}
}