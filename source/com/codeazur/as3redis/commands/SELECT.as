package com.codeazur.as3redis.commands
{
	import com.codeazur.as3redis.RedisCommand;
	
	import flash.utils.ByteArray;
	
	public class SELECT extends RedisCommand
	{
		protected var _dbIndex:uint;
		
		public function SELECT(dbIndex:uint)
		{
			_dbIndex = dbIndex;
		}
		
		override public function get name():String {
			return "SELECT";
		}
		
		override protected function createRequest():ByteArray {
			var ba:ByteArray = new ByteArray();
			ba.writeUTFBytes(name + " " + _dbIndex + "\r\n");
			return ba;
		}
		
		override public function toStringCommand():String {
			return "[" + name + " " + _dbIndex + "]";
		}
	}
}