package com.codeazur.as3redis.commands
{
	import com.codeazur.as3redis.commands.base.KeyCommand;
	
	public class SPOP extends KeyCommand
	{
		public function SPOP(key:String)
		{
			super(key);
		}
		
		override public function get name():String {
			return "SPOP";
		}
	}
}
