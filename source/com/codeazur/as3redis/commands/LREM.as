package com.codeazur.as3redis.commands
{
	import flash.utils.ByteArray;

	import com.codeazur.as3redis.RedisCommand;
	
	public class LREM extends RedisCommand
	{
		protected var _key:String;
		protected var _count:int;
		protected var _value:*;
		
		public function LREM(key:String, count:int, value:*)
		{
			_key = key;
			_count = count;
			_value = value;
		}
		
		override public function get name():String {
			return "LREM";
		}
		
		override protected function createRequest():ByteArray {
			var ba:ByteArray = new ByteArray();
			var baValue:ByteArray = serializeValue(_value);
			ba.writeUTFBytes(name + " " + _key  + " " + _count + " " + baValue.length + "\r\n");
			ba.writeBytes(baValue);
			ba.writeUTFBytes("\r\n");
			return ba;
		}

		override public function toStringCommand():String {
			return "[" + name + " " + _key + " " + _count + " " + toStringValue(_value) + "]";
		}
	}
}
