package com.codeazur.as3redis.commands
{
	import com.codeazur.as3redis.commands.base.KeyValueCommand;
	
	public class SADD extends KeyValueCommand
	{
		public function SADD(key:String, value:*)
		{
			super(key, value);
		}
		
		override public function get name():String {
			return "SADD";
		}
	}
}
