package com.codeazur.as3redis.commands
{
	import com.codeazur.as3redis.RedisCommand;
	
	import flash.utils.ByteArray;
	import flash.utils.IDataOutput;
	
	public class ZADD extends RedisCommand
	{
		protected var _key:String;
		protected var _score:Number;
		protected var _value:*;
		
		public function ZADD(key:String, score:Number, value:*)
		{
			_key = key;
			_score = score;
			_value = value;
		}
		
		override public function get name():String {
			return "ZADD";
		}
		
		override public function send(stream:IDataOutput):void {
			var baValue:ByteArray = serializeValue(_value);
			stream.writeUTFBytes(name + " " + _key + " " + _score + " " + baValue.length + "\r\n");
			stream.writeBytes(baValue);
			stream.writeUTFBytes("\r\n");
			super.send(stream);
		}
		
		override public function toStringCommand():String {
			return "[" + name + " " + _key + " " + _score + " " + toStringValue(_value) + "]";
		}
	}
}