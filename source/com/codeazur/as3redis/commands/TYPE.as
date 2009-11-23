package com.codeazur.as3redis.commands
{
	import com.codeazur.as3redis.commands.base.KeyCommand;
	
	public class TYPE extends KeyCommand
	{
		public function TYPE(key:String)
		{
			super(key);
		}
		
		override public function get name():String {
			return "TYPE";
		}
	}
}
