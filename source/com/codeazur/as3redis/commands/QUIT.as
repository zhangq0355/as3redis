package com.codeazur.as3redis.commands
{
	import com.codeazur.as3redis.commands.base.SimpleCommand;
	
	public class QUIT extends SimpleCommand
	{
		public function QUIT()
		{
		}
		
		override public function get name():String {
			return "QUIT";
		}
	}
}