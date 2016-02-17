package Alien3D.camera
{
	import flash.geom.Matrix3D;
	import flash.geom.Vector3D;
	
	import Alien3D.core.ICoreClass;

	//
	public class Camera3DController extends ICoreClass
	{
		private var _camera:Camera3D;
		private var _move:Vector3D;
		private var _pitch:Number;
		private var _yaw:Number;
		private var _roll:Number;
		public function get pitch() : Number { return this._pitch; }
		public function get yaw() : Number { return this._yaw; }
		public function get roll() : Number { return this._roll; }
		public function set pitch(v:Number) : void { this._pitch = v; }
		public function set yaw(v:Number) : void { this._yaw = v; }
		public function set roll(v:Number) : void { this._roll = v; }
		
		public function get move() : Vector3D { return this._move; }
		
		internal function set camera(v:Camera3D) : void 
		{ 
			this._camera 	= v; 
		}
		
		//
		public function Camera3DController()
		{
			this._move		= new Vector3D;
			this._pitch		= 0;
			this._yaw		= 0;
			this._roll		= 0;
		}
		
		internal function update(vm:Matrix3D) : void
		{
			vm.appendTranslation(this.move.x, this.move.y, this.move.z);
			
			vm.appendRotation(this._pitch, Vector3D.X_AXIS);
			vm.appendRotation(this._yaw, Vector3D.Y_AXIS);
			vm.appendRotation(this._roll, Vector3D.Z_AXIS);
		}
	}
}