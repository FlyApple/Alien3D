package Alien3D.loader.misc
{
	//
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.net.URLLoaderDataFormat;
	
	import Alien3D.core.ICoreEventDispatcher;
	import Alien3D.core.debug.DebugPrint;
	import Alien3D.loader.ExtendParserTypes;
	import Alien3D.loader.ResourceGroup;
	import Alien3D.loader.ns_loader;
	import Alien3D.loader.parser.base.ParserBase;
	import Alien3D.loader.parser.base.ParserDataFormat;
	import Alien3D.loader.parser.base.ParserEvent;

	//
	public class ResourceLoader extends ICoreEventDispatcher
	{
		private var _group:ResourceGroup;
		private var _queueList:Vector.<ResourceQueueData>; //仅仅队列中是主资源
		
		private var _loading:Boolean;
		private var _loadingList:Vector.<ResourceQueueData>; //加载队列中包括主资源和附属资源
		
		//
		public function ResourceLoader(group:ResourceGroup)
		{
			super();
			
			//
			this._group			= group;
			this._queueList		= new Vector.<ResourceQueueData>();
			this._loadingList	= new Vector.<ResourceQueueData>();
		}
		
		public function load(url:String, complateListener:Function = null) : Boolean
		{
			var queue:ResourceQueueData = new ResourceQueueData;
			queue.url		= url;
			queue.listener	= complateListener;
			
			this._queueList.push(queue);
			return next();
		}
		
		private function next() : Boolean
		{
			if(this._queueList.length == 0){ return false; }
			if(this._loading == true){ return false; }
			
			this.callback();
			return true;
		}
		
		private function pop(queue:ResourceQueueData) : Boolean
		{
			if(!queue){ return false; }
			
			var index:int = this._queueList.indexOf(queue);
			if(index >= 0){ this._queueList.splice(index, 1); }
			
			return next();
		}
		
		private function callback() : void
		{
			this._loading	= true;
			
			//
			var queue:ResourceQueueData = this._queueList[0];
			if(queue != null)
			{
				this._loadingList.push(queue);
				if(!this.onLoad(queue.url, queue._parent))
				{
					//
					var index:int = this._loadingList.indexOf(queue);
					if(index >= 0){ this._loadingList.splice(index, 1); }
					
					this.pop(queue);
					
					//
					DebugPrint.output_load("[ResourceLoader] <callback> load error:" + queue.url);
					return ;
				}
			}
		}
		
		private function onLoad(file:String, parent:ResourceDependency = null) : Boolean
		{
			//
			var loader:SingleFileLoader = new SingleFileLoader(file);
			var parser:ParserBase 		= this.createParserFromSuffix(loader.ext);
			if(!parser)
			{
				DebugPrint.output_load("[ResourceLoader] not find parser:" + loader.url);
				return false; 
			}
			
			//
			var format:String			= null;
			switch(parser.dataFormat)
			{
				case ParserDataFormat.PLAIN_TEXT:{ format = URLLoaderDataFormat.TEXT; break; }
				case ParserDataFormat.BINARY:{ format = URLLoaderDataFormat.BINARY; break; }
				default: { format = URLLoaderDataFormat.TEXT; break; }
			}
			
			//
			var data:ResourceDependency	= new ResourceDependency(parent);
			data._url					= loader.url;
			data._parser				= parser;
			data.ns_loader::name		= loader.name;
			if(!data.initialize())
			{
				return false;
			}
			
			//
			loader.addEventListener(Event.COMPLETE, handleLoaderComplete);
			loader.addEventListener(IOErrorEvent.IO_ERROR, handleLoaderError);
			
			//
			if(!loader.load(format, data))
			{ 
				DebugPrint.output_load("[ResourceLoader] loader fail:" + loader.url);
				return false; 
			}
			
			//
			return true;
		}
		
		private function createParserFromSuffix(suffix:String) : ParserBase
		{
			var parsers:Vector.<Class> = ExtendParserTypes.PointerI.ParserTypes();
			var len:int = parsers.length;
			for (var i:int = len - 1; i >= 0; i--)
			{
				if (parsers[i].hasSupport(suffix))
				{ return new parsers[i](); }
			}		
			return null;
		}
		
		private function handleLoaderError(event:IOErrorEvent) : void
		{
			// TODO Auto-generated method stub
			var loader:SingleFileLoader = event.currentTarget as SingleFileLoader;
			loader.removeEventListener(IOErrorEvent.IO_ERROR, handleLoaderError);
			loader.removeEventListener(Event.COMPLETE, handleLoaderComplete);
			
			//
			var data:ResourceData = loader.param as ResourceData;
			data._error		= true;
			data._length	= 0;
			
			this.onLoaderError(data, null, loader.hasError() ? loader.errorMessage() : "<Unknow> loading error.");
		}
		
		private function handleLoaderComplete(event:Event) : void
		{
			// TODO Auto-generated method stub
			var loader:SingleFileLoader = event.currentTarget as SingleFileLoader;
			loader.removeEventListener(IOErrorEvent.IO_ERROR, handleLoaderError);
			loader.removeEventListener(Event.COMPLETE, handleLoaderComplete);
			
			//
			var data:ResourceData = loader.param as ResourceData;
			if(loader.hasCompleted())
			{ 
				data._error		= false;
				data._length	= loader.length;
				
				this.onLoaderComplete(data, loader.data); 
			}
			else
			{ 
				data._error		= true;
				data._length	= 0;
				
				this.onLoaderError(data, null, loader.hasError() ? loader.errorMessage() : "<Unknow> loading error."); 
			}
		}
		
		protected function onLoaderError(data:ResourceData, bytes:*, error:String) : void
		{
			//
			this.initParser(data, bytes);
		}
		
		protected function onLoaderComplete(data:ResourceData, bytes:*) : void
		{
			//
			this.initParser(data, bytes);
		}
		
		private function initParser(data:ResourceData, bytes:*) : Boolean
		{
			var parser:ParserBase = data._parser;
			parser.addEventListener(ParserEvent.PARSER_INIT, onParserInit);
			parser.addEventListener(ParserEvent.PARSER_FREE, onParserFree);
			
			if(parser.hasEventListener(ParserEvent.PARSER_INIT))
			{ parser.dispatchEvent(new ParserEvent(ParserEvent.PARSER_INIT, data, bytes)); }
			
			return true;
		}
		
		protected function onParserInit(event:ParserEvent) : void
		{
			//
			var parser:ParserBase = event.currentTarget as ParserBase;
			parser.removeEventListener(ParserEvent.PARSER_INIT, onParserInit);
			
			//nothing
		}
		
		protected function onParserFree(event:ParserEvent) : void
		{
			//
			var parser:ParserBase = event.currentTarget as ParserBase;
			parser.removeEventListener(ParserEvent.PARSER_INIT, onParserInit);
			parser.removeEventListener(ParserEvent.PARSER_FREE, onParserFree);
			
			//free
			parser.resource._parser = null;
			parser.dispose();
			parser = null;
		}
	}
}