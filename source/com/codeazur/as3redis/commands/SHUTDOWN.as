package com.codeazur.as3redis.commands
{
	import com.codeazur.as3redis.commands.base.SimpleCommand;
	
	public class SHUTDOWN extends SimpleCommand
	{
		public function SHUTDOWN()
		{
		}
		
		override public function get name():String {
			return "SHUTDOWN";
		}
	}
}