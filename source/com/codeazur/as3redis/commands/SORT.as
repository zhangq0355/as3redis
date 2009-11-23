package com.codeazur.as3redis.commands
{
	import com.codeazur.as3redis.RedisCommand;
	
	import flash.utils.IDataOutput;
	
	public class SORT extends RedisCommand
	{
		protected var _key:String;
		protected var _limitMin:int;
		protected var _limitMax:int;
		protected var _desc:Boolean;
		protected var _alpha:Boolean;
		protected var _byPattern:String;
		protected var _getPatterns:Array;
		
		public function SORT(key:String, limitMin:int = -1, limitMax:int = -1, desc:Boolean = false, alpha:Boolean = false, byPattern:String = null, getPatterns:Array = null)
		{
			_key = key;
			_limitMin = limitMin;
			_limitMax = limitMax;
			_desc = desc;
			_alpha = alpha;
			_byPattern = byPattern;
			_getPatterns = getPatterns;
		}
		
		override public function get name():String {
			return "SORT";
		}
		
		override public function send(stream:IDataOutput):void {
			stream.writeUTFBytes(name + " " + _key);
			if(_limitMin >= 0 && _limitMax >= 0) {
				stream.writeUTFBytes(" LIMIT " + _limitMin + " " + _limitMax);
			} else if(!(_limitMin < 0 && _limitMax < 0)) {
				_limitMin = Math.max(0, _limitMin);
				_limitMax = Math.max(0, _limitMax);
				if(_limitMin < _limitMax) {
					stream.writeUTFBytes(" LIMIT " + _limitMin + " " + _limitMax);
				} else if(_limitMin > _limitMax) {
					stream.writeUTFBytes(" LIMIT " + _limitMax + " " + _limitMin);
				}
			}
			if(_desc) {
				stream.writeUTFBytes(" DESC");
			}
			if(_alpha) {
				stream.writeUTFBytes(" ALPHA");
			}
			if(_byPattern != null) {
				stream.writeUTFBytes(" BY " + _byPattern);
			}
			if(_getPatterns != null && _getPatterns.length > 0) {
				stream.writeUTFBytes(" GET " + _getPatterns.join(" GET "));
			}
			stream.writeUTFBytes("\r\n");
		}
		
		override public function toStringCommand():String {
			var s:String = name + " " + _key;
			if(_limitMin >= 0 && _limitMax >= 0) {
				s += " LIMIT " + _limitMin + " " + _limitMax;
			} else if(!(_limitMin < 0 && _limitMax < 0)) {
				_limitMin = Math.max(0, _limitMin);
				_limitMax = Math.max(0, _limitMax);
				if(_limitMin < _limitMax) {
					s += " LIMIT " + _limitMin + " " + _limitMax;
				} else if(_limitMin > _limitMax) {
					s += " LIMIT " + _limitMax + " " + _limitMin;
				}
			}
			if(_desc) {
				s += " DESC";
			}
			if(_alpha) {
				s += " ALPHA";
			}
			if(_byPattern != null) {
				s += " BY " + _byPattern;
			}
			if(_getPatterns != null && _getPatterns.length > 0) {
				s += " GET " + _getPatterns.join(" GET ");
			}
			return "[" + s + "]";
		}
	}
}
