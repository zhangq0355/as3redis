package com.codeazur.as3redis.commands
{
	import com.codeazur.as3redis.RedisCommand;
	
	public class SHUTDOWN extends RedisCommand
	{
		public function SHUTDOWN()
		{
		}
		
		override public function get name():String {
			return "SHUTDOWN";
		}
	}
}