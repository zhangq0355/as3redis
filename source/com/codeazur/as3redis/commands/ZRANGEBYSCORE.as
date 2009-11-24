package com.codeazur.as3redis.commands
{
	import com.codeazur.as3redis.RedisCommand;
	
	import flash.utils.IDataOutput;
	
	public class ZRANGEBYSCORE extends RedisCommand
	{
		protected var _key:String;
		protected var _minScore:Number;
		protected var _maxScore:Number;
		
		public function ZRANGEBYSCORE(key:String, minScore:Number, maxScore:Number)
		{
			_key = key;
			_minScore = minScore;
			_maxScore = maxScore;
		}
		
		override public function get name():String {
			return "ZRANGEBYSCORE";
		}
		
		override public function send(stream:IDataOutput):void {
			stream.writeUTFBytes(name + " " + _key + " " + _minScore + " " + _maxScore + "\r\n");
			super.send(stream);
		}
		
		override public function toStringCommand():String {
			return "[" + name + " " + _key + " " + _minScore + " " + _maxScore + "]";
		}
	}
}