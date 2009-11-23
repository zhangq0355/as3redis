package com.codeazur.as3redis.commands
{
	import com.codeazur.as3redis.commands.base.SimpleCommand;
	
	public class PING extends SimpleCommand
	{
		public function PING()
		{
		}
		
		override public function get name():String {
			return "PING";
		}
	}
}
