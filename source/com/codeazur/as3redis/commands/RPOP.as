package com.codeazur.as3redis.commands
{
	public class RPOP extends LPOP
	{
		public function RPOP(key:String)
		{
			super(key);
		}
		
		override public function get name():String {
			return "RPOP";
		}
	}
}
