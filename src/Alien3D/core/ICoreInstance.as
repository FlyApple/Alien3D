package Alien3D.core
{
	import flash.events.EventDispatcher;

	//
	public class ICoreInstance extends EventDispatcher implements ICoreObject
	{		
		private var _releaseInstance:Boolean;
		private var _singletonInstance:SingletonT;
		
		public function ICoreInstance(singleton:SingletonT = null)
		{
			super();
			
			//
			this._releaseInstance	= false;
			
			//
			this._singletonInstance	= singleton;
		}
		
		//不需要重载
		public function dispose() : void 
		{
			if(!this._releaseInstance)
			{ this.release(); }
		}
		
		public virtual function release() : void
		{
			//
			this._singletonInstance	= null;
			
			//
			this._releaseInstance = true;
		}
		
		public virtual function initialize() : Boolean
		{			
			return true;
		}
	}
}