package com.codeazur.as3redis.commands
{
	import flash.utils.ByteArray;

	import com.codeazur.as3redis.RedisCommand;
	
	public class SCARD extends RedisCommand
	{
		protected var _key:String;
		
		public function SCARD(key:String)
		{
			_key = key;
		}
		
		override public function get name():String {
			return "SCARD";
		}
		
		override protected function createRequest():ByteArray {
			var ba:ByteArray = new ByteArray();
			ba.writeUTFBytes(name + " " + _key + "\r\n");
			return ba;
		}

		override public function toStringCommand():String {
			return "[" + name + " " + _key + "]";
		}
	}
}
