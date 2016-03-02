package Alien3D.loader
{
	import Alien3D.core.SingletonT;

	//
	public class ExtendParserTypes extends BaseParserTypes
	{
		private static var ms_Singleton:SingletonT;
		public  static function get Singleton() : SingletonT { return ms_Singleton; }
		public  static function get PointerI() : ExtendParserTypes { return Singleton.T as ExtendParserTypes; }
		
		public function ExtendParserTypes()
		{
			super(ms_Singleton = new SingletonT(this));
		}
		
		public override function initialize() : Boolean
		{			
			if(!super.initialize())
			{ return false; }
			
			// added extend parser.
			
			//
			return true;
		}
	}
}