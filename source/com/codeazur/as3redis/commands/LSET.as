package com.codeazur.as3redis.commands
{
	import flash.utils.ByteArray;

	import com.codeazur.as3redis.RedisCommand;
	
	public class LSET extends RedisCommand
	{
		protected var _key:String;
		protected var _index:int;
		protected var _value:*;
		
		public function LSET(key:String, index:int, value:*)
		{
			_key = key;
			_index = index;
			_value = value;
		}
		
		override public function get name():String {
			return "LSET";
		}
		
		override protected function createRequest():ByteArray {
			var ba:ByteArray = new ByteArray();
			var baValue:ByteArray = serializeValue(_value);
			ba.writeUTFBytes(name + " " + _key  + " " + _index + " " + baValue.length + "\r\n");
			ba.writeBytes(baValue);
			ba.writeUTFBytes("\r\n");
			return ba;
		}

		override public function toStringCommand():String {
			return "[" + name + " " + _key + " " + _index + " " + toStringValue(_value) + "]";
		}
	}
}
