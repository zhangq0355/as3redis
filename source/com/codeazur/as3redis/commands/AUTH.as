package com.codeazur.as3redis.commands
{
	import flash.utils.ByteArray;

	import com.codeazur.as3redis.RedisCommand;
	
	public class AUTH extends RedisCommand
	{
		protected var _password:String;
		
		public function AUTH(password:String)
		{
			_password = password;
		}
		
		override public function get name():String {
			return "AUTH";
		}
		
		override protected function createRequest():ByteArray {
			var ba:ByteArray = new ByteArray();
			ba.writeUTFBytes(name + " " + _password + "\r\n");
			return ba;
		}

		override public function toStringCommand():String {
			return "[" + name + " *****]";
		}
	}
}
