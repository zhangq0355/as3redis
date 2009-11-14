package com.codeazur.as3redis.commands
{
	import com.codeazur.as3redis.RedisCommand;
	
	public class BGSAVE extends RedisCommand
	{
		public function BGSAVE()
		{
		}
		
		override public function get name():String {
			return "BGSAVE";
		}
	}
}