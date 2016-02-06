package
{
	import flash.display.Sprite;
	
	import Alien3D.Application;
	import Alien3D.core.ProjectionParam;
	import Alien3D.view.SingleLayerView3D;
	import Alien3D.view.View3DEvent;
	
	[SWF(backgroundColor="#000000", width="1280", height="720", frameRate="60")]
	public class Test extends Sprite
	{
		private var _application:Application;
		private var _view:SingleLayerView3D;
		
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
			
		}
	}
}