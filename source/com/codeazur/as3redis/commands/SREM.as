package com.codeazur.as3redis.commands
{
	import flash.utils.ByteArray;

	import com.codeazur.as3redis.RedisCommand;
	
	public class SREM extends RedisCommand
	{
		protected var _key:String;
		protected var _value:*;
		
		public function SREM(key:String, value:*)
		{
			_key = key;
			_value = value;
		}
		
		override public function get name():String {
			return "SREM";
		}
		
		override protected function createRequest():ByteArray {
			var ba:ByteArray = new ByteArray();
			var baValue:ByteArray = serializeValue(_value);
			ba.writeUTFBytes(name + " " + _key + " " + baValue.length + "\r\n");
			ba.writeBytes(baValue);
			ba.writeUTFBytes("\r\n");
			return ba;
		}

		override public function toStringCommand():String {
			return "[" + name + " " + _key + " " + _value + "]";
		}
	}
}
