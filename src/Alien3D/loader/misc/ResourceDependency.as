package Alien3D.loader.misc
{
	import Alien3D.loader.ns_loader;
	
	//
	public class ResourceDependency extends ResourceData
	{
		private var _parent:ResourceData;
		private var _dependencyList:Vector.<ResourceDependency>;
		
		ns_loader override function set name(value:String) : void 
		{ this._name = (!_parent ? "" : _parent.name + "/") + value; }
		
		public function ResourceDependency(parent:ResourceData = null)
		{
			super();
			
			//
			this._parent		= parent;
		}
	}
}