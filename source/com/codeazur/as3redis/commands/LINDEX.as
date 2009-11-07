package com.codeazur.as3redis.commands
{
	import flash.utils.ByteArray;

	import com.codeazur.as3redis.RedisCommand;
	
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
		
		override protected function createRequest():ByteArray {
			var ba:ByteArray = new ByteArray();
			ba.writeUTFBytes(name + " " + _key  + " " + _index + "\r\n");
			return ba;
		}

		override public function toStringCommand():String {
			return "[" + name + " " + _key + " " + _index + "]";
		}
	}
}
