package com.codeazur.as3redis.commands
{
	import com.codeazur.as3redis.commands.base.KeyCommand;
	
	public class EXISTS extends KeyCommand
	{
		public function EXISTS(key:String)
		{
			super(key);;
		}
		
		override public function get name():String {
			return "EXISTS";
		}
	}
}
