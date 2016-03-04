package Alien3D.loader.misc
{
	import Alien3D.core.ICoreClass;

	//
	public class ResourceQueueData extends ICoreClass
	{
		private var _url:String;
		private var _listener:Function;
		
		public function get url() : String { return this._url; }
		public function set url(value:String) : void 
		{ this._url = value.replace(/\\/g, "/").toLowerCase(); }
		
		public function get listener() : Function { return this._listener; }
		public function set listener(value:Function) : void { this._listener = value; }
		
		public var _parent:ResourceDependency;
		
		//
		public function ResourceQueueData()
		{
			super();
			
			//
			this._listener		= null;
			
			//
			this._parent		= null;
		}
	}
}