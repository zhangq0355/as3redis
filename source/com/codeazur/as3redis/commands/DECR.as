package com.codeazur.as3redis.commands
{
	import com.codeazur.as3redis.commands.base.KeyCommand;
	
	public class DECR extends KeyCommand
	{
		public function DECR(key:String)
		{
			super(key);
		}
		
		override public function get name():String {
			return "DECR";
		}
	}
}
