package com.codeazur.as3redis.commands
{
	import com.codeazur.as3redis.RedisCommand;
	
	public class QUIT extends RedisCommand
	{
		public function QUIT()
		{
		}
		
		override public function get name():String {
			return "QUIT";
		}
	}
}