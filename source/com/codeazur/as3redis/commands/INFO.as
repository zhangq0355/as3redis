package com.codeazur.as3redis.commands
{
	import flash.utils.ByteArray;
	import flash.utils.Dictionary;

	import com.codeazur.as3redis.RedisCommand;
	
	public class INFO extends RedisCommand
	{
		protected var _params:Dictionary;
		protected var _paramCount:uint = 0;
		
		public function INFO()
		{
			_params = new Dictionary();
		}
		
		public function get params():Dictionary { return _params; }
		
		override public function get name():String {
			return "INFO";
		}
		
		override protected function processBulkResponse(response:ByteArray):void {
			_paramCount = 0;
			if (response && response.length > 0) {
				var p:String = response.readUTFBytes(response.length);
				var pa:Array = p.split("\r\n");
				for (var i:uint = 0; i < pa.length; i++) {
					var kv:Array = pa[i].split(":");
					if (kv.length == 2) {
						_params[kv[0]] = kv[1];
						_paramCount++;
					}
				}
			}
		}

		override public function toString():String {
			if (_bulkResponses != null && _bulkResponses.length == 1) {
				return super.toString() + " (" + _paramCount + " parameters)";
			} else {
				return super.toString();
			}
		}
	}

}