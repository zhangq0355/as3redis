package com.codeazur.as3redis 
{
	import flash.net.Responder;
	import flash.utils.ByteArray;
	import flash.utils.IDataInput;
	
	public class RedisCommand
	{
		public static const STATUS_IDLE:String = "statusIdle";
		public static const STATUS_PENDING:String = "statusPending";
		public static const STATUS_ACTIVE:String = "statusActive";
		
		public static const RESPONSE_TYPE_UNDEFINED:String = "responseTypeUndefined";
		public static const RESPONSE_TYPE_ERROR:String = "responseTypeError";
		public static const RESPONSE_TYPE_STRING:String = "responseTypeString";
		public static const RESPONSE_TYPE_INTEGER:String = "responseTypeInteger";
		public static const RESPONSE_TYPE_BULK:String = "responseTypeBulk";
		public static const RESPONSE_TYPE_BULK_MULTI:String = "responseTypeBulkMulti";
		
		protected var responders:Vector.<RedisResponder>;
		
		protected var _status:String = STATUS_IDLE;
		protected var _responseType:String = RESPONSE_TYPE_UNDEFINED;
		protected var _responseMessage:String = "";
		
		protected var _request:ByteArray;
		protected var _bulkResponses:Vector.<ByteArray>;
		
		public function RedisCommand()
		{
		}
		
		public function get status():String { return _status; }
		public function get responseType():String { return _responseType; }
		public function get responseMessage():String { return _responseMessage; }
		
		internal function setStatus(value:String):void {
			_status = value;
		}
		
		internal function setResponseType(value:String):void {
			_responseType = value;
		}

		internal function setResponseMessage(value:String):void {
			_responseMessage = value;
		}

		internal function addBulkResponse(response:ByteArray):void {
			if (_bulkResponses == null) {
				_bulkResponses = Vector.<ByteArray>( [ response ] );
			} else {
				_bulkResponses.push(response);
			}
			processBulkResponse(response);
		}
		
		protected function processBulkResponse(response:ByteArray):void {
			// Override in subclasses
		}

		public function get name():String {
			// Override in subclasses
			throw(new Error("Please override the name getter."));
		}
		
		public function get request():ByteArray {
			if (_request == null) {
				_request = createRequest();
			}
			return _request;
		}
		
		protected function createRequest():ByteArray {
			// Override in subclasses
			var ba:ByteArray = new ByteArray();
			ba.writeUTFBytes(name + "\r\n");
			return ba;
		}
		
		protected function serializeValue(value:*):ByteArray {
			var ba:ByteArray = new ByteArray();
			if (value is String || value is Number || value is int || value is uint || value is Boolean) {
				ba.writeUTFBytes(String(value));
			} else if (value is ByteArray) {
				ba = value as ByteArray;
			} else {
				ba.writeObject(value);
			}
			return ba;
		}
		
		public function addResponder(responder:RedisResponder):void {
			if (responders == null) {
				responders = Vector.<RedisResponder>( [ responder ] );
			} else {
				responders.push(responder);
			}
		}
		
		public function removeAllResponders():void {
			responders = null;
		}
		
		public function hasResponders():Boolean {
			return (responders != null) && (responders.length > 0);
		}
		
		public function result():void {
			trace(toString());
			if (hasResponders()) {
				for (var i:uint = 0; i < responders.length; i++) {
					responders[i].result();
				}
			}
		}
		
		public function fault():void {
			if (hasResponders()) {
				for (var i:uint = 0; i < responders.length; i++) {
					responders[i].status();
				}
			}
		}

		public function toString():String {
			return "[" + name + "]";
		}
	}
}
