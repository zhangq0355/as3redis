package com.codeazur.as3redis.commands
{
	import flash.utils.ByteArray;

	import com.codeazur.as3redis.RedisCommand;
	
	public class INCRBY extends RedisCommand
	{
		protected var _key:String;
		protected var _value:uint;
		
		public function INCRBY(key:String, value:uint)
		{
			_key = key;
			_value = value;
		}
		
		override public function get name():String {
			return "INCRBY";
		}
		
		override protected function createRequest():ByteArray {
			var ba:ByteArray = new ByteArray();
			ba.writeUTFBytes(name + " " + _key + " " + _value + "\r\n");
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