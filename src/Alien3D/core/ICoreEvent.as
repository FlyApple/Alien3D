package Alien3D.core
{
	import flash.events.Event;

	public class ICoreEvent extends Event
	{
		public static var APPLICATION_INIT:String = "ALIEN3D_CoreEvent_InitApplication";
		public static var APPLICATION_EXIT:String = "ALIEN3D_CoreEvent_ExitApplication";
		
		public static var RENDERSYSTEM_ACTIVE:String = "ALIEN3D_CoreEvent_RenderSystemActive";
		
		private var _data:*;
		public function get data() : * { return this._data; }
		public function ICoreEvent(name:String, data:* = null)
		{
			super(name);
			
			this._data		= data;
		}
	}
}