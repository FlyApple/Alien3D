package Alien3D.core
{
	import flash.events.EventDispatcher;

	//
	public class ICoreEventDispatcher extends EventDispatcher implements ICoreObject
	{
		public function ICoreEventDispatcher()
		{
			super();
		}
		
		//
		public virtual function dispose() : void 
		{
		}
		
		public virtual function initialize() : Boolean
		{			
			return true;
		}
	}
}