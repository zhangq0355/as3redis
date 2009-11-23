package com.codeazur.as3redis.commands
{
	import com.codeazur.as3redis.RedisCommand;
	
	import flash.utils.IDataOutput;
	
	public class SDIFF extends RedisCommand
	{
		protected var _keys:Array;
		
		public function SDIFF(keys:Array)
		{
			_keys = (keys == null) ? [] : keys;
		}
		
		override public function get name():String {
			return "SDIFF";
		}
		
		override public function send(stream:IDataOutput):void {
			stream.writeUTFBytes(name + " " + _keys.join(" ") + "\r\n");
			super.send(stream);
		}
		
		override public function toStringCommand():String {
			return "[" + name + " " + _keys.join(" ") + "]";
		}
	}
}
