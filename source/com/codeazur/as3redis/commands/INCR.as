package com.codeazur.as3redis.commands
{
	import flash.utils.ByteArray;

	import com.codeazur.as3redis.RedisCommand;
	
	public class INCR extends RedisCommand
	{
		protected var _key:String;
		
		public function INCR(key:String)
		{
			_key = key;
		}
		
		override public function get name():String {
			return "INCR";
		}
		
		override protected function createRequest():ByteArray {
			var ba:ByteArray = new ByteArray();
			ba.writeUTFBytes(name + " " + _key + "\r\n");
			return ba;
		}
		
		override public function toString():String {
			if (_bulkResponses != null && _bulkResponses.length == 1) {
				return super.toString() + " " + _bulkResponses[0].readUTFBytes(_bulkResponses[0].length);
			} else {
				return super.toString() + " " + responseMessage;
			}
		}
	}

}