package Alien3D.loader.misc
{
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequest;
	
	import Alien3D.core.ICoreEventDispatcher;

	//
	public class SingleFileLoader extends ICoreEventDispatcher
	{
		private var		_url:String;
		private var		_name:String;
		private var		_ext:String;	
		private var		_dir:String;
		public function get url() : String { return this._url; }
		public function get name() : String { return this._name; }
		public function get ext() : String { return this._ext; }	
		public function get dir() : String { return this._dir; }
		
		private var 	_readBytes:Number;
		private var 	_totalBytes:Number;
		
		public function loadingRatio() : Number { return (this._readBytes / this._totalBytes); }
		private var 	_loading:Boolean;
		public function hasLoading() : Boolean { return this._loading; }
		private var 	_completed:Boolean;
		public function hasCompleted() : Boolean { return this._completed; }
		
		private var 	_errorFlag:Boolean;
		public function hasError() : Boolean { return this._errorFlag; }
		private var		_errorMessage:String
		public function errorMessage() : String { return this._errorMessage; }
		
		protected var	_dataFormat:String;
		public function get dataFormat() : String { return this._dataFormat; }
		protected var	_data:*;
		public function get data() : * { return this._data; }
		
		public function SingleFileLoader()
		{
			super();
		}
		
		public function load(file:String, format:String = URLLoaderDataFormat.TEXT) : Boolean
		{
			file		= file.replace(/\\/g, "/");
			
			//
			var request:URLRequest 	= new URLRequest(file);
			this._url		= request.url;
			this._dir		= _url.substring(0, _url.lastIndexOf("/") + 1);
			this._name		= _url.substring(_url.lastIndexOf("/") + 1);
			this._ext		= _url.substring(_url.lastIndexOf(".") + 1);
			
			//
			this._dataFormat= format;
			return this.loadURL(request);
		}
		
		private function loadURL(request:URLRequest) : Boolean
		{
			//
			this._completed			= false;
			this._loading			= true;
			this._readBytes			= 0;
			this._totalBytes		= 0;
			this._errorFlag			= false;
			this._errorMessage		= "";
			
			//
			var loader:URLLoader 	= new URLLoader;
			loader.dataFormat		= this._dataFormat;
			loader.addEventListener(Event.COMPLETE, function (event:SecurityErrorEvent) : void
			{
				this.handleCompleted(URLLoader(event.currentTarget));
			});
			loader.addEventListener(IOErrorEvent.IO_ERROR, function (event:IOErrorEvent) : void
			{
				this.handleError(URLLoader(event.currentTarget), event.text);
			});
			loader.addEventListener(ProgressEvent.PROGRESS, function (event:ProgressEvent):void
			{
				this._readBytes		= event.bytesLoaded;
				this._totalBytes	= event.bytesTotal;
			});
			loader.addEventListener(SecurityErrorEvent.SECURITY_ERROR, function (event:SecurityErrorEvent) : void
			{
				this.handleError(URLLoader(event.currentTarget), event.text);
			});
			loader.load(request);	
			
			//
			return true;
		}
		
		private function handleError(loader:URLLoader, message:String) : void
		{
			//
			this._loading		= false;
			this._completed		= false;
			
			this._errorFlag		= true;
			this._errorMessage	= message;
			
			this._data			= null;
			
			//
			if(this.hasEventListener(IOErrorEvent.IO_ERROR))
			{ this.dispatchEvent(new IOErrorEvent(IOErrorEvent.IO_ERROR, false, false, message)); }
		}
		
		private function handleCompleted(loader:URLLoader) : void
		{
			//
			this._loading		= false;
			this._completed		= true;
			
			this._errorFlag		= false;
			this._errorMessage	= "";
			
			this._data			= loader.data;
			
			//
			if(this.hasEventListener(Event.COMPLETE))
			{ this.dispatchEvent(new Event(Event.COMPLETE)); }
		}
	}
}