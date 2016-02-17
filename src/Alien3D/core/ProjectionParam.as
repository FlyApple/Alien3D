package Alien3D.core
{
	public class ProjectionParam
	{
		//
		public static const TYPE_PERSPECTIVE:String 	= "TYPE_Perspective";
		public static const TYPE_ORTHO:String 			= "TYPE_Ortho";	
		public static const HAND_LEFT:String 			= "HAND_Left";
		public static const HAND_RIGHT:String 			= "HAND_Right";
		
		//
		public var type:String 	= TYPE_PERSPECTIVE;
		public var hand:String 	= HAND_RIGHT;
		public var fov:Number	= 45.0;
		public var near:Number	= 0.1;
		public var far:Number	= 1000.0;
		
		// 不是必須的.內部會覆蓋掉
		ns_core var width:Number	= 640;
		ns_core var height:Number	= 480;
	}
}