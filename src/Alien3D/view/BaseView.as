package Alien3D.view
{
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	
	import Alien3D.core.ICoreObject;

	//
	public class BaseView extends Sprite implements ICoreObject
	{
		//
		private	var _viewWidth:int;
		private var _viewHeight:int;	
		public override function get width() : Number { return this._viewWidth; }
		public override function get height() : Number { return this._viewHeight; }
		public override function set width(w:Number) : void { this._viewWidth = w; }
		public override function set height(h:Number) : void { this._viewHeight = h; }
		
		public function BaseView()
		{
			super();
		}
		
		public virtual function dispose() : void
		{
		}
		
		public virtual function initialize() : Boolean
		{
			//
			if(this.stage){ onInitStage(); }
			else{ this.addEventListener(Event.ADDED_TO_STAGE, function (event:Event) : void { onInitStage(); }); }
			return true;
		}
		
		internal function finalizeInitialize() : void
		{
			if(this.hasEventListener(ViewEvent.INIT))
			{ this.dispatchEvent(new ViewEvent(ViewEvent.INIT)); }
			
			//
			this.stage.addEventListener(Event.RESIZE, function (event:Event) : void { onResize(); });
		}
		
		internal virtual function onInitStage() : void
		{
			// Stage
			this.stage.scaleMode 				= StageScaleMode.NO_SCALE;
			this.stage.align 					= StageAlign.TOP_LEFT;
			this.stage.stageFocusRect 			= false;
			this.stage.tabChildren 				= false;
			this.stage.showDefaultContextMenu 	= false;
			
			//
			this._viewWidth		= this.stage.stageWidth;
			this._viewHeight	= this.stage.stageHeight;
			
			//
			this.finalizeInitialize();
		}
		
		protected virtual function onInitialize() : Boolean
		{
			return true;
		}
		
		protected virtual function onResize() : void
		{
			//
			this._viewWidth		= this.stage.stageWidth;
			this._viewHeight	= this.stage.stageHeight;
		}
	}
}