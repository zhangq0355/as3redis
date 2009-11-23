package com.codeazur.as3redis.commands
{
	import com.codeazur.as3redis.RedisCommand;
	
	import flash.utils.ByteArray;
	import flash.utils.IDataOutput;
	
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
		
		override public function send(stream:IDataOutput):void {
			super.send(stream);
			var baValue:ByteArray = serializeValue(_value);
			stream.writeUTFBytes(name + " " + _key  + " " + _index + " " + baValue.length + "\r\n");
			stream.writeBytes(baValue);
			stream.writeUTFBytes("\r\n");
		}
		
		override public function toStringCommand():String {
			return "[" + name + " " + _key + " " + _index + " " + toStringValue(_value) + "]";
		}
	}
}
