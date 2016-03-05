package Alien3D.loader.misc
{
	import Alien3D.core.ICoreEventDispatcher;
	
	//
	public class ResourceData extends ICoreEventDispatcher
	{
		internal var _loaded:Boolean;//资源是否加载成功
		
		internal var _name:String; 	//资源名称
		internal var _url:String;  	//资源地址
		
		internal var _parser:*;	 	//资源解析器
		internal var _data:*;		//资源数据
		
		public function get name() : String { return this._name; }	
		public function get url() : String { return this._url; }
		
		public function ResourceData()
		{
			super();
			
			//
			this._loaded		= false;
			this._parser		= null;
			this._data			= null;
		}
		
		//
		public override function dispose() : void 
		{
		}
		
		public override function initialize() : Boolean
		{			
			return true;
		}
		
		internal virtual function setName(name:String) : void
		{
			this._name		= name;
		}
	}
}