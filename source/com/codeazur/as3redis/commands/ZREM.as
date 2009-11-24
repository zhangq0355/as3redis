package com.codeazur.as3redis.commands
{
	import com.codeazur.as3redis.commands.base.KeyValueCommand;
	
	public class ZREM extends KeyValueCommand
	{
		public function ZREM(key:String, value:*)
		{
			super(key, value);
		}
		
		override public function get name():String {
			return "ZREM";
		}
	}
}