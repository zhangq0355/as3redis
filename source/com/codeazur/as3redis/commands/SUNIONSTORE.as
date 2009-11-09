﻿package com.codeazur.as3redis.commands
{
	import flash.utils.ByteArray;

	import com.codeazur.as3redis.RedisCommand;
	
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
		
		override protected function createRequest():ByteArray {
			var ba:ByteArray = new ByteArray();
			ba.writeUTFBytes(name + " " + _destinationKey + " " + _keys.join(" ") + "\r\n");
			return ba;
		}

		override public function toStringCommand():String {
			return "[" + name + " " + _destinationKey + " " + _keys.join(" ") + "]";
		}
	}
}