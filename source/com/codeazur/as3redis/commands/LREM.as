package com.codeazur.as3redis.commands
{
	import com.codeazur.as3redis.RedisCommand;
	
	import flash.utils.ByteArray;
	import flash.utils.IDataOutput;
	
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
		
		override public function send(stream:IDataOutput):void {
			super.send(stream);
			var baValue:ByteArray = serializeValue(_value);
			stream.writeUTFBytes(name + " " + _key  + " " + _count + " " + baValue.length + "\r\n");
			stream.writeBytes(baValue);
			stream.writeUTFBytes("\r\n");
		}
		
		override public function toStringCommand():String {
			return "[" + name + " " + _key + " " + _count + " " + toStringValue(_value) + "]";
		}
	}
}
