package Alien3D.loader.parser.base
{
	import flash.utils.ByteArray;

	public class ParserBinary extends ParserBase
	{
		public function ParserBinary()
		{
			super(ParserDataFormat.BINARY);
		}
		
		protected override function onBinaryLoaded(data:ByteArray) : void
		{
			super.onBinaryLoaded(data);
			
			//
			this.onParse(data);
		}
		
		protected virtual function onParse(bytes:ByteArray) : void
		{
		}
	}
}