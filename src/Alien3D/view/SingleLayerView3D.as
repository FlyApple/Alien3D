package Alien3D.view
{
	import Alien3D.Application;
	import Alien3D.core.ICoreEvent;
	import Alien3D.core.ProjectionParam;
	import Alien3D.core.debug.DebugPrint;
	import Alien3D.render.RenderLayer3D;
	import Alien3D.render.RenderLayer3DManager;
	import Alien3D.render.RenderLayerEvent;
	import Alien3D.render.RenderSystem3D;

	//
	public class SingleLayerView3D extends BaseView3D
	{
		private var _layer:RenderLayer3D;
		public function get layer3D() : RenderLayer3D { return this._layer; }
		
		//
		private var _backgroundColor:Array = [0.0, 0.0, 0.0, 1.0];
		public function set background_color(color:Array) : void 
		{ this._backgroundColor = color.length > 3 ? color : [color[0], color[1], color[2], 1.0]; }
		
		private var _projectionParam:ProjectionParam = new ProjectionParam;
		public function set projection_param(value:ProjectionParam) : void { this._projectionParam = value; }

		//
		private var _renderSystem:RenderSystem3D;
		
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
			this._layer.anti_alias 	= this.anti_alias;
			
			this._renderSystem		= new RenderSystem3D(this._layer);
			
			this.onResize();
			
			//
			Application.PointerI.dispatchEvent(new ICoreEvent(ICoreEvent.RENDERSYSTEM_ACTIVE, this._renderSystem));
			return true;
		}
		
		protected override function onResize() : void
		{
			super.onResize();
			
			if(this._layer)
			{ 
				// 更新透視矩陣
				this._renderSystem.pm.identity();
				switch(this._projectionParam.type)
				{
					case ProjectionParam.TYPE_ORTHO:
					{
						if(this._projectionParam.hand == ProjectionParam.HAND_LEFT)
						{ 
							this._layer.orthoLHM(this._renderSystem.pm, this.width, this.height,
								this._projectionParam.near, this._projectionParam.far);  
						}
						else
						{ 
							this._layer.orthoRHM(this._renderSystem.pm, this.width, this.height,
								this._projectionParam.near, this._projectionParam.far); 
						}
						break;
					}
					default:
					{
						if(this._projectionParam.hand == ProjectionParam.HAND_LEFT)
						{ 
							this._layer.perspectiveFOVLHM(this._renderSystem.pm, this.width / this.height, 
								this._projectionParam.fov,
								this._projectionParam.near, this._projectionParam.far);
						}
						else
						{
							this._layer.perspectiveFOVRHM(this._renderSystem.pm, this.width / this.height, 
								this._projectionParam.fov,
								this._projectionParam.near, this._projectionParam.far);		
						}
						break;
					}
				}
				
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