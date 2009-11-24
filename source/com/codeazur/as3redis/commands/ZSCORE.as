package com.codeazur.as3redis.commands
{
	import com.codeazur.as3redis.commands.base.KeyValueCommand;
	
	public class ZSCORE extends KeyValueCommand
	{
		public function ZSCORE(key:String, value:*)
		{
			super(key, value);
		}
		
		override public function get name():String {
			return "ZSCORE";
		}
	}
}