package com.codeazur.as3redis.commands
{
	import com.codeazur.as3redis.RedisCommand;
	
	import flash.utils.ByteArray;
	import flash.utils.IDataOutput;
	
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
		
		override public function send(stream:IDataOutput):void {
			super.send(stream);
			var baValue:ByteArray = serializeValue(_value);
			stream.writeUTFBytes(name + " " + _sourceKey + " " + _destinationKey + " " + baValue.length + "\r\n");
			stream.writeBytes(baValue);
			stream.writeUTFBytes("\r\n");
		}

		override public function toStringCommand():String {
			return "[" + name + " " + _sourceKey + " " + _destinationKey + " " + toStringValue(_value) + "]";
		}
	}
}
