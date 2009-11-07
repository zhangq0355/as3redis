package com.codeazur.as3redis.commands
{
	import flash.utils.ByteArray;

	import com.codeazur.as3redis.RedisCommand;
	
	public class KEYS extends RedisCommand
	{
		protected var _pattern:String;
		
		public function KEYS(pattern:String)
		{
			_pattern = pattern;
		}
		
		override public function get name():String {
			return "KEYS";
		}
		
		override protected function createRequest():ByteArray {
			var ba:ByteArray = new ByteArray();
			ba.writeUTFBytes(name + " " + _pattern + "\r\n");
			return ba;
		}

		override public function toStringCommand():String {
			return "[" + name + " " + _pattern + "]";
		}
	}
}
