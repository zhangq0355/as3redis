package com.codeazur.as3redis.commands
{
	import com.codeazur.as3redis.commands.base.KeyCommand;
	
	public class SCARD extends KeyCommand
	{
		public function SCARD(key:String)
		{
			super(key);
		}
		
		override public function get name():String {
			return "SCARD";
		}
	}
}
