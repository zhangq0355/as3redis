package com.codeazur.as3redis.commands
{
	import com.codeazur.as3redis.commands.base.SimpleCommand;
	
	public class MONITOR extends SimpleCommand
	{
		public function MONITOR()
		{
		}
		
		override public function get name():String {
			return "MONITOR";
		}
	}
}