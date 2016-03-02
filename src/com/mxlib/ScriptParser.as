package com.mxlib
{
	public class ScriptParser
	{
		public static function parse(text:String, content:ScriptContent = null) : Boolean
		{
			if(content != null && !content.load(text))
			{ return false; }
			
			return true;
		}
	}
}