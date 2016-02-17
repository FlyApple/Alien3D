package Alien3D.view
{
	import Alien3D.render.RenderLayer3D;

	//
	public class MutilLayerView3D extends BaseView3D
	{
		private var _layers:Vector.<RenderLayer3D>;
		
		public function MutilLayerView3D()
		{
			super();
		}
		
		public override function update() : void
		{
			for each(var layer:RenderLayer3D in this._layers)
			{
				if(layer)
				{
					this.onUpdateLayer(layer);
					this.onRenderLayer(layer);			
				}
			}
		}
		
		protected virtual function onUpdateLayer(layer:RenderLayer3D) : void
		{
			this.updateFrame(null);
		}
		
		protected virtual function onRenderLayer(layer:RenderLayer3D) : void
		{
			layer.clearBackground(0.0, 0.0, 0.0, 1.0);
			
			this.renderFrame(null);
			
			layer.present();
		}
	}
}