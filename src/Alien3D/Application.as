package Alien3D
{
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	
	import Alien3D.core.ICoreEvent;
	import Alien3D.core.ICoreInstance;
	import Alien3D.core.SingletonT;
	import Alien3D.core.debug.DebugPrint;
	import Alien3D.loader.ExtendParserTypes;
	import Alien3D.render.RenderLayer3DManager;
	import Alien3D.render.RenderSystem3D;
	import Alien3D.render.wrapper.Stage3DWrapperManager;

	//
	public class Application extends ICoreInstance
	{
		private static var ms_Singleton:SingletonT;
		public  static function get Singleton() : SingletonT { return ms_Singleton; }
		public  static function get PointerI() : Application { return Singleton.T as Application; }
		
		//
		private var _mainSprite:Sprite;
		private var _mainStage:Stage;
		
		//
		private var _wrapperManager:Stage3DWrapperManager;
		private var _layerManager:RenderLayer3DManager;
		private var _extendParserTypes:ExtendParserTypes;
		
		// 僅僅用與資源加載時使用,並不參與其它部分
		private var _renderSystemActive:RenderSystem3D;
		public  function get renderSystemActive() : RenderSystem3D { return this._renderSystemActive; }
		
		//
		public function Application(main:Sprite = null)
		{
			super(ms_Singleton = new SingletonT(this));
			
			// 是可選的,不是必須的
			this._mainSprite	= main;
			if(this._mainSprite)
			{
				if(this._mainSprite.stage){ onInitMainStage(); }
				this._mainSprite.addEventListener(Event.ADDED_TO_STAGE, function (event:Event) : void
				{
					onInitMainStage();
				});
			}

			//
			this.addEventListener(ICoreEvent.RENDERSYSTEM_ACTIVE, function (event:ICoreEvent) : void
			{
				_renderSystemActive = event.data as RenderSystem3D;
			});
		}
		
		public override function release() : void
		{
			//
			this.dispatchEvent(new ICoreEvent(ICoreEvent.APPLICATION_EXIT, null));
			
			//
			DebugPrint.output_application("finalize released.");
			
			super.release();
		}
		
		public override function initialize() : Boolean
		{			
			if(!super.initialize())
			{ return false; }
			
			//
			this._renderSystemActive = null;
			
			//
			this._wrapperManager = new Stage3DWrapperManager();
			if(!this._wrapperManager.initialize())
			{
				DebugPrint.output_application("[Stage3DWrapperManager] initialize fail.");
				return false;
			}
			
			//
			this._layerManager = new RenderLayer3DManager();
			if(!this._layerManager.initialize())
			{
				DebugPrint.output_application("[RenderLayer3DManager] initialize fail.");
				return false;
			}
			
			//
			this._extendParserTypes = new ExtendParserTypes();
			if(!this._extendParserTypes.initialize())
			{
				DebugPrint.output_application("[ExtendParserTypes] initialize fail.");
				return false;		
			}
			
			//
			DebugPrint.output_application("finalize initialized.");
			
			//
			this.dispatchEvent(new ICoreEvent(ICoreEvent.APPLICATION_INIT, null));
			return true;
		}
		
		private function onInitMainStage() : void
		{
			// Stage
			this._mainStage							= this._mainSprite.stage;
			this._mainStage.scaleMode 				= StageScaleMode.NO_SCALE;
			this._mainStage.align 					= StageAlign.TOP_LEFT;
			this._mainStage.stageFocusRect 			= false;
			this._mainStage.tabChildren 			= false;
			this._mainStage.showDefaultContextMenu 	= false;
			
			//
//			this._mainStage.addEventListener(MouseEvent.RIGHT_MOUSE_UP, function (e:MouseEvent) : void {
//				//移除右鍵菜單
//			});
//			this._mainStage.addEventListener(MouseEvent.RIGHT_MOUSE_DOWN, function (e:MouseEvent) : void {
//				//移除右鍵菜單
//			});
		}
	}
}