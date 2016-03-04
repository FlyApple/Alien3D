package Alien3D.loader.misc
{
	import Alien3D.core.ICoreEventDispatcher;
	import Alien3D.loader.ns_loader;
	
	//
	public class ResourceData extends ICoreEventDispatcher
	{
		internal var _name:String; 	//资源名称
		internal var _url:String;  	//资源地址
		internal var _parser:*;	 	//资源解析器
		
		internal var _error:Boolean;//资源是否加载成功
		internal var _length:Number;//资源大小
		internal var _data:*;		//资源数据
		
		public   function get name() : String { return this._name; }
		ns_loader function set name(value:String) : void { this._name = value; }
		
		public function get url() : String { return this._url; }
		
		public function ResourceData()
		{
			super();
			
			//
			this._data			= null;
		}
		
		//
		public override function dispose() : void 
		{
		}
		
		public override function initialize() : Boolean
		{			
			this._error			= false;
			this._length		= 0;
			return true;
		}
	}
}