package Alien3D.world
{
	import flash.geom.Matrix3D;
	
	import Alien3D.render.RenderSystem3D;

	//
	public class World3D extends WorldNode3D
	{
		public function get wm () : Matrix3D { return this.localMatrix }
		//public function set wm (value:Matrix3D) : void { this.localMatrix = value; }
		
		public function World3D(name:String = null)
		{
			super(name, "World3D");
		}
		
		public override function initialize() : Boolean
		{			
			if(!super.initialize())
			{ return false; }
			
			//
			return true;
		}
		
		public override function update(rs:RenderSystem3D) : void
		{
			super.update(rs);
			
			if(rs){ rs.wm = this.wm; }
		}
	}
}