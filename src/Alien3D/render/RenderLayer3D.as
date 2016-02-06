package Alien3D.render
{
	import flash.display.Stage;
	import flash.geom.Matrix3D;
	
	import Alien3D.render.wrapper.Stage3DWrapper;
	import Alien3D.render.wrapper.Stage3DWrapperEvent;
	import Alien3D.render.wrapper.Stage3DWrapperManager;

	//
	public class RenderLayer3D extends RenderLayer
	{
		private var _wrapper:Stage3DWrapper;
		public function get wrapper3D() : Stage3DWrapper { return this._wrapper; }
		
		public function get driver_descrption() : String { return this._wrapper == null ? "<driver error>": this._wrapper.driver_descrption; }
		
		private var _antiAlias:int;
		public function get anti_alias() : int { return this._antiAlias; }
		public function set anti_alias(value:int) : void { this._antiAlias = value; }
		
		//
		public function RenderLayer3D(stage:Stage)
		{
			super(stage);
			
			this._wrapper = Stage3DWrapperManager.Singleton.T.allocStage3DWrapper(this.stage);
			this._wrapper.addEventListener(Stage3DWrapperEvent.CONTEXT3D_CREATED, wrapper3DCreated);
			this._wrapper.addEventListener(Stage3DWrapperEvent.CONTEXT3D_DISPOSED, wrapper3DDisposed);
		}
		
		public override function initialize() : Boolean
		{			
			if(!super.initialize())
			{ return false; }
			
			//
			this._wrapper.width = this.stage.stageWidth;
			this._wrapper.height= this.stage.stageHeight;
			if(!this._wrapper.initialize())
			{ return false; }
			
			//
			return true;
		}
		
		protected function wrapper3DDisposed(event:Stage3DWrapperEvent):void
		{
			// TODO Auto-generated method stub
			this._wrapper.removeEventListener(Stage3DWrapperEvent.CONTEXT3D_DISPOSED, wrapper3DDisposed);
			
			//
			Stage3DWrapperManager.Singleton.T.freeStage3DWrapper(this._wrapper);
			this._wrapper	= null;
		}
		
		protected function wrapper3DCreated(event:Stage3DWrapperEvent):void
		{
			// TODO Auto-generated method stub
			this._wrapper.removeEventListener(Stage3DWrapperEvent.CONTEXT3D_CREATED, wrapper3DCreated);
			
			//
			if(this.hasEventListener(RenderLayerEvent.INIT))
			{ this.dispatchEvent(new RenderLayerEvent(RenderLayerEvent.INIT)); }
		}
		
		public function configureBackBuffer(width:int, height:int) : void
		{
			this._wrapper.width = width;
			this._wrapper.height= height;
			this._wrapper.configureBackBuffer(width, height, this.anti_alias);
		}
		
		public function clearBackground(red:Number, green:Number, blue:Number, alpha:Number = 1.0) : void
		{
			this._wrapper.clear(red, green, blue, alpha);
		}
		
		public function present() : void
		{ 
			this._wrapper.present();
		}
		
		//
		public function orthoLHM(m:Matrix3D, width:Number, height:Number, zNear:Number = 0.1, zFar:Number = 1000) : void 
		{
			m.copyRawDataFrom(Vector.<Number>([
				2.0/width, 0.0, 0.0, 0.0,
				0.0, 2.0/height, 0.0, 0.0,
				0.0, 0.0, 1.0/(zFar-zNear), 0.0,
				0.0, 0.0, zNear/(zNear-zFar), 1.0
			]));
		}
		
		public function orthoRHM(m:Matrix3D, width:Number, height:Number, zNear:Number = 0.1, zFar:Number = 1000) : void 
		{
			m.copyRawDataFrom(Vector.<Number>([
				2.0/width, 0.0, 0.0, 0.0,
				0.0, 2.0/height, 0.0, 0.0,
				0.0, 0.0, 1.0/(zNear-zFar), 0.0,
				0.0, 0.0, zNear/(zNear-zFar), 1.0
			]));
		}
		
		//
		public function perspectiveFOVLHM(m:Matrix3D, aspect:Number = 0, fov:Number = 45.0, zNear:Number = 0.1, zFar:Number = 1000) : void 
		{
			var yScale:Number = 1.0/Math.tan(fov * 0.5);
			var xScale:Number = yScale / aspect; 
			m.copyRawDataFrom(Vector.<Number>([
				xScale, 0.0, 0.0, 0.0,
				0.0, yScale, 0.0, 0.0,
				0.0, 0.0, zFar/(zFar-zNear), 1.0,
				0.0, 0.0, (zNear*zFar)/(zNear-zFar), 0.0
			]));
		}
		
		public function perspectiveFOVRHM(m:Matrix3D, aspect:Number = 0, fov:Number = 45.0, zNear:Number = 0.1, zFar:Number = 1000) : void 
		{
			var yScale:Number = 1.0/Math.tan(fov * 0.5);
			var xScale:Number = yScale / aspect; 
			m.copyRawDataFrom(Vector.<Number>([
				xScale, 0.0, 0.0, 0.0,
				0.0, yScale, 0.0, 0.0,
				0.0, 0.0, zFar/(zNear-zFar), -1.0,
				0.0, 0.0, (zNear*zFar)/(zNear-zFar), 0.0
			]));
		}
	}
}