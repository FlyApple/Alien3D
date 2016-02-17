package
{
	import flash.display.Sprite;
	import flash.geom.Vector3D;
	
	import Alien3D.Application;
	import Alien3D.camera.Camera3D;
	import Alien3D.camera.Camera3DController;
	import Alien3D.core.ProjectionParam;
	import Alien3D.view.SingleLayerView3D;
	import Alien3D.view.View3DEvent;
	import Alien3D.world.World3D;

	
	[SWF(backgroundColor="#000000", width="1280", height="720", frameRate="60")]
	public class Test extends Sprite
	{
		private var _application:Application;
		private var _view:SingleLayerView3D;
		private var _world:World3D;
		private var _camera:Camera3D;
		private var _cameraController:Camera3DController;
		
		public function Test()
		{
			this._application = new Application;
			this._application.initialize();
			
			this._view = new SingleLayerView3D;
			this._view.anti_alias = 8;
			this._view.background_color = [0.0, 0.0, 0.1, 1.0];
			this._view.projection_param	= new ProjectionParam;
			this._view.addEventListener(View3DEvent.INIT, function init(event:View3DEvent) : void { onInit(); });
			this._view.initialize();
			this.addChild(this._view);
		}
		
		public function onInit() : void
		{
			this._world		= new World3D();
			this._world.initialize();
			
			this._camera	= new Camera3D();
			this._camera.initialize();
			this._camera.lookAtRH(new Vector3D(0, 0, 1), new Vector3D(0, 0, 0), Vector3D.Y_AXIS);
			this._camera.addController(this._cameraController = new Camera3DController);
			this._world.addChild(this._camera);
			
			this._view.world= this._world;
		}
	}
}