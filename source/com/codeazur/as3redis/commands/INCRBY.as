package com.codeazur.as3redis.commands
{
	import flash.utils.IDataOutput;

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
		
		override public function send(stream:IDataOutput):void {
			stream.writeUTFBytes(name + " " + _key + " " + _value + "\r\n");
		}

		override public function toStringCommand():String {
			return "[" + name + " " + _key + " " + _value + "]";
		}
	}
}
