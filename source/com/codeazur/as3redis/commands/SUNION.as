package com.codeazur.as3redis.commands
{
	import com.codeazur.as3redis.RedisCommand;
	
	import flash.utils.IDataOutput;
	
	public class SUNION extends RedisCommand
	{
		protected var _keys:Array;
		
		public function SUNION(keys:Array)
		{
			_keys = (keys == null) ? [] : keys;
		}
		
		override public function get name():String {
			return "SUNION";
		}
		
		override public function send(stream:IDataOutput):void {
			stream.writeUTFBytes(name + " " + _keys.join(" ") + "\r\n");
		}

		override public function toStringCommand():String {
			return "[" + name + " " + _keys.join(" ") + "]";
		}
	}
}
