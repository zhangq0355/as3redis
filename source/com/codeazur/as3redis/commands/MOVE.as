package com.codeazur.as3redis.commands
{
	import com.codeazur.as3redis.RedisCommand;
	
	import flash.utils.IDataOutput;
	
	public class MOVE extends RedisCommand
	{
		protected var _key:String;
		protected var _dbIndex:uint;
		
		public function MOVE(key:String, dbIndex:uint)
		{
			_key = key;
			_dbIndex = dbIndex;
		}
		
		override public function get name():String {
			return "MOVE";
		}
		
		override public function send(stream:IDataOutput):void {
			super.send(stream);
			stream.writeUTFBytes(name + " " + _key + " " + _dbIndex + "\r\n");
		}
		
		override public function toStringCommand():String {
			return "[" + name + " " + _key + " " + _dbIndex + "]";
		}
	}
}