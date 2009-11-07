package com.codeazur.as3redis.commands
{
	import flash.utils.ByteArray;

	import com.codeazur.as3redis.RedisCommand;
	
	public class GETSET extends RedisCommand
	{
		protected var _key:String;
		protected var _value:*;
		
		public function GETSET(key:String, value:*)
		{
			_key = key;
			_value = value;
		}
		
		override public function get name():String {
			return "GETSET";
		}
		
		override protected function createRequest():ByteArray {
			var ba:ByteArray = new ByteArray();
			var baValue:ByteArray = serializeValue(_value);
			ba.writeUTFBytes(name + " " + _key + " " + baValue.length + "\r\n");
			ba.writeBytes(baValue);
			ba.writeUTFBytes("\r\n");
			return ba;
		}
		
		override public function toString():String {
			if (_bulkResponses != null && _bulkResponses.length == 1) {
				return super.toString() + " " + _bulkResponses[0].readUTFBytes(_bulkResponses[0].length);
			} else {
				return super.toString() + " " + responseMessage;
			}
		}
	}

}