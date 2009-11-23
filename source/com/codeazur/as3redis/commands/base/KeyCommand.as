package com.codeazur.as3redis.commands.base
{
	import com.codeazur.as3redis.RedisCommand;
	
	import flash.utils.IDataOutput;
	
	public class KeyCommand extends RedisCommand
	{
		protected var _key:String;

		public function KeyCommand(key:String)
		{
			_key = key;
		}
		
		override public function send(stream:IDataOutput):void {
			super.send(stream);
			stream.writeUTFBytes(name + " " + _key + "\r\n");
		}
		
		override public function toStringCommand():String {
			return "[" + name + " " + _key + "]";
		}
	}
}