# Introduction #
This section contains information about components for handling HTTP session.

# HTTP Session #
Sometime, applications need maintaining server-side state. When this scenario arises, typically, a server side session is created.

For this purpose, the [OxICHttpSessionManager](http://code.google.com/p/oxeniphonecommons/source/browse/trunk/main/Classes/Session/API/OxICHttpSessionManager.h) protocol provides a pluggable HTTP session handler mechanism.

# Implementations #
## Java Servlet Session ##
The [OxICServletSessionManager](http://code.google.com/p/oxeniphonecommons/source/browse/trunk/main/Classes/Session/Servlet/OxICServletSessionManager.m)  provides an standard [Java Servlet](http://es.wikipedia.org/wiki/Java_Servlet) HTTP session implementation. It reads ans sets the JSESSIONID cookie.

However, since this class stores the session id into a property, **it must be instantiated as singleton**. Inside  the  [container](Container.md), it could be declared as follows:

```
[self.container addDefinition: [OxICObjectDefinition withName: @"httpSessionManager"
                                                     andClass: @"OxICServletSessionManager"
                                                 andSingleton: YES
                                                      andLazy: NO
                                                andReferences: nil
                                                    andValues: nil]
];
```

# Clients #
  * The [JSON components](JsonComponents.md) (both RPC and REST) can receive a [OxICHttpSessionManager](http://code.google.com/p/oxeniphonecommons/source/browse/trunk/main/Classes/Session/API/OxICHttpSessionManager.h)  in order to keep tracking of the session.