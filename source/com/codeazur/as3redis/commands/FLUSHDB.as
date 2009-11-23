package com.codeazur.as3redis.commands
{
	import com.codeazur.as3redis.commands.base.SimpleCommand;
	
	public class FLUSHDB extends SimpleCommand
	{
		public function FLUSHDB()
		{
		}
		
		override public function get name():String {
			return "FLUSHDB";
		}
	}
}
