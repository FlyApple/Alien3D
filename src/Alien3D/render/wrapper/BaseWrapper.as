package Alien3D.render.wrapper
{
	import flash.display.Stage;
	
	import Alien3D.core.ICoreEventDispatcher;

	//
	public class BaseWrapper extends ICoreEventDispatcher
	{
		private var _stage:Stage;
		public function get stage() : Stage { return this._stage; }
		
		public function BaseWrapper(stage:Stage)
		{
			super();
			
			//
			this._stage = stage;
		}
		
		public override function initialize() : Boolean
		{			
			if(!super.initialize())
			{ return false; }
			
			return true;
		}
	}
}