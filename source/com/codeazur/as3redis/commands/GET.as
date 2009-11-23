package com.codeazur.as3redis.commands
{
	import flash.utils.IDataOutput;

	import com.codeazur.as3redis.RedisCommand;
	
	public class GET extends RedisCommand
	{
		protected var _key:String;
		
		public function GET(key:String)
		{
			_key = key;
		}
		
		override public function get name():String {
			return "GET";
		}
		
		override public function send(stream:IDataOutput):void {
			stream.writeUTFBytes(name + " " + _key + "\r\n");
		}
		
		override public function toStringCommand():String {
			return "[" + name + " " + _key + "]";
		}
	}
}
