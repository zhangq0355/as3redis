package com.codeazur.as3redis.commands.base
{
	import com.codeazur.as3redis.RedisCommand;
	
	import flash.utils.IDataOutput;
	
	public class SimpleCommand extends RedisCommand
	{
		public function SimpleCommand()
		{
		}
		
		override public function send(stream:IDataOutput):void {
			stream.writeUTFBytes(name + "\r\n");
			super.send(stream);
		}
	}
}