package Alien3D.render
{
	import flash.events.Event;

	public class RenderLayerEvent extends Event
	{
		public static var INIT:String	= "ALIEN3D_RenderLayerEvent_Init";
		
		public function RenderLayerEvent(name:String)
		{
			super(name);
		}
	}
}