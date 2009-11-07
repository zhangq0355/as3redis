package com.codeazur.as3redis.commands
{
	public class RENAMENX extends RENAME
	{
		public function RENAMENX(oldKey:String, newKey:String)
		{
			super(oldKey, newKey);
		}
		
		override public function get name():String {
			return "RENAMENX";
		}
	}
}
