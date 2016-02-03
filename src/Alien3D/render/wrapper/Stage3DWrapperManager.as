package Alien3D.render.wrapper
{
	import flash.display.Stage;
	import flash.utils.Dictionary;
	
	import Alien3D.core.SingletonT;
	import Alien3D.core.debug.DebugAssert;

	//
	public class Stage3DWrapperManager extends BaseWrapperManager
	{
		private static var ms_Singleton:SingletonT;
		public  static function get Singleton() : SingletonT { return ms_Singleton; }
		
		public var _wrapperData:Dictionary
		
		public function Stage3DWrapperManager()
		{
			super(ms_Singleton = new SingletonT(this));
			
			//
			this._wrapperList = new Vector.<Stage3DWrapper>();
			this._wrapperData = new Dictionary();
		}
		
		//
		public function freeStage3DLayer(wrapper:Stage3DWrapper) : void
		{
			var data:Stage3DWrapperData = this._wrapperData[wrapper.stage];
			if(data)
			{
				var l:int = this._wrapperList.indexOf(wrapper);
				this._wrapperList.splice(l, 1);
				
				if(wrapper.index >= 0 && wrapper.index < data._count)
				{
					data._wrapper[wrapper.index] = null;
					data._used --;
				}
				
				if(data._used <= 0)
				{
					delete this._wrapperData[wrapper.stage];
				}
			}
		}
		
		//
		public function allocStage3DWrapper(stage:Stage) : Stage3DWrapper
		{
			var data:Stage3DWrapperData = this._wrapperData[stage];
			if(data == null)
			{ 
				data = new Stage3DWrapperData(stage);
				this._wrapperData[stage] = data;
			}
			
			var wrapper:Stage3DWrapper = this.createStage3DWrapper(data);
			if(wrapper)
			{
				this._wrapperList.push(wrapper);
				return wrapper; 
			}
			
			//
			new DebugAssert("too many Stage3D layer used!");
			return null;
		}
		
		//
		private function createStage3DWrapper(data:Stage3DWrapperData) : Stage3DWrapper
		{
			if(data == null){ return null; }
			
			var index:int = -1;
			for(var i:int = 0; i < data._count; i ++)
			{
				if(data._wrapper[i] == null)
				{
					index = i;
					break;
				}
			}
			
			if(index >= 0)
			{
				var wrapper:Stage3DWrapper = new Stage3DWrapper(data._stage, index);
				//wrapper.initialize();
				data._wrapper[index] = wrapper;
				data._used ++;
				return wrapper;
			}
			return null;
		}
	}
}