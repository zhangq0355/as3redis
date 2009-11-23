package com.codeazur.as3redis.commands
{
	import com.codeazur.as3redis.RedisCommand;

	import flash.utils.IDataOutput;

	public class DECRBY extends RedisCommand
	{
		protected var _key:String;
		protected var _value:uint;
		
		public function DECRBY(key:String, value:uint)
		{
			_key = key;
			_value = value;
		}
		
		override public function get name():String {
			return "DECRBY";
		}
		
		override public function send(stream:IDataOutput):void {
			super.send(stream);
			stream.writeUTFBytes(name + " " + _key + " " + _value + "\r\n");
		}

		override public function toStringCommand():String {
			return "[" + name + " " + _key + " " + _value + "]";
		}
	}
}