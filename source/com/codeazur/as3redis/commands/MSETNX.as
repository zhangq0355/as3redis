package com.codeazur.as3redis.commands
{
	public class MSETNX extends MSET
	{
		public function MSETNX(keys:Array, values:Array)
		{
			super(keys, values);
		}
		
		override public function get name():String {
			return "MSETNX";
		}
	}
}