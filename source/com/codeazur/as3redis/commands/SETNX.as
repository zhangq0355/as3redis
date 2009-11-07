package com.codeazur.as3redis.commands
{
	public class SETNX extends SET
	{
		public function SETNX(key:String, value:*)
		{
			super(key, value);
		}
		
		override public function get name():String {
			return "SETNX";
		}
	}
}
