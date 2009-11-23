package com.codeazur.as3redis.commands
{
	import com.codeazur.as3redis.RedisCommand;
	
	import flash.utils.IDataOutput;
	
	public class SUNIONSTORE extends RedisCommand
	{
		protected var _destinationKey:String;
		protected var _keys:Array;
		
		public function SUNIONSTORE(destinationKey:String, keys:Array)
		{
			_destinationKey = destinationKey;
			_keys = (keys == null) ? [] : keys;
		}
		
		override public function get name():String {
			return "SUNIONSTORE";
		}
		
		override public function send(stream:IDataOutput):void {
			super.send(stream);
			stream.writeUTFBytes(name + " " + _destinationKey + " " + _keys.join(" ") + "\r\n");
		}

		override public function toStringCommand():String {
			return "[" + name + " " + _destinationKey + " " + _keys.join(" ") + "]";
		}
	}
}
