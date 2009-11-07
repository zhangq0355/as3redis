package com.codeazur.as3redis.commands
{
	import flash.utils.ByteArray;

	import com.codeazur.as3redis.RedisCommand;
	
	public class EXPIRE extends RedisCommand
	{
		protected var _key:String;
		protected var _seconds:uint;
		
		public function EXPIRE(key:String, seconds:uint)
		{
			_key = key;
			_seconds = seconds;
		}
		
		override public function get name():String {
			return "EXPIRE";
		}
		
		override protected function createRequest():ByteArray {
			var ba:ByteArray = new ByteArray();
			ba.writeUTFBytes(name + " " + _key + " " + _seconds + "\r\n");
			return ba;
		}

		override public function toStringCommand():String {
			return "[" + name + " " + _key + " " + _seconds + "]";
		}
	}
}
