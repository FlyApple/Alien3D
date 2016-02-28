package Alien3D.loader.parser.base
{
	import Alien3D.core.ICoreEvent;
	import Alien3D.loader.misc.ResourceData;

	//
	public class ParserEvent extends ICoreEvent
	{
		public static var PARSER_INIT:String = "ALIEN3D_ParserEvent_InitParser";
		public static var PARSER_FREE:String = "ALIEN3D_ParserEvent_FreeParser";
		public static var DATA_LOADED:String = "ALIEN3D_ParserEvent_Data_Loaded";
		public static var DATA_PARSED:String = "ALIEN3D_ParserEvent_Data_Parsed";
		
		private var _resource:ResourceData;
		public function get resource() : ResourceData { return this._resource; }
		
		public function ParserEvent(name:String, resource:ResourceData, data:* = null)
		{
			super(name, data);
			
			//
			this._resource = resource;
		}
	}
}