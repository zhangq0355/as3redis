﻿package com.codeazur.as3redis.commands
{
	import com.codeazur.as3redis.RedisCommand;
	
	import flash.utils.ByteArray;
	import flash.utils.IDataOutput;
	
	public class SADD extends RedisCommand
	{
		protected var _key:String;
		protected var _value:*;
		
		public function SADD(key:String, value:*)
		{
			_key = key;
			_value = value;
		}
		
		override public function get name():String {
			return "SADD";
		}
		
		override public function send(stream:IDataOutput):void {
			var baValue:ByteArray = serializeValue(_value);
			stream.writeUTFBytes(name + " " + _key + " " + baValue.length + "\r\n");
			stream.writeBytes(baValue);
			stream.writeUTFBytes("\r\n");
		}
		
		override public function toStringCommand():String {
			return "[" + name + " " + _key + " " + _value + "]";
		}
	}
}
