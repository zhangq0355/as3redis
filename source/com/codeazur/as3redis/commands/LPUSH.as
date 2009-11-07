package com.codeazur.as3redis.commands
{
	public class LPUSH extends SET
	{
		public function LPUSH(key:String, value:*)
		{
			super(key, value);
		}
		
		override public function get name():String {
			return "LPUSH";
		}
	}
}
