package Alien3D
{
	import Alien3D.core.ICoreEvent;
	import Alien3D.core.ICoreInstance;
	import Alien3D.core.SingletonT;
	import Alien3D.core.debug.DebugPrint;
	import Alien3D.render.RenderLayer3DManager;
	import Alien3D.render.RenderSystem3D;
	import Alien3D.render.wrapper.Stage3DWrapperManager;

	//
	public class Application extends ICoreInstance
	{
		private static var ms_Singleton:SingletonT;
		public  static function get Singleton() : SingletonT { return ms_Singleton; }
		public  static function get PointerI() : Application { return Singleton.T as Application; }
		
		//
		private var _wrapperManager:Stage3DWrapperManager;
		private var _layerManager:RenderLayer3DManager;
		
		//
		private var _renderSystemActive:RenderSystem3D;
		public  function get renderSystemActive() : RenderSystem3D { return this._renderSystemActive; }
		
		//
		public function Application()
		{
			super(ms_Singleton = new SingletonT(this));
			
			//
			this.addEventListener(ICoreEvent.RENDERSYSTEM_ACTIVE, function (event:ICoreEvent) : void
			{
				_renderSystemActive = event.data as RenderSystem3D;
			});
		}
		
		public override function release() : void
		{
			//
			this.dispatchEvent(new ICoreEvent(ICoreEvent.APPLICATION_EXIT, null));
			
			//
			DebugPrint.output_application("finalize released.");
			
			super.release();
		}
		
		public override function initialize() : Boolean
		{			
			if(!super.initialize())
			{ return false; }
			
			//
			this._renderSystemActive = null;
			
			//
			this._wrapperManager = new Stage3DWrapperManager();
			if(!this._wrapperManager.initialize())
			{
				DebugPrint.output_application("[Stage3DWrapperManager] initialize fail.");
				return false;
			}
			
			//
			this._layerManager = new RenderLayer3DManager();
			if(!this._layerManager.initialize())
			{
				DebugPrint.output_application("[RenderLayer3DManager] initialize fail.");
				return false;
			}
			
			//
			DebugPrint.output_application("finalize initialized.");
			
			//
			this.dispatchEvent(new ICoreEvent(ICoreEvent.APPLICATION_INIT, null));
			return true;
		}
	}
}