package Alien3D.loader
{
	import Alien3D.core.ICoreInstance;
	import Alien3D.core.SingletonT;

	//
	public class ResourceManager extends ICoreInstance
	{
		private static var ms_Singleton:SingletonT;
		public  static function get Singleton() : SingletonT { return ms_Singleton; }
		public  static function get PointerI() : ResourceManager { return Singleton.T as ResourceManager; }
		
		//
		private var _groupIndex:Number;
		private var _groupRoot:ResourceGroup;
		private var _groupList:Vector.<ResourceGroup>;
		
		public function get groupRoot() : ResourceGroup { return this._groupRoot; }
		
		//
		public function ResourceManager()
		{
			super(ms_Singleton = new SingletonT(this));
			
			//
			this._groupIndex	= 0;
			this._groupRoot		= null;
			this._groupList		= new Vector.<ResourceGroup>();
		}
		
		public override function release() : void
		{
			super.release();
		}
		
		public override function initialize() : Boolean
		{			
			if(!super.initialize())
			{ return false; }
			
			//
			this._groupRoot = this.createGroup(ResourceGroup.NAME_ROOT);
			if(this._groupRoot == null)
			{
				return false;
			}
			return true;
		}
		
		public function createGroup(name:String) : ResourceGroup
		{
			var group:ResourceGroup = this.getGroup(name);
			if(group){ return group; }
			else
			{ 
				var index:Number = name == ResourceGroup.NAME_ROOT ? 0 : ++this._groupIndex;
				group = new ResourceGroup(index, name); 
			}
			
			if(!this.initializeGroup(group))
			{
				this.releaseGroup(group);
				return null;
			}
			
			this._groupList.push(group);
			return group;
		}
		
		public function deleteGroup(group:ResourceGroup) : void
		{
			if(!group){ return; }
			
			// 如果是root分组，仅仅释放，但并不删除
			// 如果其它分组，将删除
			if(group == this._groupRoot)
			{
				this._groupRoot.release();
				return;
			}
			
			var index:Number = this._groupList.indexOf(group);
			if(index >= 0){ this._groupList.splice(index, 1); }
			
			this.releaseGroup(group);
		}
		
		public function deleteGroupByName(name:String) : void
		{
			this.deleteGroup(this.getGroup(name));
		}
		
		public function getGroup(name:String) : ResourceGroup
		{
			for each(var group:ResourceGroup in this._groupList)
			{
				if(group.name == name.toLowerCase())
				{ return group; }
			}
			return null;
		}
		
		private function releaseGroup(group:ResourceGroup) : void
		{
			if(group)
			{
				group.dispose();
				group = null;
			}
		}
		
		private function initializeGroup(group:ResourceGroup) : Boolean
		{
			if(!group){ return false; }
			return group.initialize();
		}
		
		public function loadByGroupName(url:String, complateListener:Function = null, groupName:String="root") : Boolean
		{
			return this.load(url, complateListener, this.getGroup(groupName));
		}
		
		public function load(url:String, complateListener:Function = null, group:ResourceGroup=null) : Boolean
		{
			if(group == null){ group = this._groupRoot; }
			
			return group.load(url, complateListener);
		}
	}
}