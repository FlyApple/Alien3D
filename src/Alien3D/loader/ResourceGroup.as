package Alien3D.loader
{
	import flash.utils.Dictionary;
	
	import Alien3D.core.ICoreEventDispatcher;
	import Alien3D.loader.misc.ResourceLoader;

	//
	public class ResourceGroup extends ICoreEventDispatcher
	{
		public static const NAME_ROOT:String = "root";
		
		//
		private var _index:int;
		private var _name:String;
		public function get index() : int { return this._index; }
		public function get name() : String { return this._name; }
		
		//
		private var _dataList:Dictionary;
		
		//
		private var _loader:ResourceLoader;
		
		//
		public function ResourceGroup(index:int, name:String)
		{
			super();
			
			//
			this._index		= index;
			this._name		= name.toLowerCase();
			this._dataList	= new Dictionary();
			
			//
			this._loader	= new ResourceLoader(this);
		}
		
		public override function dispose() : void
		{
			this.release();
			
			//
			super.dispose();
		}
		
		public virtual function release() : void
		{
		}
		
		public override function initialize() : Boolean
		{			
			if(!super.initialize())
			{ return false; }
			
			return true;
		}
		
		public function load(url:String, complateListener:Function = null) : Boolean
		{
			if(!this._loader.load(url, complateListener))
			{ return false; }
			
			return true;
		}
	}
}