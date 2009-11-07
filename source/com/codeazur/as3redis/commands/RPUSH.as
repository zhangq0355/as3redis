package com.codeazur.as3redis.commands
{
	public class RPUSH extends SET
	{
		public function RPUSH(key:String, value:*)
		{
			super(key, value);
		}
		
		override public function get name():String {
			return "RPUSH";
		}
	}
}
