package Alien3D.core
{
	public class BaseManager extends ICoreInstance
	{
		public function BaseManager()
		{
			super();
		}
		
		public override function release() : void
		{
			super.release();
		}
		
		public override function initialize() : Boolean
		{			
			if(!super.initialize())
			{ return false; }
			
			return true;
		}
	}
}