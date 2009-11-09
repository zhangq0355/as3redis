package com.codeazur.as3redis.commands
{
	import flash.utils.ByteArray;

	import com.codeazur.as3redis.RedisCommand;
	
	public class KEYS extends RedisCommand
	{
		protected var _pattern:String;
		
		protected var _keys:Array;
		
		public function KEYS(pattern:String)
		{
			_pattern = pattern;
			_keys = [];
		}
		
		public function get keys():Array { return _keys; }
		
		override public function get name():String {
			return "KEYS";
		}
		
		override protected function createRequest():ByteArray {
			var ba:ByteArray = new ByteArray();
			ba.writeUTFBytes(name + " " + _pattern + "\r\n");
			return ba;
		}

		override protected function processBulkResponse(response:ByteArray):void {
			if (response && response.length > 0) {
				var p:String = response.readUTFBytes(response.length);
				var pa:Array = p.split(" ");
				for (var i:uint = 0; i < pa.length; i++) {
					_keys.push(pa[i]);
				}
			}
		}

		override public function toStringCommand():String {
			return "[" + name + " " + _pattern + "]";
		}
	}
}
