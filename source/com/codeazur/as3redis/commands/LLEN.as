package com.codeazur.as3redis.commands
{
	import com.codeazur.as3redis.commands.base.KeyCommand;
	
	public class LLEN extends KeyCommand
	{
		public function LLEN(key:String)
		{
			super(key);
		}
		
		override public function get name():String {
			return "LLEN";
		}
	}
}
