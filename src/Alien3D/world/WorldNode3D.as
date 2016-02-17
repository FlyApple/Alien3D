package Alien3D.world
{
	import flash.geom.Matrix3D;
	
	import Alien3D.core.ICoreEventDispatcher;
	import Alien3D.render.RenderSystem3D;

	//
	public class WorldNode3D extends ICoreEventDispatcher
	{
		private static var _indexTotal:int = 0;
		
		private var _index:int;
		//public function set index(v:int) : void { this._index = v; }
		public function get index() : int { return this._index; }
		
		private var _name:String;
		//public function set name(v:String) : void { this._name = v; }		
		public function get name() : String { return this._name; }
		
		private var _localMatrix:Matrix3D = new Matrix3D;
		protected function get localMatrix () : Matrix3D { return this._localMatrix; }
		protected function set localMatrix (value:Matrix3D) : void { this._localMatrix = value; }
		
		private var _parent:WorldNode3D;
		private var _children:Vector.<WorldNode3D>;
		
		public function WorldNode3D(name:String = null, prefix:String = null)
		{
			super();
			
			this._index				= ++_indexTotal;
			this._name				= name ? (prefix ? prefix + "_" : "") + name : "WorldNode3D_" + (prefix ? prefix + "_" : "") + this._index;
			
			this._parent			= null;
			this._children			= new Vector.<WorldNode3D>();
		}
		
		public override function dispose() : void 
		{
			this.removeChildAll();
			
			this._name			= "";
			this._index			= -1;
			
			this._parent 		= null;
		}
		
		public override function initialize() : Boolean
		{			
			if(!super.initialize())
			{ return false; }
			
			//
			return true;
		}
		
		public function addChild(child:WorldNode3D) : void
		{
			if(child._parent)
			{
				child._parent.removeChild(child);
			}
			
			child._parent	= this;
			this._children.push(child);
		}
		
		public function removeChild(child:WorldNode3D) : void
		{
			var index:int = this._children.indexOf(child);
			if(index >= 0 && index < this._children.length)
			{ 
				this._children.splice(index, 1); 
				child.dispose();
			}
		}
		
		private function removeChildAll() : void
		{
			for each(var child:WorldNode3D in this._children)
			{
				if(child){ this.removeChild(child); }
			}
			this._children.length = 0;
		}
		
		public function getChildByIndex(index:int) : WorldNode3D
		{
			for each(var child:WorldNode3D in this._children)
			{
				if(child && child._index == index)
				{
					return child;
				}
			}
			return null;
		}
		
		public function getChildByName(name:String) : WorldNode3D
		{
			for each(var child:WorldNode3D in this._children)
			{
				if(child && child._name == name)
				{
					return child;
				}
			}
			return null;
		}
		
		public virtual function update(rs:RenderSystem3D) : void
		{
			this.updateChild(rs);
		}
		
		public virtual function render(rs:RenderSystem3D) : void
		{
			this.renderChild(rs);
		}
		
		private function updateChild(rs:RenderSystem3D) : void
		{
			for each(var child:WorldNode3D in this._children)
			{ if(child){ child.update(rs); } }
		}
		
		private function renderChild(rs:RenderSystem3D) : void
		{
			for each(var child:WorldNode3D in this._children)
			{ if(child){ child.render(rs); } }
		}
	}
}