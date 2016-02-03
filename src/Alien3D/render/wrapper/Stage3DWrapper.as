package Alien3D.render.wrapper
{
	import flash.display.Stage;
	import flash.display.Stage3D;
	import flash.display3D.Context3D;
	import flash.display3D.Context3DRenderMode;
	
	import flash.events.Event;
	
	import Alien3D.core.debug.DebugAssert;
	
	//
	public class Stage3DWrapper extends BaseWrapper
	{
		//
		private var _index:int;
		private var _stage3D:Stage3D;
		private var _context3D:Context3D;
		
		public function get index() : int { return this._index; }
		public function get stage3D() : Stage3D { return this._stage3D; }
		public function get context3D() : Context3D { return this._context3D; }
		
		private var _softwareRendering:Boolean;
		
		private var _backBufferWidth:int;
		private var _backBufferHeight:int;
		
		public function get width() : int { return this._backBufferWidth; }
		public function get height() : int { return this._backBufferHeight; }
		public function set width(value:int) : void { this._backBufferWidth = value; }
		public function set height(value:int) : void { this._backBufferHeight = value; }
		
		public function get driver_descrption() : String { return this._context3D == null ? "<driver error>": this._context3D.driverInfo; }
		
		public function Stage3DWrapper(stage:Stage, index:int)
		{
			super(stage);
			
			//
			this._index				= index;
			this._stage3D			= this.stage.stage3Ds[index];
			
			this._stage3D.x			= 0;
			this._stage3D.y			= 0;
			this._stage3D.visible	= true;
		}
		
		public override function dispose() : void
		{
			this._stage3D.removeEventListener(Event.CONTEXT3D_CREATE, initContext3D);
			this.freeContext3D();
			
			this._stage3D			= null;
			this._index				= -1;
		}
		
		public override function initialize() : Boolean
		{			
			if(!super.initialize())
			{ return false; }
			
			this._stage3D.addEventListener(Event.CONTEXT3D_CREATE, initContext3D, false, 1000, false);
			this._stage3D.requestContext3D(Context3DRenderMode.AUTO);
			return true;
		}
		
		private function freeContext3D() : void
		{
			// TODO Auto Generated method stub
			if (this._context3D) 
			{
				this.dispatchEvent(new Stage3DWrapperEvent(Stage3DWrapperEvent.CONTEXT3D_DISPOSED));
				this._context3D.dispose();
			}
			this._context3D = null;
		}
		
		protected function initContext3D(event:Event) : void
		{
			// TODO Auto-generated method stub
			if(this._stage3D.context3D == null)
			{
				DebugAssert("Rendering context lost!");
				return;
			}
			
			//
			this._context3D 		= this._stage3D.context3D;
			this._softwareRendering	= this._context3D.driverInfo.indexOf("Software") >= 0;
			
			//
			if(this._backBufferWidth > 0 && this._backBufferHeight > 0)
			{
				this.configureBackBuffer(this._backBufferWidth, this._backBufferHeight);
			}
			
			//
			this.dispatchEvent(new Stage3DWrapperEvent(Stage3DWrapperEvent.CONTEXT3D_CREATED));
		}
		
		public function configureBackBuffer(width:int, height:int, antiAlias:int = 0) : void
		{
			if(this._context3D)
			{ this._context3D.configureBackBuffer(width, height, antiAlias); }
		}
		
		public function clear(r:Number = 0.0, g:Number = 0.0, b:Number = 0.0, a:Number = 1.0) : void
		{
			if(this._context3D)
			{ this._context3D.clear(r, g, b, a); }
		}
		
		public function present() : void
		{ 
			if(this._context3D)
			{ this._context3D.present(); }
		}
	}
}