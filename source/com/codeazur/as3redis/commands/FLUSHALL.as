package com.codeazur.as3redis.commands
{
	import com.codeazur.as3redis.commands.base.SimpleCommand;
	
	public class FLUSHALL extends SimpleCommand
	{
		public function FLUSHALL()
		{
		}
		
		override public function get name():String {
			return "FLUSHALL";
		}
	}
}
