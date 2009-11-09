package com.codeazur.as3redis.commands
{
	import flash.utils.ByteArray;

	import com.codeazur.as3redis.RedisCommand;
	
	public class SMOVE extends RedisCommand
	{
		protected var _sourceKey:String;
		protected var _destinationKey:String;
		protected var _value:*;
		
		public function SMOVE(sourceKey:String, destinationKey:String, value:*)
		{
			_sourceKey = sourceKey;
			_destinationKey = destinationKey
			_value = value;
		}
		
		override public function get name():String {
			return "SMOVE";
		}
		
		override protected function createRequest():ByteArray {
			var ba:ByteArray = new ByteArray();
			var baValue:ByteArray = serializeValue(_value);
			ba.writeUTFBytes(name + " " + _sourceKey + " " + _destinationKey + " " + baValue.length + "\r\n");
			ba.writeBytes(baValue);
			ba.writeUTFBytes("\r\n");
			return ba;
		}

		override public function toStringCommand():String {
			return "[" + name + " " + _sourceKey + " " + _destinationKey + " " + toStringValue(_value) + "]";
		}
	}
}
