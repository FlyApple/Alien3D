package Alien3D.render.wrapper
{
	import Alien3D.core.BaseManager;
	import Alien3D.core.SingletonT;

	//
	public class BaseWrapperManager extends BaseManager
	{
		protected var _wrapperList:*;
		
		public function BaseWrapperManager(singleton:SingletonT = null)
		{
			super(singleton);
		}
	}
}