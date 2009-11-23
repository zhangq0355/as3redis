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
			super.send(stream);
			stream.writeUTFBytes(name + "\r\n");
		}
	}
}