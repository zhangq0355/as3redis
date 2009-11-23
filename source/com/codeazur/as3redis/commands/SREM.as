package com.codeazur.as3redis.commands
{
	import com.codeazur.as3redis.commands.base.KeyValueCommand;
	
	public class SREM extends KeyValueCommand
	{
		public function SREM(key:String, value:*)
		{
			super(key, value);
		}
		
		override public function get name():String {
			return "SREM";
		}
	}
}
