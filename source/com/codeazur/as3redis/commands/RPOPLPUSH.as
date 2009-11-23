package com.codeazur.as3redis.commands
{
	import com.codeazur.as3redis.RedisCommand;
	
	import flash.utils.IDataOutput;
	
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
		
		override public function send(stream:IDataOutput):void {
			stream.writeUTFBytes(name + " " + _sourceKey + " " + _destinationKey + "\r\n");
		}

		override public function toStringCommand():String {
			return "[" + name + " " + _sourceKey + " " + _destinationKey + "]";
		}
	}
}
