package Alien3D.view
{
	import flash.geom.Matrix3D;
	
	import Alien3D.core.debug.DebugPrint;
	import Alien3D.render.RenderLayer3D;
	import Alien3D.render.RenderLayer3DManager;
	import Alien3D.render.RenderLayerEvent;

	//
	public class SingleLayerView3D extends BaseView3D
	{
		private var _layer:RenderLayer3D;
		public function get layer3D() : RenderLayer3D { return this._layer; }
		
		//
		private var _backgroundColor:Array = [0.0, 0.0, 0.0, 1.0];
		public function set background_color(color:Array) : void 
		{ this._backgroundColor = color.length > 3 ? color : [color[0], color[1], color[2], 1.0]; }
		
		private var _projectionMatrix:Matrix3D = new Matrix3D;
		public function get pm () : Matrix3D { return this._projectionMatrix; }
		
		//
		public function SingleLayerView3D()
		{
			super();
		}
		
		protected override function onInitialize() : Boolean
		{
			if(!super.onInitialize())
			{ return false; }
			
			//
			this._layer = RenderLayer3DManager.Singleton.T.createLayer(stage);
			this._layer.addEventListener(RenderLayerEvent.INIT, function (event:RenderLayerEvent) : void
			{
				onInitialize3D();
				
				finalizeInitialize3D();
			});
			this._layer.initialize();
			
			//
			return true;
		}
		
		protected override function onInitialize3D() : Boolean
		{
			if(!super.onInitialize3D())
			{ return false; }
			
			//
			DebugPrint.output_engine("render driver : " + this._layer.driver_descrption);
			
			//
			this._layer.anti_alias = this.anti_alias;
			this.onResize();
			
			//
			return true;
		}
		
		protected override function onResize() : void
		{
			super.onResize();
			
			if(this._layer)
			{ 
				// 更新透視矩陣
				this._projectionMatrix.identity();
				this._layer.perspectiveFOVRHM(this._projectionMatrix, this.width / this.height, 45);
				
				//
				this._layer.configureBackBuffer(this.width, this.height); 
			}
		}
		
		public override function update() : void
		{
			if(this._layer)
			{
				this.onUpdateLayer(this._layer);
				this.onRenderLayer(this._layer);			
			}
		}
		
		protected virtual function onUpdateLayer(layer:RenderLayer3D) : void
		{
			this.updateFrame();
		}
		
		protected virtual function onRenderLayer(layer:RenderLayer3D) : void
		{
			layer.clearBackground(this._backgroundColor[0], this._backgroundColor[1], 
				this._backgroundColor[2], this._backgroundColor[3]);
			
			this.renderFrame();
			
			layer.present();
		}
	}
}