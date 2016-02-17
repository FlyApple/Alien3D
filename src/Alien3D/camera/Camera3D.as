package Alien3D.camera
{
	import flash.geom.Matrix3D;
	import flash.geom.Vector3D;
	
	import Alien3D.render.RenderSystem3D;
	import Alien3D.world.WorldNode3D;


	//
	public class Camera3D extends WorldNode3D
	{		
		private var _lm:Matrix3D;
		private var _vm:Matrix3D;
		public function get vm() : Matrix3D { return this._vm; }
		
		private var _pos:Vector3D;
		private var _rot:Vector3D;
		public function get pos() : Vector3D { return this._pos; }
		public function get rot() : Vector3D { return this._rot; }
		
		private var _controllerActive:Camera3DController;
		private var _controllers:Vector.<Camera3DController>;
		
		public function Camera3D(name:String = null)
		{
			super(name, "Camera3D");
			
			this._lm	= new Matrix3D;
			this._vm	= new Matrix3D;
			this._pos	= new Vector3D;
			this._rot	= new Vector3D;
			
			this._controllers		= new Vector.<Camera3DController>();
			this._controllerActive	= null;
		}
		
		public function addController(controller:Camera3DController) : void
		{
			this.removeController(controller);
			
			controller.camera = this;
			controller.initialize();
			this._controllers.push(controller);
			
			if(this._controllerActive == null)
			{ this._controllerActive = controller; }
		}
		
		public function removeController(controller:Camera3DController) : void
		{			
			var index:int = this._controllers.indexOf(controller);
			if(index >= 0 && index < this._controllers.length)
			{ 
				this._controllers.splice(index, 1); 
				
				if(controller == this._controllerActive)
				{ this._controllerActive = this._controllers.length == 0 ? null : this._controllers[0]; }
				
				controller.dispose();
			}
		}
		
		public function lookAtLH(eye:Vector3D, at:Vector3D, up:Vector3D) : void 
		{
			var x:Vector3D = new Vector3D();
			var y:Vector3D = new Vector3D();
			var z:Vector3D = new Vector3D();
			var w:Vector3D = new Vector3D();
			
			z = at.subtract(eye);
			z.normalize();
			//z.w = 0.0;
			
			x.copyFrom(up);
			crossProductTo(x, z);
			x.normalize();
			//x.w = 0.0;
			
			y.copyFrom(z);
			crossProductTo(y, x);
			//y.w = 0.0;
			
			this._lm.identity();
			var raw:Vector.<Number> = this._lm.rawData;
			raw[0] = x.x;
			raw[1] = y.x;
			raw[2] = z.x;
			raw[3] = 0.0;
			raw[4] = x.y;
			raw[5] = y.y;
			raw[6] = z.y;
			raw[7] = 0.0;
			raw[8] = x.z;
			raw[9] = y.z;
			raw[10] = z.z;
			raw[11] = 0.0;
			raw[12] = -x.dotProduct(eye);
			raw[13] = -y.dotProduct(eye);
			raw[14] = -z.dotProduct(eye);
			raw[15] = 1.0;
			
			this._lm.copyRawDataFrom(raw);
		}
		
		public function lookAtRH(eye:Vector3D, at:Vector3D, up:Vector3D):void
		{
			var x:Vector3D = new Vector3D();
			var y:Vector3D = new Vector3D();
			var z:Vector3D = new Vector3D();
			
			z=eye.subtract(at);
			z.normalize();
			//z.w = 0;
			
			x.copyFrom(up);
			crossProductTo(x, z);
			x.normalize();
			//x.w = 0;
			
			y.copyFrom(z);
			crossProductTo(y, x);
			//y.w = 0;
			
			
			this._lm.identity();
			var raw:Vector.<Number> = this._lm.rawData;
			raw[0] = x.x;
			raw[1] = y.x;
			raw[2] = z.x;
			raw[3] = 0.0;
			raw[4] = x.y;
			raw[5] = y.y;
			raw[6] = z.y;
			raw[7] = 0.0;
			raw[8] = x.z;
			raw[9] = y.z;
			raw[10] = z.z;
			raw[11] = 0.0;
			raw[12] = -x.dotProduct(eye);
			raw[13] = -y.dotProduct(eye);
			raw[14] = -z.dotProduct(eye);
			raw[15] = 1.0;
			
			this._lm.copyRawDataFrom(raw);
		}
		
		private function crossProductTo(a:Vector3D, b:Vector3D) : void
		{
			var w:Vector3D = new Vector3D();
			
			w.x = a.y * b.z - a.z * b.y;
			w.y = a.z * b.x - a.x * b.z;
			w.z = a.x * b.y - a.y * b.x;
			w.w = 1.0;
			a.copyFrom(w);
		}	
		
		public override function update(rs:RenderSystem3D) : void
		{
			this._vm.identity();
			this._vm.copyFrom(this._lm);
			
			super.update(rs);
			this._vm.append(this.localMatrix);
			
			this._vm.appendTranslation(_pos.x, _pos.y, _pos.z);
			this._vm.appendRotation(this._rot.x, Vector3D.X_AXIS);
			this._vm.appendRotation(this._rot.y, Vector3D.Y_AXIS);
			this._vm.appendRotation(this._rot.z, Vector3D.Z_AXIS);
			
			if(this._controllerActive)
			{ this._controllerActive.update(this._vm); }
			
			if(rs){ rs.vm = this._vm; }
		}
	}
}