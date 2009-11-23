package com.codeazur.as3redis.commands
{
	import com.codeazur.as3redis.commands.base.KeyCommand;
	
	public class SMEMBERS extends KeyCommand
	{
		public function SMEMBERS(key:String)
		{
			super(key);
		}
		
		override public function get name():String {
			return "SMEMBERS";
		}
	}
}
