package com.codeazur.as3redis.commands
{
	import com.codeazur.as3redis.RedisCommand;

	import flash.utils.IDataOutput;

	public class DEL extends RedisCommand
	{
		protected var _keys:Array;
		
		public function DEL(keys:Array)
		{
			_keys = keys;
		}
		
		override public function get name():String {
			return "DEL";
		}
		
		override public function send(stream:IDataOutput):void {
			super.send(stream);
			var cmd:String = name;
			for (var i:uint = 0; i < _keys.length; i++) {
				cmd += " " + _keys[i];
			}
			cmd += "\r\n";
			stream.writeUTFBytes(cmd);
		}

		override public function toStringCommand():String {
			return "[" + name + ((_keys.length > 0) ? " " + _keys.join(" ") : "") + "]";
		}
	}
}
