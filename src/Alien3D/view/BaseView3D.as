package Alien3D.view
{
	import flash.events.Event;
	
	//
	public class BaseView3D extends BaseView
	{
		private var _antiAlias:int;
		public function get anti_alias() : int { return this._antiAlias; }
		public function set anti_alias(value:int) : void { this._antiAlias = value; }
		
		//
		public function BaseView3D()
		{
			super();
			
			this.addEventListener(ViewEvent.INIT, function (event:ViewEvent) : void 
			{
				onInitialize();
			});
		}
		
		protected override function onInitialize() : Boolean
		{
			if(!super.onInitialize())
			{ return false; }
			
			return true;
		}
		
		protected virtual function onInitialize3D() : Boolean
		{
			return true;
		}
		
		protected function finalizeInitialize3D() : void
		{
			if(this.hasEventListener(View3DEvent.INIT))
			{ this.dispatchEvent(new View3DEvent(View3DEvent.INIT)); }
			
			//
			this.stage.addEventListener(Event.ENTER_FRAME, function (event:Event) : void { update(); });
		}
		
		public virtual function update() : void
		{
		}
		
		public virtual function updateFrame() : void
		{
			
		}
		
		public virtual function renderFrame() : void
		{
			
		}
	}
}