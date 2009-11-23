package com.codeazur.as3redis.commands
{
	import com.codeazur.as3redis.commands.base.SimpleCommand;
	
	public class LASTSAVE extends SimpleCommand
	{
		public function LASTSAVE()
		{
		}
		
		override public function get name():String {
			return "LASTSAVE";
		}
	}
}