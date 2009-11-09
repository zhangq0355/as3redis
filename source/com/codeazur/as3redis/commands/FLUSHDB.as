package com.codeazur.as3redis.commands
{
	import com.codeazur.as3redis.RedisCommand;
	
	public class FLUSHDB extends RedisCommand
	{
		public function FLUSHDB()
		{
		}
		
		override public function get name():String {
			return "FLUSHDB";
		}
	}
}
