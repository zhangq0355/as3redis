package com.codeazur.as3redis.commands
{
	import com.codeazur.as3redis.commands.base.KeyCommand;
	
	public class ZCARD extends KeyCommand
	{
		public function ZCARD(key:String)
		{
			super(key);
		}
		
		override public function get name():String {
			return "ZCARD";
		}
	}
}