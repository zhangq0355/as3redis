package com.codeazur.as3redis.commands
{
	import com.codeazur.as3redis.commands.base.SimpleCommand;
	
	public class RANDOMKEY extends SimpleCommand
	{
		public function RANDOMKEY()
		{
		}
		
		override public function get name():String {
			return "RANDOMKEY";
		}
	}
}
