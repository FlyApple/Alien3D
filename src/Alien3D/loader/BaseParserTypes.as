package Alien3D.loader
{
	import Alien3D.core.ICoreInstance;
	import Alien3D.core.SingletonT;

	//
	public class BaseParserTypes extends ICoreInstance
	{
		private var _types:Vector.<Class> = Vector.<Class>([
		]);
		
		public function BaseParserTypes(singleton:SingletonT = null)
		{
			super(singleton);
		}
		
		public override function release() : void
		{
			super.release();
		}
		
		public override function initialize() : Boolean
		{			
			if(!super.initialize())
			{ return false; }
			
			// added base and core parser.
			
			//
			return true;
		}
		
		public function ParserTypes() : Vector.<Class>
		{
			return _types;
		}
		
		public function AppendTypes(o:Class) : void
		{
			_types.push(o);
		}
	}
}