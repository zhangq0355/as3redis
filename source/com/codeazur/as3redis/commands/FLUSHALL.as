package com.codeazur.as3redis.commands
{
	import com.codeazur.as3redis.RedisCommand;
	
	public class FLUSHALL extends RedisCommand
	{
		public function FLUSHALL()
		{
		}
		
		override public function get name():String {
			return "FLUSHALL";
		}
	}
}
