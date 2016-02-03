package Alien3D.render
{
	//
	import Alien3D.core.BaseManager;
	import Alien3D.core.SingletonT;

	//
	public class RenderLayerManager extends BaseManager
	{		
		//
		protected var _renderCount:Number;
		protected var _renderLayers:Vector.<RenderLayer>;
		
		//
		public function RenderLayerManager(singleton:SingletonT = null)
		{
			super(singleton); 
			
			//
			this._renderCount	= 0;
			this._renderLayers	= null;
		}
	}
}