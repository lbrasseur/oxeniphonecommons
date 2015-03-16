# Introduction #

This section contains [common data access components](http://code.google.com/p/oxeniphonecommons/source/browse/trunk/main/Classes/Data).

# Details #

Data access components include:
  * [DAO pattern](http://code.google.com/p/oxeniphonecommons/source/browse/trunk/main/Classes/Data/DAO/) components:
    * [OxICQuerySpec](http://code.google.com/p/oxeniphonecommons/source/browse/trunk/main/Classes/Data/DAO/OxICQuerySpec.h), a class for holding query definitions.
    * [OxICDaoProtocol](http://code.google.com/p/oxeniphonecommons/source/browse/trunk/main/Classes/Data/DAO/OxICDaoProtocol.h), which provides a common interface for basic DAO operations.
    * [OxICBaseDao](http://code.google.com/p/oxeniphonecommons/source/browse/trunk/main/Classes/Data/DAO/OxICBaseDao.m), which provides a basic [OxICDaoProtocol](http://code.google.com/p/oxeniphonecommons/source/browse/trunk/main/Classes/Data/DAO/OxICDaoProtocol.h) implementation using [CoreData](http://en.wikipedia.org/wiki/Core_Data).
    * [OxICDaoProxy](http://code.google.com/p/oxeniphonecommons/source/browse/trunk/main/Classes/Data/DAO/OxICDaoProxy.m), which translates invocations into [OxICDaoProtocol](http://code.google.com/p/oxeniphonecommons/source/browse/trunk/main/Classes/Data/DAO/OxICDaoProtocol.h) find methods.


# OxICDaoProxy samples #
Suppose we have the following protocol:

```
@protocol PersonDao

- (NSArray*) findByName:(NSString*)namePart;
- (Person*) findJohnLennon;

- (id) insertNewObject;
- (void) delete:(id) anObject;
- (void) flush;

@end
```

The proxy allows mapping methods with queries, which will be executed using the findWithQuerySpec:andArguments: method int the [OxICDaoProtocol](http://code.google.com/p/oxeniphonecommons/source/browse/trunk/main/Classes/Data/DAO/OxICDaoProtocol.h)  class.

In the following examples, we'll show how to map the first two (findByName and findJohnLennon). Unmapped methods (insertNewObject, delete:, flush) are directly forwarded to [OxICDaoProtocol](http://code.google.com/p/oxeniphonecommons/source/browse/trunk/main/Classes/Data/DAO/OxICDaoProtocol.h) object.


## Standalone ##
You must initialize the object by passing the [OxICDaoProtocol](http://code.google.com/p/oxeniphonecommons/source/browse/trunk/main/Classes/Data/DAO/OxICDaoProtocol.h) instance to be wrapped (**realPersonDao** in this example) and the protocol to be used in order to access the proxy.

```
OxICDaoProxy *proxy = [[OxICDaoProxy alloc] initWithDao:realPersonDao
                                            andProtocol:@protocol(PersonDao)];

```

Once the proxy is created, you can add query specifications to be binded with selectors:

```
[proxy addSelector:@"findJohnLennon"
     withQuerySpec:[OxICQuerySpec withFilter:@"name = 'John Lennon'"
                                     andUnique:YES]];

[proxy addSelector:@"findByName:"
     withQuerySpec:[OxICQuerySpec withFilter:@"name contains %@"]];
```

## With container ##
The [OxICDaoProxyFactoryObject](http://code.google.com/p/oxeniphonecommons/source/browse/trunk/main/Classes/Data/DAO/OxICDaoProxyFactoryObject.h)  class provides a factory for creating [OxICDaoProxy](http://code.google.com/p/oxeniphonecommons/source/browse/trunk/main/Classes/Data/DAO/OxICDaoProxy.m) instances from the [IoC container](Container.md).

```
[container addDefinition: [OxICObjectDefinition withName: @"personDao"
                                                andClass: @"OxICDaoProxyFactoryObject"
                                             andSingleton: FALSE
                                                  andLazy: FALSE
                                            andReferences: [NSDictionary dictionaryWithObjectsAndKeys:
                                                             @"realPersonDao", @"dao",
                                                             nil
                                                           ]
                                                andValues: [NSDictionary dictionaryWithObjectsAndKeys:
                                                             @protocol(PersonDao), @"protocol",
                                                             [NSDictionary dictionaryWithObjectsAndKeys:
                                                               [OxICQuerySpec withFilter:@"name = 'John Lennon'"
                                                                               andUnique:YES], 
                                                                              @"findJohnLennon",
                                                               [OxICQuerySpec withFilter:@"name contains %@"], 
                                                                              @"findByName:",
                                                               nil], @"querySpecs",
                                                               nil
                                                             ]
                                                           ]
];
```

In this example, the container must have a definition for a [OxICDaoProtocol](http://code.google.com/p/oxeniphonecommons/source/browse/trunk/main/Classes/Data/DAO/OxICDaoProtocol.h)  DAO called **realPersonDao**.