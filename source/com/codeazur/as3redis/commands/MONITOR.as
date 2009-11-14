package com.codeazur.as3redis.commands
{
	import com.codeazur.as3redis.RedisCommand;
	
	public class MONITOR extends RedisCommand
	{
		public function MONITOR()
		{
			super();
		}
		
		override public function get name():String {
			return "MONITOR";
		}
	}
}