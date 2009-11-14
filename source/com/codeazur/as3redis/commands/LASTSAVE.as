package com.codeazur.as3redis.commands
{
	import com.codeazur.as3redis.RedisCommand;
	
	public class LASTSAVE extends RedisCommand
	{
		public function LASTSAVE()
		{
		}
		
		override public function get name():String {
			return "LASTSAVE";
		}
	}
}