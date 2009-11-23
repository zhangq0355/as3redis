package com.codeazur.as3redis.commands
{
	import com.codeazur.as3redis.commands.base.SimpleCommand;
	
	public class DBSIZE extends SimpleCommand
	{
		public function DBSIZE()
		{
		}
		
		override public function get name():String {
			return "DBSIZE";
		}
	}
}
