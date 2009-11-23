package com.codeazur.as3redis.commands
{
	import com.codeazur.as3redis.commands.base.SimpleCommand;
	
	public class SAVE extends SimpleCommand
	{
		public function SAVE()
		{
		}
		
		override public function get name():String {
			return "SAVE";
		}
	}
}