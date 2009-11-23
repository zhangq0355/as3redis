package com.codeazur.as3redis.commands
{
	import com.codeazur.as3redis.commands.base.KeyValueCommand;
	
	public class SISMEMBER extends KeyValueCommand
	{
		public function SISMEMBER(key:String, value:*)
		{
			super(key, value);
		}
		
		override public function get name():String {
			return "SISMEMBER";
		}
	}
}
