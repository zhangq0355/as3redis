package com.codeazur.as3redis.commands
{
	import com.codeazur.as3redis.RedisCommand;
	
	import flash.utils.IDataOutput;
	
	public class EXPIRE extends RedisCommand
	{
		protected var _key:String;
		protected var _seconds:uint;
		
		public function EXPIRE(key:String, seconds:uint)
		{
			_key = key;
			_seconds = seconds;
		}
		
		override public function get name():String {
			return "EXPIRE";
		}
		
		override public function send(stream:IDataOutput):void {
			stream.writeUTFBytes(name + " " + _key + " " + _seconds + "\r\n");
			super.send(stream);
		}

		override public function toStringCommand():String {
			return "[" + name + " " + _key + " " + _seconds + "]";
		}
	}
}
