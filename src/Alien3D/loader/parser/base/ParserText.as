package Alien3D.loader.parser.base
{
	//
	public class ParserText extends ParserBase
	{
		public function ParserText()
		{
			super(ParserDataFormat.PLAIN_TEXT);
		}
		
		protected override function onTextLoaded(data:String) : void
		{
			super.onTextLoaded(data);
			
			//
			this.onParse(data);
		}
		
		protected virtual function onParse(text:String) : void
		{
		}
	}
}