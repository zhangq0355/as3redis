package com.codeazur.as3redis.commands
{
	import com.codeazur.as3redis.commands.base.SimpleCommand;
	
	public class BGSAVE extends SimpleCommand
	{
		public function BGSAVE()
		{
		}
		
		override public function get name():String {
			return "BGSAVE";
		}
	}
}