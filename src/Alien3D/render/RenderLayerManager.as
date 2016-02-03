package Alien3D.render
{
	//
	import flash.display.Stage;
	
	import Alien3D.core.BaseManager;
	import Alien3D.core.SingletonT;

	//
	public class RenderLayerManager extends BaseManager
	{		
		//
		protected var _count:Number;
		protected var _layers:*;
		
		//
		public function RenderLayerManager(singleton:SingletonT = null)
		{
			super(singleton); 
			
			//
			this._count		= 0;
			this._layers	= new Vector.<RenderLayer>();
		}
		
		//
		public function createLayer(stage:Stage) : *
		{
			var layer:RenderLayer = new RenderLayer(stage);
			if(this.addLayer(layer))
			{ return layer; }
			return null;
		}
		
		//
		public function deleteLayer(layer:*) : void
		{
			if(layer)
			{
				this.removeLayer(layer);
				
				layer.dispose();
				layer = null;
			}
		}
		
		//
		protected function addLayer(layer:*) : Boolean
		{
			this._layers.push(layer);
			this._count ++;
			return true;
		}
		
		protected function removeLayer(layer:*) : Boolean
		{
			var index:int = this._layers.indexOf(layer);
			if(index >= 0)
			{
				this._layers.splice(index, 1);
				this._count --;
			}
			
			if(this._count <= 0)
			{ this._count = 0; }
			
			return true;
		}
	}
}