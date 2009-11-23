package com.codeazur.as3redis.commands
{
	import com.codeazur.as3redis.RedisCommand;
	
	import flash.utils.IDataOutput;
	
	public class SLAVEOF extends RedisCommand
	{
		protected var _host:String;
		protected var _port:int;
		
		public function SLAVEOF(host:String = null, port:int = -1)
		{
			_host = host;
			_port = port;
		}
		
		override public function get name():String {
			return "SLAVEOF";
		}
		
		override public function send(stream:IDataOutput):void {
			if (_host != null && _host.length > 0 && _port >= 0) {
				stream.writeUTFBytes(name + " " + _host + " " + _port + "\r\n");
			} else if (_host == null && _port < 0) {
				stream.writeUTFBytes(name + " no one\r\n");
			} else {
				throw(new Error("Host and port must both either be valid or null/-1"));
			}
			super.send(stream);
		}
		
		override public function toStringCommand():String {
			if (_host != null && _host.length > 0 && _port >= 0) {
				return "[" + name + " " + _host + " " + _port + "]";
			} else if (_host == null && _port < 0) {
				return "[" + name + " no one]";
			} else {
				return "[" + name + "] INVALID ARGUMENTS";
			}
		}
	}
}