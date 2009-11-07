package com.codeazur.as3redis.commands
{
	import flash.utils.ByteArray;

	import com.codeazur.as3redis.RedisCommand;
	
	public class RENAME extends RedisCommand
	{
		protected var _oldKey:String;
		protected var _newKey:String;
		
		public function RENAME(oldKey:String, newKey:String)
		{
			_oldKey = oldKey;
			_newKey = newKey;
		}
		
		override public function get name():String {
			return "RENAME";
		}
		
		override protected function createRequest():ByteArray {
			var ba:ByteArray = new ByteArray();
			ba.writeUTFBytes(name + " " + _oldKey + " " + _newKey + "\r\n");
			return ba;
		}

		override public function toStringCommand():String {
			return "[" + name + " " + _oldKey + " " + _newKey + "]";
		}
	}
}
