package Alien3D.render
{
	import flash.display.Stage;
	
	import Alien3D.core.SingletonT;

	public class RenderLayer3DManager extends RenderLayerManager
	{
		private static var ms_Singleton:SingletonT;
		public  static function get Singleton() : SingletonT { return ms_Singleton; }
		
		public function RenderLayer3DManager()
		{
			super(ms_Singleton = new SingletonT(this));
			
			//
			this._layers	= new Vector.<RenderLayer3D>();
		}
		
		//
		public override function createLayer(stage:Stage) : *
		{
			var layer:RenderLayer3D = new RenderLayer3D(stage);
			if(this.addLayer(layer))
			{ return layer; }
			return null;
		}
	}
}