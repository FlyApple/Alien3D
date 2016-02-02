package Alien3D
{
	import flash.display.Sprite;
	
	import Alien3D.core.ICoreInstance;
	import Alien3D.core.SingletonT;
	import Alien3D.core.debug.DebugPrint;

	//
	public class Application extends ICoreInstance
	{
		private static var ms_Singleton:SingletonT;
		public  static function get Singleton() : SingletonT { return ms_Singleton; }
		
		//
		public var _sprite:Sprite;
		
		//
		public function Application(sprite:Sprite)
		{
			super(ms_Singleton = new SingletonT(this));
			
			//
			this._sprite		= sprite;
		}
		
		public override function release() : void
		{
			//
			
			//
			DebugPrint.output_application("finalize released");
			
			super.release();
		}
		
		public override function initialize() : Boolean
		{			
			if(!super.initialize())
			{ return false; }
			
			//
			DebugPrint.output_application("finalize initialized");
			return true;
		}
	}
}