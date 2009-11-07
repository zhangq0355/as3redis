package com.codeazur.as3redis.commands
{
	import com.codeazur.as3redis.RedisCommand;
	
	public class RANDOMKEY extends RedisCommand
	{
		public function RANDOMKEY()
		{
		}
		
		override public function get name():String {
			return "RANDOMKEY";
		}
	}
}
