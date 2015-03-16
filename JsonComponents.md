# Introduction #

This section contains utility [JSON components](http://code.google.com/p/oxeniphonecommons/source/browse/trunk/main/Classes/JSON/).


# JSON RPC Proxy #

The [OxICJsonRpcProxy](http://code.google.com/p/oxeniphonecommons/source/browse/trunk/main/Classes/JSON/OxICJsonRpcProxy.m) class provides a proxy for transparently accessing HTTP based JSON services. It uses the message format defined by [JSON RPC](http://json-rpc.org/) (well, in fact, we just used [jsonrpc4j](http://code.google.com/p/jsonrpc4j/) in order to test it - the component development is stil in progress).

The proxy intercepts the messages, puts the selector name as method name, converts the selector arguments into JSON and sends it over HTTP. When it receives the response, it converts the JSON response into the proper Objective C equivalent object.

The selector name sent to the server is modified in order to make it Java-friendly. Colons are removed and character after colons are capitalized. For example, if the selector name is sayHi:withMessage:, it will be translated into sayHiWithMessage(String, String) method.

In order to perform JSON conversion, the proxy uses the (fast and simple!) [JSONKit](https://github.com/johnezang/JSONKit) parser. JSONKit, like most Objective C based JSON parsers, marshals/unmarshals data from/to [NSDictionary](http://developer.apple.com/library/mac/#documentation/cocoa/reference/foundation/classes/nsdictionary_class/Reference/Reference.html) instances. Because of this, we developed some [dictionary components](DictionaryComponents.md). The JSON RPC proxy copies arguments into a NSDictionary before sending them using the [OxICDictionaryConverter](http://code.google.com/p/oxeniphonecommons/source/browse/trunk/main/Classes/Dictionary/OxICDictionaryConverter.m) class. In a similar way, responses containing dictionaries are wrapped into a proxy using [OxICDictionaryProxy](http://code.google.com/p/oxeniphonecommons/source/browse/trunk/main/Classes/Dictionary/OxICDictionaryProxy.m).

The proxy has two boolean properties:
  * capitalizeMethods: Converts first letter in method names to uppercase.
  * capitalizeFields: Converts  first letter in field names to uppercase (in fact, it sets the same property in NSDictionary proxies/adapters)
These properties can be helpful if your service uses Pascal case convention (for example, .NET conventions).



## Using the proxy ##
### Standalone ###
You must provide the protocol to be proxied, the URL used to make HTTP post, and a [wrapper factory](Wrapper.md). You provide them using the following init method:

```
- (id) initWithProtocol: (Protocol*) aProtocol
                 andURL: (NSString*) aURL
      andWrapperFactory:(id<OxICWrapperFactory>) aWrapperFactory;
```

NOTE: Protocol is currently used just for creating a proper [NSMethodSignature](http://developer.apple.com/library/mac/#documentation/Cocoa/Reference/Foundation/Classes/NSMethodSignature_Class/Reference/Reference.html).

### With the IoC container ###
You can instantiate a JSON RPC proxy from the [IoC container](Container.md) using the [OxICJsonRpcProxyFactoryObject](http://code.google.com/p/oxeniphonecommons/source/browse/trunk/main/Classes/JSON/OxICJsonRpcProxyFactoryObject.m) class. Just add a definition simliar to the following one:

```
[newContainer addDefinition: [OxICObjectDefinition withName: @"authenticationService"
                                                   andClass: @"OxICJsonRpcProxyFactoryObject"
                                               andSingleton: NO
                                                    andLazy: NO
                                              andReferences: nil
                                                  andValues: [NSDictionary dictionaryWithObjectsAndKeys:
                                                               @"http://multivac.com/authentication", @"url",
                                                               @protocol(AuthenticationService), @"protocol",
                                                               wrapperFactory, @"wrapperFactory",
                                                             nil]]
];

```

Capitalization properties are available in the factory too.

# JSON REST Proxy #
The [OxICJsonRestProxy](http://code.google.com/p/oxeniphonecommons/source/browse/trunk/main/Classes/JSON/OxICJsonRestProxy.m) works in a similar way, but it uses a REST-like approach.

The invoked method is appended to the URL (with a slash). The argument is sent as pure JSON. Likewise, the response is treated as pure JSON too.

Currently, this proxy supports methods with only one argument, so you will need to build DTOs in most cases.

The proxy has two boolean properties (just like the RCP proxy):
  * capitalizeMethods: Converts first letter in method names to uppercase.
  * capitalizeFields: Converts  first letter in field names to uppercase (in fact, it sets the same property in NSDictionary proxies/adapters)
These properties can be helpful if your service uses Pascal case convention (for example, .NET conventions).


## Using the proxy ##
### Standalone ###
You must provide the protocol to be proxied, the URL used to make HTTP post, and a [wrapper factory](Wrapper.md). You provide them using the following init method:

```
- (id) initWithProtocol: (Protocol*) aProtocol
                 andURL: (NSString*) aURL
      andWrapperFactory:(id<OxICWrapperFactory>) aWrapperFactory;
```

NOTE: Protocol is currently used just for creating a proper [NSMethodSignature](http://developer.apple.com/library/mac/#documentation/Cocoa/Reference/Foundation/Classes/NSMethodSignature_Class/Reference/Reference.html).

### With the IoC container ###
You can instantiate a JSON REST proxy from the [IoC container](Container.md) using the [OxICJsonRestProxyFactoryObject](http://code.google.com/p/oxeniphonecommons/source/browse/trunk/main/Classes/JSON/OxICJsonRestProxyFactoryObject.m) class. Just add a definition simliar to the following one:

```
[newContainer addDefinition: [OxICObjectDefinition withName: @"authenticationService"
                                                   andClass: @"OxICJsonRestProxyFactoryObject"
                                               andSingleton: NO
                                                    andLazy: NO
                                              andReferences: nil
                                                  andValues: [NSDictionary dictionaryWithObjectsAndKeys:
                                                               @"http://multivac.com/authentication", @"url",
                                                               @protocol(AuthenticationService), @"protocol",
                                                               wrapperFactory, @"wrapperFactory",
                                                             nil]]
];

```

Capitalization properties are available in the factory too.

# Server-side session #
All the remote service proxies support [server-side session handling](HttpSessionComponents.md) by injecting a [OxICServletSessionManager](http://code.google.com/p/oxeniphonecommons/source/browse/trunk/main/Classes/Session/Servlet/OxICServletSessionManager.m) instance. For example:

```
[self.container addDefinition: [OxICObjectDefinition withName: serviceName
                                                     andClass: @"OxICJsonRpcProxyFactoryObject"
                                                 andSingleton: NO
                                                      andLazy: NO
                                                andReferences: [NSDictionary dictionaryWithObjectsAndKeys:
                                                                @"httpSessionManager", @"httpSessionManager",
                                                                nil]
                                                    andValues: [NSDictionary dictionaryWithObjectsAndKeys:
                                                                url, @"url",
                                                                protocol, @"protocol",
                                                                wrapperFactory, @"wrapperFactory",
                                                                nil]
                                ]
 ];
```