package Alien3D.render
{
	import flash.geom.Matrix3D;
	
	import Alien3D.render.wrapper.Stage3DWrapper;

	public class RenderSystem3D
	{
		private var _layer3D:RenderLayer3D;
		private var _wrapper3D:Stage3DWrapper;
		public function get layer3D() : RenderLayer3D { return this._layer3D; }
		public function get wrapper3D() : Stage3DWrapper { return this._wrapper3D; }
		
		private var _pm:Matrix3D = new Matrix3D;
		public function get pm () : Matrix3D { return this._pm; }
		//public function set pm (value:Matrix3D) : void { this._pm = value; }
		
		//
		public function RenderSystem3D(layer:RenderLayer3D)
		{
			this._layer3D		= layer;
			this._wrapper3D		= layer.wrapper3D;
		}
	}
}