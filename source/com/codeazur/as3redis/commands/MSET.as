package com.codeazur.as3redis.commands
{
	import com.codeazur.as3redis.RedisCommand;
	
	import flash.utils.ByteArray;
	import flash.utils.IDataOutput;
	
	public class MSET extends RedisCommand
	{
		protected var _keys:Array;
		protected var _values:Array;
		
		public function MSET(keys:Array, values:Array)
		{
			_keys = (keys != null) ? keys : [];
			_values = (values != null) ? values : [];
		}
		
		override public function get name():String {
			return "MSET";
		}
		
		override public function send(stream:IDataOutput):void {
			var kvlen:uint = Math.min(_keys.length, _values.length);
			// write number of bulks for this command
			stream.writeUTFBytes("*" + (kvlen * 2 + 1) + "\r\n");
			// write command name as bulk
			stream.writeUTFBytes("$" + (name.length) + "\r\n" + name + "\r\n");
			// write key value pairs as bulks
			var key:ByteArray;
			var value:ByteArray;
			for (var i:uint = 0; i < kvlen; i++) {
				key = serializeValue(_keys[i]);
				value = serializeValue(_values[i]);
				stream.writeUTFBytes("$" + (key.length) + "\r\n");
				stream.writeBytes(key);
				stream.writeUTFBytes("\r\n$" + (value.length) + "\r\n");
				stream.writeBytes(value);
				stream.writeUTFBytes("\r\n");
			}
			super.send(stream);
		}
		
		override public function toStringCommand():String {
			var s:String = "[" + name;
			var kvlen:uint = Math.min(_keys.length, _values.length);
			for (var i:uint = 0; i < kvlen; i++) {
				s += " " + toStringValue(_keys[i]) + " " + toStringValue(_values[i]);
			}
			return s + "]";
		}
	}
}