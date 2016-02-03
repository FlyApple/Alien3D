package Alien3D.render
{
	import flash.display.Stage;
	
	import Alien3D.core.ICoreEventDispatcher;

	//
	public class RenderLayer extends ICoreEventDispatcher
	{
		private var _stage:Stage;
		public function get stage() : Stage { return this._stage; }
		
		//
		public function RenderLayer(stage:Stage)
		{
			super();
			
			//
			this._stage = stage;
		}
	}
}