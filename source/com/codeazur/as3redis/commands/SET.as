package com.codeazur.as3redis.commands
{
	import com.codeazur.as3redis.commands.base.KeyValueCommand;
	
	public class SET extends KeyValueCommand
	{
		public function SET(key:String, value:*)
		{
			super(key, value);
		}
		
		override public function get name():String {
			return "SET";
		}
	}
}
