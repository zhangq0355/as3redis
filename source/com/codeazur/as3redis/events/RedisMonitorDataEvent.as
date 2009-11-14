package com.codeazur.as3redis.events
{
	import flash.events.Event;
	
	public class RedisMonitorDataEvent extends Event
	{
		public static const MONITOR_DATA:String = "monitorData";
		
		protected var _command:String;
		
		public function RedisMonitorDataEvent(type:String, command:String, bubbles:Boolean = false, cancelable:Boolean = false)
		{
			super(type, bubbles, cancelable);
			_command = command;
		}
		
		public function get command():String { return _command; }
		
		override public function clone():Event {
			return new RedisMonitorDataEvent(type, command, bubbles, cancelable);
		}
		
		override public function toString():String {
			return "[RedisMonitorDataEvent] " + command;
		}
	}
}