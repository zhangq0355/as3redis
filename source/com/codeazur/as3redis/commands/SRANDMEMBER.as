package com.codeazur.as3redis.commands
{
	import flash.utils.IDataOutput;

	import com.codeazur.as3redis.RedisCommand;
	
	public class SRANDMEMBER extends RedisCommand
	{
		protected var _key:String;
		
		public function SRANDMEMBER(key:String)
		{
			_key = key;
		}
		
		override public function get name():String {
			return "SRANDMEMBER";
		}
		
		override public function send(stream:IDataOutput):void {
			stream.writeUTFBytes(name + " " + _key + "\r\n");
		}
		
		override public function toStringCommand():String {
			return "[" + name + " " + _key + "]";
		}
	}
}
