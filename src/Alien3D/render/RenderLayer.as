package Alien3D.render
{
	import flash.display.Stage;
	
	import Alien3D.core.ICoreEventDispatcher;

	//
	public class RenderLayer extends ICoreEventDispatcher
	{
		protected var _stage:Stage;
		
		// override this method, after the initialization, it should be reset is true.
		public virtual function get has_valid() : Boolean { return false; }
		
		//
		public function RenderLayer(stage:Stage)
		{
			super();
			
			//
			this._stage = stage;
		}
	}
}