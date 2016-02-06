package Alien3D.loader.misc
{

	public class ResourceDependency extends ResourceData
	{
		private var _parent:ResourceData;
		private var _dependencyList:Vector.<ResourceDependency>;
		
		public function ResourceDependency(parent:ResourceData = null)
		{
			super();
			
			//
			this._parent		= parent;
		}
	}
}