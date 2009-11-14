package com.codeazur.as3redis.commands
{
	import com.codeazur.as3redis.RedisCommand;
	
	public class SAVE extends RedisCommand
	{
		public function SAVE()
		{
		}
		
		override public function get name():String {
			return "SAVE";
		}
	}
}