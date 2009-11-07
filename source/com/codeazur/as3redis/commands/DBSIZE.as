package com.codeazur.as3redis.commands
{
	import com.codeazur.as3redis.RedisCommand;
	
	public class DBSIZE extends RedisCommand
	{
		public function DBSIZE()
		{
		}
		
		override public function get name():String {
			return "DBSIZE";
		}
	}
}
