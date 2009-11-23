package com.codeazur.as3redis.commands
{
	import com.codeazur.as3redis.commands.base.KeyCommand;
	
	public class LPOP extends KeyCommand
	{
		public function LPOP(key:String)
		{
			super(key);
		}
		
		override public function get name():String {
			return "LPOP";
		}
	}
}
