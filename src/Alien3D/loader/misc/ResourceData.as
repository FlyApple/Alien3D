package Alien3D.loader.misc
{
	import Alien3D.core.ICoreEventDispatcher;

	//
	public class ResourceData extends ICoreEventDispatcher
	{
		internal var _name:String; 	//资源名称
		internal var _url:String;  	//资源地址
		internal var _parser:*;	 	//资源解析器
		internal var _data:*;		//资源数据
		internal var _length:Number;//资源大小
		
		public function ResourceData()
		{
			super();
		}
		
		//
		public override function dispose() : void 
		{
		}
		
		public override function initialize() : Boolean
		{			
			this._length		= 0;
			return true;
		}
	}
}