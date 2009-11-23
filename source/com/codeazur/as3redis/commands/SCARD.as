package com.codeazur.as3redis.commands
{
	import com.codeazur.as3redis.RedisCommand;
	
	import flash.utils.IDataOutput;
	
	public class SCARD extends RedisCommand
	{
		protected var _key:String;
		
		public function SCARD(key:String)
		{
			_key = key;
		}
		
		override public function get name():String {
			return "SCARD";
		}
		
		override public function send(stream:IDataOutput):void {
			stream.writeUTFBytes(name + " " + _key + "\r\n");
		}
		
		override public function toStringCommand():String {
			return "[" + name + " " + _key + "]";
		}
	}
}
