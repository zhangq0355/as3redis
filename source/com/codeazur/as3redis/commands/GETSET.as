package com.codeazur.as3redis.commands
{
	import com.codeazur.as3redis.commands.base.KeyValueCommand;
	
	public class GETSET extends KeyValueCommand
	{
		public function GETSET(key:String, value:*)
		{
			super(key, value);
		}
		
		override public function get name():String {
			return "GETSET";
		}
	}
}
