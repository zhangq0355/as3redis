package com.codeazur.as3redis.commands
{
	import com.codeazur.as3redis.RedisCommand;
	
	import flash.utils.IDataOutput;
	
	public class LINDEX extends RedisCommand
	{
		protected var _key:String;
		protected var _index:int;
		
		public function LINDEX(key:String, index:int)
		{
			_key = key;
			_index = index;
		}
		
		override public function get name():String {
			return "LINDEX";
		}
		
		override public function send(stream:IDataOutput):void {
			stream.writeUTFBytes(name + " " + _key  + " " + _index + "\r\n");
			super.send(stream);
		}

		override public function toStringCommand():String {
			return "[" + name + " " + _key + " " + _index + "]";
		}
	}
}
