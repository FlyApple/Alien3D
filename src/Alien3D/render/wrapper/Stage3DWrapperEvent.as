package Alien3D.render.wrapper
{
	import flash.events.Event;

	//
	public class Stage3DWrapperEvent extends Event
	{
		public static var CONTEXT3D_CREATED:String	= "ALIEN3D_Stage3DWrapperEvent_Context3D_Created";
		public static var CONTEXT3D_DISPOSED:String	= "ALIEN3D_Stage3DWrapperEvent_Context3D_Disposed";
		
		public function Stage3DWrapperEvent(name:String)
		{
			super(name);
		}
	}
}