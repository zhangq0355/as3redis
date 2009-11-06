package com.codeazur.as3redis
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.ProgressEvent;
	import flash.net.Socket;
	import flash.utils.ByteArray;
	
	import com.codeazur.as3redis.commands.*;

	public class Redis extends EventDispatcher
	{
		protected var socket:Socket;
		protected var idleQueue:Vector.<RedisCommand>;
		protected var activeQueue:Vector.<RedisCommand>;
		protected var buffer:ByteArray;
		protected var connecting:Boolean = false;
		protected var connectResultHandler:Function;
		
		protected var _host:String;
		protected var _port:int;
		protected var _password:String;
		
		public function Redis(host:String = "127.0.0.1", port:int = 6379)
		{
			_host = host;
			_port = port;
			socket = new Socket();
			socket.addEventListener(Event.CONNECT, connectHandler);
			socket.addEventListener(ProgressEvent.SOCKET_DATA, dataHandler);
			idleQueue = new Vector.<RedisCommand>();
			activeQueue = new Vector.<RedisCommand>();
			buffer = new ByteArray();
		}

		public function get connected():Boolean { return socket.connected; }
		
		public function connect(host:String = "127.0.0.1", port:int = 6379):void {
			connectInternal(host, port);
		}
		
		public function flush():void {
			executePendingCommands();
			for (var i:uint = 0; i < idleQueue.length; i++ ) {
				executeCommand(idleQueue[i], false);
			}
			if (connected) {
				socket.flush();
			}
			idleQueue.length = 0;
		}
		
		public function sendPING():RedisCommand {
			return addCommand(new PING());
		}
		
		public function sendECHO(text:String):RedisCommand {
			return addCommand(new ECHO(text));
		}
		
		public function sendINFO():RedisCommand {
			return addCommand(new INFO());
		}
		
		public function sendSET(key:String, value:*):RedisCommand {
			return addCommand(new SET(key, value));
		}
		
		public function sendSETNX(key:String, value:*):RedisCommand {
			return addCommand(new SETNX(key, value));
		}
		
		public function sendGET(key:String):RedisCommand {
			return addCommand(new GET(key));
		}
		
		public function sendDEL(key:String):RedisCommand {
			return addCommand(new DEL(key));
		}
		
		protected function addCommand(command:RedisCommand, defer:Boolean = false):RedisCommand {
			if (!defer) {
				executeCommand(command);
			} else {
				idleQueue.push(command);
			}
			return command;
		}
		
		protected function executeCommand(command:RedisCommand, flush:Boolean = true):void {
			if (activeQueue.indexOf(command) == -1) {
				activeQueue.push(command);
			}
			if (!connected) {
				command.setStatus(RedisCommand.STATUS_PENDING);
				if (!connecting) {
					connectInternal(_host, _port, executePendingCommands);
				}
			} else {
				trace("sending: " + command);
				command.setStatus(RedisCommand.STATUS_ACTIVE);
				socket.writeBytes(command.request);
				if (flush) {
					socket.flush();
				}
			}
		}

		protected function executePendingCommands():void {
			for (var i:uint = 0; i < activeQueue.length; i++) {
				if (activeQueue[i].status == RedisCommand.STATUS_PENDING) {
					executeCommand(activeQueue[i]);
				}
			}
		}
		
		protected function connectInternal(host:String, port:int, resultHandler:Function = null):void {
			_host = host;
			_port = port;
			connecting = true;
			connectResultHandler = resultHandler;
			socket.connect(host, port);
		}

		protected function connectHandler(e:Event):void {
			trace("connected");
			dispatchEvent(e.clone());
			if (connectResultHandler != null) {
				connectResultHandler();
			}
		}
		
		protected function dataHandler(e:ProgressEvent):void {
			//trace("received " + socket.bytesAvailable + " bytes");
			socket.readBytes(buffer, buffer.length, socket.bytesAvailable);
			buffer.position = 0;
			var commandProcessed:Boolean = true;
			while (commandProcessed && buffer.length - buffer.position >= 3) {
				var pos:uint = buffer.position;
				var i:int = findCRLF(buffer, buffer.position);
				if (i > 0) {
					var curCommandIdx:int = getFirstActiveCommandIdx();
					if (curCommandIdx >= 0) {
						var len:uint;
						var command:RedisCommand = activeQueue[curCommandIdx];
						var type:String = String.fromCharCode(buffer.readUnsignedByte());
						var head:String = buffer.readUTFBytes(i - buffer.position);
						buffer.position += 2; // skip crlf
						switch(type) {
							case "-":
								command.setResponseType(RedisCommand.RESPONSE_TYPE_ERROR);
								command.setResponseMessage(head);
								command.fault();
								break;
							case "+":
								command.setResponseType(RedisCommand.RESPONSE_TYPE_STRING);
								command.setResponseMessage(head);
								command.result();
								break;
							case ":":
								command.setResponseType(RedisCommand.RESPONSE_TYPE_INTEGER);
								command.setResponseMessage(head);
								command.result();
								break;
							case "$":
								len = parseInt(head);
								if (len >= 0) {
									if (buffer.length - buffer.position - len - 2 >= 0) {
										command.addBulkResponse(parseBulk(len));
										command.setResponseType(RedisCommand.RESPONSE_TYPE_BULK);
										command.result();
									} else {
										buffer.position = pos;
										commandProcessed = false;
									}
								} else {
									command.setResponseType(RedisCommand.RESPONSE_TYPE_BULK);
									command.result();
								}
								break;
							case "*":
								// TODO:
								var count:int = parseInt(head);
								// command.setResponseType(RedisCommand.RESPONSE_TYPE_BULK_MULTI);
								commandProcessed = false;
								break;
							default:
								throw(new Error("Illegal header type '" + type + "'."));
						}
						if (commandProcessed) {
							activeQueue.splice(curCommandIdx, 1);
						}
					} else {
						throw(new Error("No active commands found."));
					}
				} else if (i == 0) {
					throw(new Error("Empty header."));
				}
			}
			if (buffer.position < buffer.length) {
				var ba:ByteArray = new ByteArray();
				ba.writeBytes(buffer, buffer.position, buffer.length - buffer.position);
				buffer = ba;
			} else {
				buffer.length = 0;
			}
		}
		
		protected function parseBulk(len:int):ByteArray {
			var ba:ByteArray = new ByteArray();
			if (len > 0) {
				buffer.readBytes(ba, 0, len);
				ba.position = 0;
			}
			var idx:int = findCRLF(buffer, buffer.position);
			if (idx >= 0) {
				if (idx > buffer.position) {
					trace("Warning: skipped " + (idx - buffer.position) + " bytes after bulk data");
				}
				buffer.position = idx + 2;
			}
			return ba;
		}
		
		protected function findCRLF(ba:ByteArray, startAtIndex:uint = 0):int {
			for (var i:uint = startAtIndex; i < ba.length - 1; i++) {
				if (ba[i] == 0x0d && ba[i + 1] == 0x0a) {
					return i;
				}
			}
			return -1;
		}
		
		protected function getFirstActiveCommandIdx():int {
			for (var i:uint = 0; i < activeQueue.length; i++) {
				if (activeQueue[i].status == RedisCommand.STATUS_ACTIVE) {
					return i;
				}
			}
			return -1;
		}
	}
}
