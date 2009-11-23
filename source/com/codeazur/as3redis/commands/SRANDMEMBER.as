package com.codeazur.as3redis.commands
{
	import com.codeazur.as3redis.commands.base.KeyCommand;
	
	public class SRANDMEMBER extends KeyCommand
	{
		public function SRANDMEMBER(key:String)
		{
			super(key);
		}
		
		override public function get name():String {
			return "SRANDMEMBER";
		}
	}
}
