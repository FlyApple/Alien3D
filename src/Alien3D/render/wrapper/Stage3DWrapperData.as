package Alien3D.render.wrapper
{
	import flash.display.Stage;

	public class Stage3DWrapperData
	{
		public var _stage:Stage;
		public var _used:int;
		public var _count:int;
		public var _wrapper:Vector.<Stage3DWrapper>;
		
		public function Stage3DWrapperData(stage:Stage)
		{
			this._stage		= stage;
			this._used		= 0;
			this._count		= stage.stage3Ds.length;
			this._wrapper	= new Vector.<Stage3DWrapper>(this._count, true);
		}
	}
}