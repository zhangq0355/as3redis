package com.codeazur.as3redis.commands
{
	import flash.utils.ByteArray;

	import com.codeazur.as3redis.RedisCommand;
	
	public class LRANGE extends RedisCommand
	{
		protected var _key:String;
		protected var _startIndex:int;
		protected var _endIndex:int;
		
		public function LRANGE(key:String, startIndex:int, endIndex:int)
		{
			_key = key;
			_startIndex = startIndex;
			_endIndex = endIndex;
		}
		
		override public function get name():String {
			return "LRANGE";
		}
		
		override protected function createRequest():ByteArray {
			var ba:ByteArray = new ByteArray();
			ba.writeUTFBytes(name + " " + _key + " " + _startIndex + " " + _endIndex + "\r\n");
			return ba;
		}

		override public function toStringCommand():String {
			return "[" + name + " " + _key + " " + _startIndex + " " + _endIndex + "]";
		}
	}
}
