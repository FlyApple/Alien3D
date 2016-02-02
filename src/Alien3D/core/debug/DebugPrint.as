package Alien3D.core.debug
{
	public class DebugPrint
	{
		public static const TYPE_LOAD:String 			= "Load";		
		public static const TYPE_ENGINE:String 			= "Engine";	
		public static const TYPE_RENDER:String 			= "Render";
		public static const TYPE_APPLICATION:String 	= "Application";	
		
		public static function output(type:String, text:String):void
		{
			trace("[Alien3D]["+type+"]" + text);
		}
		
		public static function output_load(text:String):void
		{
			output(DebugPrint.TYPE_LOAD, text);
		}
		
		public static function output_engine(text:String):void
		{
			output(DebugPrint.TYPE_ENGINE, text);
		}
		
		public static function output_render(text:String):void
		{
			output(DebugPrint.TYPE_RENDER, text);
		}

		public static function output_application(text:String):void
		{
			output(DebugPrint.TYPE_APPLICATION, text);
		}
	}
}