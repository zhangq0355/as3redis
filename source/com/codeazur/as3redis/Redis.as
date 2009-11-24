package com.codeazur.as3redis
{
	import com.codeazur.as3redis.commands.*;
	import com.codeazur.as3redis.events.RedisMonitorDataEvent;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.Socket;
	import flash.utils.ByteArray;
	import flash.utils.getTimer;

	public class Redis extends EventDispatcher
	{
		protected var socket:Socket;
		protected var idleQueue:Vector.<RedisCommand>;
		protected var activeQueue:Vector.<RedisCommand>;
		protected var buffer:ByteArray;
		protected var active:Boolean = false;
		protected var connecting:Boolean = false;
		protected var connectResultHandler:Function;
		protected var enterFrameProvider:Sprite;
		
		protected var _host:String;
		protected var _port:int;
		protected var _password:String;
		protected var _immediateSend:Boolean = true;
		
		public function Redis(host:String = "127.0.0.1", port:int = 6379)
		{
			_host = host;
			_port = port;

			idleQueue = new Vector.<RedisCommand>();
			activeQueue = new Vector.<RedisCommand>();
			buffer = new ByteArray();
			enterFrameProvider = new Sprite();

			socket = new Socket();
			socket.addEventListener(Event.CONNECT, connectHandler);
			socket.addEventListener(ProgressEvent.SOCKET_DATA, dataHandler);
			socket.addEventListener(IOErrorEvent.IO_ERROR, errorHandler);
			socket.addEventListener(SecurityErrorEvent.SECURITY_ERROR, errorHandler);
		}
		
		public function get password():String { return _password; }
		public function set password(value:String):void { _password = value; }

		public function get immediateSend():Boolean { return _immediateSend; }
		public function set immediateSend(value:Boolean):void { _immediateSend = value; }
		
		public function get connected():Boolean { return socket.connected; }
		
		public function connect(host:String = "127.0.0.1", port:int = 6379):void {
			connectInternal(host, port);
		}
		
		public function flush():void {
			executeIdleCommands();
		}
		

		// Connection handling
		
		public function sendQUIT():RedisCommand {
			return addCommand(new QUIT());
		}
		
		public function sendAUTH(password:String):RedisCommand {
			return addCommand(new AUTH(password));
		}
		
		
		// Commands operating on string values
		
		public function sendSET(key:String, value:*):RedisCommand {
			return addCommand(new SET(key, value));
		}
		
		public function sendGET(key:String):RedisCommand {
			return addCommand(new GET(key));
		}
		
		public function sendGETSET(key:String, value:*):RedisCommand {
			return addCommand(new GETSET(key, value));
		}
		
		public function sendMGET(keys:Array):RedisCommand {
			return addCommand(new MGET(keys));
		}
		
		public function sendSETNX(key:String, value:*):RedisCommand {
			return addCommand(new SETNX(key, value));
		}
		
		public function sendINCR(key:String):RedisCommand {
			return addCommand(new INCR(key));
		}
		
		public function sendINCRBY(key:String, value:uint):RedisCommand {
			return addCommand(new INCRBY(key, value));
		}
		
		public function sendDECR(key:String):RedisCommand {
			return addCommand(new DECR(key));
		}
		
		public function sendDECRBY(key:String, value:uint):RedisCommand {
			return addCommand(new DECRBY(key, value));
		}
		
		public function sendEXISTS(key:String):RedisCommand {
			return addCommand(new EXISTS(key));
		}

		public function sendDEL(keys:Array):RedisCommand {
			return addCommand(new DEL(keys));
		}
		
		public function sendTYPE(key:String):RedisCommand {
			return addCommand(new TYPE(key));
		}

		
		// Commands operating on the key space
		
		public function sendKEYS(pattern:String):RedisCommand {
			return addCommand(new KEYS(pattern));
		}

		public function sendRANDOMKEY():RedisCommand {
			return addCommand(new RANDOMKEY());
		}
		
		public function sendRENAME(oldKey:String, newKey:String):RedisCommand {
			return addCommand(new RENAME(oldKey, newKey));
		}

		public function sendRENAMENX(oldKey:String, newKey:String):RedisCommand {
			return addCommand(new RENAMENX(oldKey, newKey));
		}

		public function sendDBSIZE():RedisCommand {
			return addCommand(new DBSIZE());
		}

		public function sendEXPIRE(key:String, seconds:uint):RedisCommand {
			return addCommand(new EXPIRE(key, seconds));
		}

		public function sendTTL(key:String):RedisCommand {
			return addCommand(new TTL(key));
		}

		
		// Commands operating on lists
		
		public function sendRPUSH(key:String, value:*):RedisCommand {
			return addCommand(new RPUSH(key, value));
		}

		public function sendLPUSH(key:String, value:*):RedisCommand {
			return addCommand(new LPUSH(key, value));
		}

		public function sendLLEN(key:String):RedisCommand {
			return addCommand(new LLEN(key));
		}

		public function sendLRANGE(key:String, startIndex:int, endIndex:int):RedisCommand {
			return addCommand(new LRANGE(key, startIndex, endIndex));
		}

		public function sendLTRIM(key:String, startIndex:int, endIndex:int):RedisCommand {
			return addCommand(new LTRIM(key, startIndex, endIndex));
		}

		public function sendLINDEX(key:String, index:int):RedisCommand {
			return addCommand(new LINDEX(key, index));
		}

		public function sendLSET(key:String, index:int, value:*):RedisCommand {
			return addCommand(new LSET(key, index, value));
		}

		public function sendLREM(key:String, count:int, value:*):RedisCommand {
			return addCommand(new LREM(key, count, value));
		}
		
		public function sendLPOP(key:String):RedisCommand {
			return addCommand(new LPOP(key));
		}

		public function sendRPOP(key:String):RedisCommand {
			return addCommand(new RPOP(key));
		}
		
		// Version 1.1
		public function sendRPOPLPUSH(sourceKey:String, destinationKey:String):RedisCommand {
			return addCommand(new RPOPLPUSH(sourceKey, destinationKey));
		}


		// Commands operating on sets
		
		public function sendSADD(key:String, value:*):RedisCommand {
			return addCommand(new SADD(key, value));
		}

		public function sendSREM(key:String, value:*):RedisCommand {
			return addCommand(new SREM(key, value));
		}

		public function sendSPOP(key:String):RedisCommand {
			return addCommand(new SPOP(key));
		}

		public function sendSMOVE(sourceKey:String, destinationKey:String, value:*):RedisCommand {
			return addCommand(new SMOVE(sourceKey, destinationKey, value));
		}

		public function sendSCARD(key:String):RedisCommand {
			return addCommand(new SCARD(key));
		}

		public function sendSISMEMBER(key:String, value:*):RedisCommand {
			return addCommand(new SISMEMBER(key, value));
		}

		public function sendSINTER(keys:Array):RedisCommand {
			return addCommand(new SINTER(keys));
		}

		public function sendSINTERSTORE(destinationKey:String, keys:Array):RedisCommand {
			return addCommand(new SINTERSTORE(destinationKey, keys));
		}

		public function sendSUNION(keys:Array):RedisCommand {
			return addCommand(new SUNION(keys));
		}

		public function sendSUNIONSTORE(destinationKey:String, keys:Array):RedisCommand {
			return addCommand(new SUNIONSTORE(destinationKey, keys));
		}

		public function sendSDIFF(keys:Array):RedisCommand {
			return addCommand(new SDIFF(keys));
		}

		public function sendSDIFFSTORE(destinationKey:String, keys:Array):RedisCommand {
			return addCommand(new SDIFFSTORE(destinationKey, keys));
		}

		public function sendSMEMBERS(key:String):RedisCommand {
			return addCommand(new SMEMBERS(key));
		}

		// Version 1.1
		public function sendSRANDMEMBER(key:String):RedisCommand {
			return addCommand(new SRANDMEMBER(key));
		}
		
		
		// Commands operating on sorted sets (zsets, Version 1.1)

		public function sendZADD(key:String, score:Number, value:*):RedisCommand {
			return addCommand(new ZADD(key, score, value));
		}

		public function sendZREM(key:String, value:*):RedisCommand {
			return addCommand(new ZREM(key, value));
		}
		
		public function sendZRANGE(key:String, startIndex:int, endIndex:int):RedisCommand {
			return addCommand(new ZRANGE(key, startIndex, endIndex));
		}
		
		public function sendZREVRANGE(key:String, startIndex:int, endIndex:int):RedisCommand {
			return addCommand(new ZREVRANGE(key, startIndex, endIndex));
		}
		
		public function sendZRANGEBYSCORE(key:String, minScore:Number, maxScore:Number):RedisCommand {
			return addCommand(new ZRANGEBYSCORE(key, minScore, maxScore));
		}
		
		public function sendZCARD(key:String):RedisCommand {
			return addCommand(new ZCARD(key));
		}
		
		public function sendZSCORE(key:String, value:*):RedisCommand {
			return addCommand(new ZSCORE(key, value));
		}
		
		
		// Multiple databases handling commands
		
		public function sendSELECT(dbIndex:uint):RedisCommand {
			return addCommand(new SELECT(dbIndex));
		}
		
		public function sendMOVE(key:String, dbIndex:uint):RedisCommand {
			return addCommand(new MOVE(key, dbIndex));
		}
		
		public function sendFLUSHDB():RedisCommand {
			return addCommand(new FLUSHDB());
		}
		
		public function sendFLUSHALL():RedisCommand {
			return addCommand(new FLUSHALL());
		}

		
		// Sorting
		
		public function sendSORT(key:String, limitMin:int = -1, limitMax:int = -1, desc:Boolean = false, alpha:Boolean = false, byPattern:String = null, getPatterns:Array = null):RedisCommand {
			return addCommand(new SORT(key, limitMin, limitMax, desc, alpha, byPattern, getPatterns));
		}

		
		// Persistence control commands
		
		public function sendSAVE():RedisCommand {
			return addCommand(new SAVE());
		}
		
		public function sendBGSAVE():RedisCommand {
			return addCommand(new BGSAVE());
		}
		
		public function sendLASTSAVE():RedisCommand {
			return addCommand(new LASTSAVE());
		}
		
		public function sendSHUTDOWN():RedisCommand {
			return addCommand(new SHUTDOWN());
		}

		
		// Remote server control commands
		
		public function sendINFO():RedisCommand {
			return addCommand(new INFO());
		}
		
		public function sendMONITOR():RedisCommand {
			return addCommand(new MONITOR());
		}
		
		public function sendSLAVEOF(host:String = null, port:int = -1):RedisCommand {
			return addCommand(new SLAVEOF(host, port));
		}
		
		
		// Misc commands (undocumented)
		
		public function sendPING():RedisCommand {
			return addCommand(new PING());
		}
		
		public function sendECHO(text:String):RedisCommand {
			return addCommand(new ECHO(text));
		}
		
		
		protected function addCommand(command:RedisCommand):RedisCommand {
			idleQueue.push(command);
			executeIdleCommands();
			return command;
		}
		
		protected function executeIdleCommands():void {
			if (!active) {
				if (!connected) {
					if (!connecting) {
						connectInternal(_host, _port, executeIdleCommands);
					}
				} else {
					enterFrameProvider.addEventListener(Event.ENTER_FRAME, executeIdleCommandsRunner);
					active = true;
				}
			}
		}
		
		protected function executeIdleCommandsRunner(event:Event):void {
			var startTime:Number = getTimer();
			var command:RedisCommand;
			while(idleQueue.length > 0) {
				if(getTimer() - startTime < 20) {
					command = idleQueue.shift();
					command.send(socket);
					activeQueue.push(command);
				} else {
					break;
				}
			}
			socket.flush();
			if(idleQueue.length == 0) {
				enterFrameProvider.removeEventListener(Event.ENTER_FRAME, executeIdleCommandsRunner);
				active = false;
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
			connecting = false;
			// Redispatch the event
			dispatchEvent(e.clone());
			// Authentication
			if (_password) {
				// A password is set, so we have to send the AUTH command first
				idleQueue.splice(0, 0, new AUTH(_password));
			}
			if (connectResultHandler != null) {
				connectResultHandler();
			}
		}
		
		protected function errorHandler(e:Event):void {
			// Redispatch the event
			dispatchEvent(e.clone());
		}
		
		protected function dataHandler(e:ProgressEvent):void {
			// Read all available bytes from the socket and append them to the buffer
			socket.readBytes(buffer, buffer.length, socket.bytesAvailable);
			// Parse buffer from the start
			buffer.position = 0;
			var commandProcessed:Boolean = true;
			while (commandProcessed && buffer.length - buffer.position >= 3) {
				var pos:uint = buffer.position;
				// Find the next CR/LF pair starting from the current position
				var i:int = findCRLF(buffer, buffer.position);
				if (i > 0) {
					// We found a CR/LF, and there is data available to parse
					// Find the first active command in the queue
					var command:RedisCommand = activeQueue.shift();
					if (command != null) {
						var len:int;
						// The first byte of a redis response is always the type indicator
						var type:String = String.fromCharCode(buffer.readUnsignedByte());
						// Followed by the rest, which is interpreted as a string
						var head:String = buffer.readUTFBytes(i - buffer.position);
						// Followed by the CR/LF we found above
						buffer.position += 2; // skip crlf
						// So let's see what we're dealing with:
						switch(type) {
							case "-":
								// This is an error message
								command.setResponseType(RedisCommand.RESPONSE_TYPE_ERROR);
								command.setResponseMessage(head);
								command.fault();
								break;
							case "+":
								// This is a single line reply
								command.setResponseType(RedisCommand.RESPONSE_TYPE_STRING);
								command.setResponseMessage(head);
								command.result();
								break;
							case ":":
								// This is an integer number
								command.setResponseType(RedisCommand.RESPONSE_TYPE_INTEGER);
								command.setResponseMessage(head);
								command.result();
								break;
							case "$":
								// This is bulk data
								// Get the size of the data block
								command.removeAllBulkResponses();
								len = parseInt(head);
								if (len >= 0) {
									// Check if the entire data block is loaded already
									if (buffer.length - buffer.position - len - 2 >= 0) {
										// Yes it is, so parse and save it
										command.addBulkResponse(parseBulk(len));
										command.setResponseType(RedisCommand.RESPONSE_TYPE_BULK);
										command.result();
									} else {
										// No, we need to wait for more data
										// Set the position back to the beginning of the current response
										buffer.position = pos;
										commandProcessed = false;
									}
								} else {
									// Length can be -1 (no data available, non-existant key etc)
									command.setResponseType(RedisCommand.RESPONSE_TYPE_BULK);
									command.setResponseMessage(head);
									command.result();
								}
								break;
							case "*":
								// This is multi bulk data
								command.removeAllBulkResponses();
								var count:int = parseInt(head);
								if(count > 0) {
									for (var j:uint = 0; j < count; j++) {
										var nextcrlf:int = findCRLF(buffer, buffer.position);
										if (nextcrlf >= 0) {
											if (nextcrlf - buffer.position > 1) {
												// The first byte of a redis response is always the type indicator
												type = String.fromCharCode(buffer.readUnsignedByte());
												// Followed by the rest, which is interpreted as a string
												head = buffer.readUTFBytes(nextcrlf - buffer.position);
												// Followed the CR/LF we found above
												buffer.position += 2; // skip crlf
												// Response type must be bulk data
												if (type == "$") {
													len = parseInt(head);
													if (len >= 0) {
														// Check if the entire data block is loaded already
														if (buffer.length - buffer.position - len - 2 >= 0) {
															// Yes it is, so parse and save it
															command.addBulkResponse(parseBulk(len));
														} else {
															// No, we need to wait for more data
															// Set the position back to the beginning of the current response
															buffer.position = pos;
															commandProcessed = false;
															break;
														}
													} else {
														// Length can be -1 (no data available, non-existant key etc)
														command.addBulkResponse(null);
													}
												} else {
													throw(new Error("Illegal header type '" + type + "'."));
												}
											} else {
												throw(new Error("Empty header."));
											}
										} else {
											buffer.position = pos;
											commandProcessed = false;
											break;
										}
									}
								}
								if (commandProcessed) {
									command.setResponseType(RedisCommand.RESPONSE_TYPE_BULK_MULTI);
									command.result();
								}
								break;
							default:
								if(command is MONITOR) {
									var event:RedisMonitorDataEvent = new RedisMonitorDataEvent(
										RedisMonitorDataEvent.MONITOR_DATA,
										type + head
									);
									dispatchEvent(event);
								} else {
									throw(new Error("Illegal header type '" + type + "'."));
								}
								break;
						}
						if (!commandProcessed || (command is MONITOR)) {
							// add command back to queue
							activeQueue.splice(0, 0, command);
						}
					} else {
						throw(new Error("No active commands found."));
					}
				} else if (i == 0) {
					throw(new Error("Empty header."));
				}
			}
			// Truncate the buffer, cut off the bytes we processed
			if (buffer.position < buffer.length) {
				var ba:ByteArray = new ByteArray();
				ba.writeBytes(buffer, buffer.position, buffer.length - buffer.position);
				buffer = ba;
			} else {
				// The whole buffer has been processed
				buffer.length = 0;
			}
		}
		
		protected function parseBulk(len:int):ByteArray {
			// Process the bulk data body
			var ba:ByteArray = new ByteArray();
			// Copy [len] bytes
			if (len > 0) {
				buffer.readBytes(ba, 0, len);
				ba.position = 0;
			}
			// The data should be immediately followed by CR/LF
			var idx:int = findCRLF(buffer, buffer.position);
			if (idx >= 0) {
				if (idx > buffer.position) {
					// There's extra data, [len] bytes are not immediately followed by CR/LF
					trace("Warning: skipped " + (idx - buffer.position) + " bytes after bulk data");
				}
				// Skip to after CR/LF (start of next reply)
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
	}
}
