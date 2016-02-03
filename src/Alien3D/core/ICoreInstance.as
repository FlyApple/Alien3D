package Alien3D.core
{
	//
	public class ICoreInstance extends ICoreEventDispatcher
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
		
		//
		public override function dispose() : void 
		{
			if(!this._releaseInstance)
			{ this.release(); }
		}
		
		public override function initialize() : Boolean
		{			
			return true;
		}
		
		//
		public virtual function release() : void
		{
			//
			this._singletonInstance	= null;
			
			//
			this._releaseInstance = true;
		}
	}
}