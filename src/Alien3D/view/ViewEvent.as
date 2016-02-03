package Alien3D.view
{
	import flash.events.Event;

	public class ViewEvent extends Event
	{
		public static var INIT:String	= "ALIEN3D_ViewEvent_Init";
		
		public function ViewEvent(name:String)
		{
			super(name);
		}
	}
}