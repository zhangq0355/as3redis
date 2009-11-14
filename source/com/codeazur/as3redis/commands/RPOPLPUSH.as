package com.codeazur.as3redis.commands
{
	import flash.utils.ByteArray;

	import com.codeazur.as3redis.RedisCommand;
	
	public class RPOPLPUSH extends RedisCommand
	{
		protected var _sourceKey:String;
		protected var _destinationKey:String;
		
		public function RPOPLPUSH(sourceKey:String, destinationKey:String)
		{
			_sourceKey = sourceKey;
			_destinationKey = destinationKey
		}
		
		override public function get name():String {
			return "RPOPLPUSH";
		}
		
		override protected function createRequest():ByteArray {
			var ba:ByteArray = new ByteArray();
			ba.writeUTFBytes(name + " " + _sourceKey + " " + _destinationKey + "\r\n");
			return ba;
		}

		override public function toStringCommand():String {
			return "[" + name + " " + _sourceKey + " " + _destinationKey + "]";
		}
	}
}
