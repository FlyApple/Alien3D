package Alien3D.view
{
	import Alien3D.Application;
	
	import Alien3D.core.ICoreEvent;
	import Alien3D.core.ProjectionParam;
	import Alien3D.core.ns_core;
	import Alien3D.core.debug.DebugPrint;
	
	import Alien3D.render.RenderLayer3D;
	import Alien3D.render.RenderLayer3DManager;
	import Alien3D.render.RenderLayerEvent;
	import Alien3D.render.RenderSystem3D;
	
	import Alien3D.world.World3D;

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
		private var _world:World3D
		public  function set world(value:World3D) : void
		{
			this._world		= value;
		}
		
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
			
			if(this._renderSystem)
			{
				this._projectionParam.ns_core::width	= this.width;
				this._projectionParam.ns_core::height	= this.height;
				this._renderSystem.pp = this._projectionParam; //賦值並更新矩陣
			}
			
			if(this._layer)
			{ 				
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
			this.updateFrame(this._renderSystem);
		}
		
		protected virtual function onRenderLayer(layer:RenderLayer3D) : void
		{
			layer.clearBackground(this._backgroundColor[0], this._backgroundColor[1], 
				this._backgroundColor[2], this._backgroundColor[3]);
			
			this.renderFrame(this._renderSystem);
			
			layer.present();
		}
		
		public override function updateFrame(rs:RenderSystem3D) : void
		{
			if(this._world)
			{
				this._world.update(rs);
			}
		}
		
		public override function renderFrame(rs:RenderSystem3D) : void
		{
			if(this._world)
			{
				this._world.render(rs);
			}
		}
	}
}