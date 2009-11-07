package com.codeazur.as3redis
{
	public class RedisResponder
	{
		public var result:Function;
		public var status:Function;
		
		public function RedisResponder(result:Function, status:Function = null)
		{
			this.result = result;
			this.status = status;
		}
		
	}

}