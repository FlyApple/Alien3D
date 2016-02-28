package Alien3D.loader.parser.base
{	
	import flash.utils.ByteArray;
	import flash.utils.Endian;
	
	import Alien3D.core.ICoreEventDispatcher;
	import Alien3D.core.debug.DebugAssert;
	import Alien3D.loader.misc.ResourceData;

	//
	public class ParserBase extends ICoreEventDispatcher
	{
		private var 	_resource:ResourceData;
		public function get resource() : ResourceData { return this._resource; }	
		
		protected var	_dataFormat:String;
		public function get dataFormat() : String { return this._dataFormat; }
		protected var	_data:*;
		public function get data() : * { return this._data; }
		
		public function ParserBase(format:String = ParserDataFormat.PLAIN_TEXT)
		{
			super();
			
			//
			this._resource		= null;
			this._dataFormat	= format;
			this._data			= null;
			
			//
			this.addEventListener(ParserEvent.PARSER_INIT, onInit);
		}
		
		public static function hasSupport(name:String) : Boolean
		{
			return false;
		}
		
		protected function onInit(event:ParserEvent):void
		{
			// TODO Auto-generated method stub
			this.removeEventListener(ParserEvent.PARSER_INIT, onInit);
			
			//
			this._resource	= event.resource;
			this._data		= event.data;
			
			//
			if(event.data)
			{
				if(this.initialize())
				{
					this.dispatchEvent(new ParserEvent(ParserEvent.DATA_LOADED, null));
				}
			}
			this.dispatchEvent(new ParserEvent(ParserEvent.PARSER_FREE, this._resource, null));
		}		
		
		public override function initialize() : Boolean
		{			
			this.addEventListener(ParserEvent.DATA_LOADED, function (event:ParserEvent) : void{
				//
				onLoaded(_data);
			});
			return true;
		}
		
		protected function finalize() : Boolean
		{
			this.dispatchEvent(new ParserEvent(ParserEvent.DATA_PARSED, this._resource));
			return true;
		}
		
		protected virtual function onLoaded(data:*) : void
		{
			switch(this.dataFormat)
			{
				case ParserDataFormat.PLAIN_TEXT:
				{
					this.onTextLoaded(data);
					break;
				}
				case ParserDataFormat.BINARY:
				{
					this.onBinaryLoaded(data);
					break;
				}
				default:
				{
					new DebugAssert("[ParserBase] data format invalid.");
					break;
				}
			}
		}
		
		protected virtual function onTextLoaded(data:String) : void
		{
			
		}
		
		protected virtual function onBinaryLoaded(data:ByteArray) : void
		{
			data.endian = Endian.LITTLE_ENDIAN;
		}
	}
}