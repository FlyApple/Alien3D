package Alien3D.core 
{
	//
	public class SingletonT extends ICoreClass
	{
		private var _classInstance:ICoreInstance;
		public function get T() : * { return this._classInstance; }
		public function SingletonT(instance:ICoreInstance)
		{
			this._classInstance	= instance;
		}
	}
}