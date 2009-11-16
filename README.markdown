# as3redis

## Usage

First you create an instance of the main Redis connector class:

	var redis:Redis = new Redis();

This initializes the connector, but does not connect to the server yet. The default parameters are the local machine and Redis' default port 6379. You might want to pass the hostname and port of your Redis instance in the constructor, in case they are different from the default. Note that it's highly discouraged to connect to a production server (or anything outside your local network really) due to security issues.

### Connecting to a server

You don't need to explicitly connect to the server, as3redis does that for you behing the scenes. You can do that, though, if you need to:

	var redis:Redis = new Redis();
	redis.addEventListener(Event.CONNECT, connectHandler);
	redis.connect();

### Authentification

Redis allows for simple authentification through the AUTH command. If you set up your Redis instance to require a password, just set the password property before the server connects:

	var redis:Redis = new Redis();
	redis.password = "joshua";

Now redis will transparently authenticate right after it connects.

### Sending commands

It is almost trivial to send commands to your Redis instance, using the sendXXX() methods:

	var redis:Redis = new Redis();
	redis.password = "joshua";
	redis.sendINFO();
	redis.sendPING();
	redis.sendECHO("Hello World");
	redis.sendSET("key", "value");
	redis.sendGET("key");

This will auto-connect to your Redis instance, authenticate the client with the provided password and bulk-send the commands INFO, PING, ECHO, SET and GET.

### Receiving responses

In Flash, pretty much all native networking APIs are asynchronous, and so is as3redis. You can bulk-send commands to Redis, and as3swf always keeps the commands in sync with the received responses.

To get notified by as3redis when a response was received for a specific command, add one or more responders to the command. The simplest example:

	var redis:Redis = new Redis();
	redis.sendINFO().addSimpleResponder(
		function(cmd:INFO):void {
			trace(cmd);
		}
	);

You can (and should) also catch error responses:

	var redis:Redis = new Redis();
	redis.sendINFO().addSimpleResponder(
		function(cmd:INFO):void {
			trace("OK!", cmd);
		},
		function(cmd:INFO):void {
			trace("ERROR!", cmd);
		}
	);

Or use one responder for all commands:

	var redis:Redis = new Redis();
	var responder:RedisResponder = new RedisResponder(success, fault);
	
	redis.sendSETNX("key", "value").addResponder(responder);
	redis.sendGET("key").addResponder(responder);
	
	function success(cmd:RedisCommand):void {
		trace("OK!", cmd);
	}
	function fault(cmd:RedisCommand):void {
		trace("ERROR!", cmd);
	}

