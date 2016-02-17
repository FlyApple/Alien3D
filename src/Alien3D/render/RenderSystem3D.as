package Alien3D.render
{
	import flash.geom.Matrix3D;
	
	import Alien3D.core.ns_core;
	import Alien3D.core.ProjectionParam;
	import Alien3D.render.wrapper.Stage3DWrapper;

	//
	use namespace ns_core;
	
	//
	public class RenderSystem3D
	{
		private var _layer3D:RenderLayer3D;
		private var _wrapper3D:Stage3DWrapper;
		public function get layer3D() : RenderLayer3D { return this._layer3D; }
		public function get wrapper3D() : Stage3DWrapper { return this._wrapper3D; }
		
		private var _pp:ProjectionParam = new ProjectionParam;
		public function get pp () : ProjectionParam { return this._pp; }
		public function set pp (value:ProjectionParam) : void 
		{
			if(this._pp != value)
			{ this._pp = value; }
			
			// 更新透視矩陣
			updatePM();
		}
		
		private var _pm:Matrix3D = new Matrix3D;
		public function get pm () : Matrix3D { return this._pm; }
		//public function set pm (value:Matrix3D) : void { this._pm = value; }
		
		private var _vm:Matrix3D = new Matrix3D;
		public function get vm () : Matrix3D { return this._vm; }
		public function set vm (value:Matrix3D) : void 
		{ 
			this._vm = value; 
			
			//
			this._vpm.identity();
			this._vpm.copyFrom(this._vm);
			this._vpm.append(this.pm);
		}
		
		private var _wm:Matrix3D;
		public function get wm() : Matrix3D { return this._wm; }
		public function set wm (value:Matrix3D) : void 
		{ 
			this._wm = value; 
			
			//
			this._wvpm.identity();
			this._wvpm.copyFrom(this._wm);
			this._wvpm.append(this.vpm);
		}
		
		private var _vpm:Matrix3D;
		public function get vpm() : Matrix3D { return this._vpm; }
		private var _wvpm:Matrix3D;
		public function get wvpm() : Matrix3D { return this._wvpm; }
		
		//
		public function RenderSystem3D(layer:RenderLayer3D)
		{
			this._layer3D		= layer;
			this._wrapper3D		= layer.wrapper3D;
		}
		
		//
		private function updatePM() : void
		{
			this._pm.identity();
			switch(this._pp.type)
			{
				case ProjectionParam.TYPE_ORTHO:
				{
					if(this._pp.hand == ProjectionParam.HAND_LEFT)
					{ 
						this._layer3D.orthoLHM(this._pm, this._pp.width, this._pp.height,
							this._pp.near, this._pp.far);  
					}
					else
					{ 
						this._layer3D.orthoRHM(this._pm, this._pp.width, this._pp.height,
							this._pp.near, this._pp.far); 
					}
					break;
				}
				default:
				{
					if(this._pp.hand == ProjectionParam.HAND_LEFT)
					{ 
						this._layer3D.perspectiveFOVLHM(this._pm, this._pp.width / this._pp.height, 
							this._pp.fov, this._pp.near, this._pp.far);
					}
					else
					{
						this._layer3D.perspectiveFOVRHM(this._pm, this._pp.width / this._pp.height, 
							this._pp.fov, this._pp.near, this._pp.far);		
					}
					break;
				}
			}
		}
	}
}