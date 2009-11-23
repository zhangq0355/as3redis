package com.codeazur.as3redis.commands
{
	import com.codeazur.as3redis.commands.base.KeyValueCommand;
	
	public class LPUSH extends KeyValueCommand
	{
		public function LPUSH(key:String, value:*)
		{
			super(key, value);
		}
		
		override public function get name():String {
			return "LPUSH";
		}
	}
}
