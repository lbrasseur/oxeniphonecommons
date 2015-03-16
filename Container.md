# IoC Container description #

The IoC container provides dependency injection to Cocoa applications. It was created with iPhone development in mind.

It aims to provide some functionalities from [Spring](http://www.springsource.org/) and from [Guice](http://code.google.com/p/google-guice/) (in fact, we're somehow inspired by [RoboGuice](http://code.google.com/p/roboguice/)). But due to the complexity inherent to implementing a full IoC container (as the ones mentioned before), we restricted it to very basic features.

## The basics ##
The container has the following characteristics:

  * The container holds definitions about objects. No object is created until somebody request it.

  * Every definition must have a name that must be unique inside the container in order to identify the object.

  * The definition can indicate that the object must be singleton (it is created and stored in a pool when the object is requested the first time). If singleton is specified as FALSE, the object will be created each time (but it can be released when no longer required). This is similar to prototype scope in [Spring](http://www.springsource.org/) , an as we learned from using [RoboGuice](http://code.google.com/p/roboguice/), this behavior would be preferible in many mobile development scenarios.

  * The definition can indicate that the object must be lazy. That is, when the object is requested, a proxy to such object is returned. Upon the first method call on such reference, the object is created. This is useful for avoiding creating big object graphs unnecessarily.

  * The object can be injected (this is the main goal of the framework!). It must have properties or at least setters for performing the injection. The definition allows performing the following injections:
    * References to other definitions (by name).
    * Values

  * New factories can be implemented for object creation customization.

  * Container instantiation can be done by code and "annotations" (like [Guice](http://code.google.com/p/google-guice/)/[Spring](http://www.springsource.org/)) or by XML (like [Spring](http://www.springsource.org/)).

# A simple example #
The main class is [OxICContainer](http://code.google.com/p/oxeniphonecommons/source/browse/trunk/main/Classes/Container/OxICContainer.m), which represents (I feel you guessed it) the container. It depends on [OxICWrapperFactory](http://code.google.com/p/oxeniphonecommons/source/browse/trunk/main/Classes/Wrapper/API/OxICWrapperFactory.h) in order to handle classes and objects dynamically. So, instantiating it is pretty simple:
```
id<OxICWrapperFactory> wrapperFactory = [[OxICSimpleWrapperFactory alloc] init];
OxICContainer *newContainer = [[OxICContainer alloc] initWithWrapperFactory:wrapperFactory];
[wrapperFactory release];
```

The definitions are represented by [OxICObjectDefinition](http://code.google.com/p/oxeniphonecommons/source/browse/trunk/main/Classes/Container/OxICObjectDefinition.m) class. A static method allows an easy definition creation:
```
[newContainer addDefinition: [OxICObjectDefinition withName: @"mainView"
                                                   andClass: @"MyView"
                                               andSingleton: FALSE
                                                    andLazy: FALSE
                                              andReferences: [NSDictionary dictionaryWithObjectsAndKeys:
                                                              @"mainViewController", @"owner",
                                                              nil]
                                                  andValues: [NSDictionary dictionaryWithObjectsAndKeys:
                                                              @"This is my view", @"text",
                                                              nil]]
];
```

Also, classes can be "annotated" with definition metadata. In this scenario, definitions can be added using the following method:
```
[newContainer addDefinitionFromClassName:@"MyViewController"];
```

Since Objective C doesn't provide an annotation facility (like C# or Java), we used compiler directives in order to simulate them:
```
@implementation MyViewController
@synthesize myServiceProperty;

IoCName(mainViewController)
IoCSingleton
IoCInject(myServiceProperty,serviceNameInContainer)
IoCLazy
...
```

Note that the directives creates methods with special signatures, which are inspected by the container. Because of this, such directives must be included inside the implementation body.

On the other hand, the container can be created using XML
```
<contanier>
	<object id="theService" class="ExampleServiceImpl2" lazy="false"/>
	<object id="theExecutor" class="ServiceExecutorImpl1">
		<property name="service" ref="theService"/>
	</object>
</contanier>
```

but the implementation is not currently complete. The [OxICXmlContainerBuilder](http://code.google.com/p/oxeniphonecommons/source/browse/trunk/main/Classes/Container/OxICXmlContainerBuilder.m) class must be used in order to create a container by parsing an XML.

Finally, when you need an object from the container, just get it with the getObject method. For example:
```
[window addSubview: [newContainer getObject:@"mainView"]];
```


For a more complete example, please download the source code and open the [sample project](http://code.google.com/p/oxeniphonecommons/source/browse/trunk/samples/)

# Advanced topics #

## Custom factories ##
Object construction can be customized implementing the [OxICFactoryObject](http://code.google.com/p/oxeniphonecommons/source/browse/trunk/main/Classes/Container/OxICFactoryObject.h). You must just implement this protocol and specify the implementing class name in the definition as object class. The container will detect that it is a factory and will inject. After that, it will call the getObject method. This approach is borrowed from Spring [FactoryBean](http://static.springsource.org/spring/docs/2.5.x/api/org/springframework/beans/factory/FactoryBean.html) and Guice [Provider](http://code.google.com/p/google-guice/wiki/ProviderBindings).

Besides, the container provides some common use factories:

  * [OxICDefaultFactoryObject](http://code.google.com/p/oxeniphonecommons/source/browse/trunk/main/Classes/Container/OxICDefaultFactoryObject.m): This factory is used when no factory is specified. It just creates the object and injects it using the container.

  * [OxICManagedObjectModelFactoryObject](http://code.google.com/p/oxeniphonecommons/source/browse/trunk/main/Classes/Container/OxICManagedObjectModelFactoryObject.m): Creates a [Core Data](http://en.wikipedia.org/wiki/Core_Data) [NSManagedObjectModel](http://developer.apple.com/library/mac/#documentation/Cocoa/Reference/CoreDataFramework/Classes/NSManagedObjectModel_Class/Reference/Reference.html) object, merging all the definitions present in the bundle.

  * [OxICPersistentStoreCoordinatorFactoryObject](http://code.google.com/p/oxeniphonecommons/source/browse/trunk/main/Classes/Container/OxICPersistentStoreCoordinatorFactoryObject.m): Creates a [Core Data](http://en.wikipedia.org/wiki/Core_Data) [NSPersistentStoreCoordinator](http://developer.apple.com/library/mac/#documentation/Cocoa/Reference/CoreDataFramework/Classes/NSPersistentStoreCoordinator_Class/NSPersistentStoreCoordinator.html). The store URL and the managed object model must be injected.

  * [OxICLazyProxyFactoryObject](http://code.google.com/p/oxeniphonecommons/source/browse/trunk/main/Classes/Container/OxICLazyProxyFactoryObject.m): Creates a [lazy object](http://code.google.com/p/oxeniphonecommons/source/browse/trunk/main/Classes/Container/OxICLazyProxy.m), which is instantiates the wrapped object on demand. See **Lazy objects** section.

  * [OxICThreadLocalProxyFactoryObject](http://code.google.com/p/oxeniphonecommons/source/browse/trunk/main/Classes/Container/OxICThreadLocalProxyFactoryObject.m): Creates a [OxICThreadLocalProxy](http://code.google.com/p/oxeniphonecommons/source/browse/trunk/main/Classes/Container/OxICThreadLocalProxy.m), which redirects request to a thread-bound object. This is useful, for example, in order to have many Managed Object Contexts (Core Data) and using them concurrently.

Also, if the property being injected has an `id<OxICFactoryObject>` type, the container will inject automatically the corresponding factory for the injected object. This behavior is inspired in [Guice Provider Injection](http://code.google.com/p/google-guice/wiki/InjectingProviders) (Spring approach is not automatic, it requires prefixing the bean name with &).

## Lazy objects ##
When you request an object for whose the definitions is marked as lazy, an instance of [OxICLazyProxy](http://code.google.com/p/oxeniphonecommons/source/browse/trunk/main/Classes/Container/OxICLazyProxy.m) is returned. This is a subclass of [NSProxy](http://developer.apple.com/library/mac/#documentation/cocoa/reference/foundation/Classes/NSProxy_Class/Reference/Reference.html) which holds a reference to the [OxICFactoryObject](http://code.google.com/p/oxeniphonecommons/source/browse/trunk/main/Classes/Container/OxICFactoryObject.h) that instantiates the object upon the first method call.

A longer way to define lazy object is using the [OxICLazyProxyFactoryObject](http://code.google.com/p/oxeniphonecommons/source/browse/trunk/main/Classes/Container/OxICLazyProxyFactoryObject.m) class. But since lazy loading is a really common scenario (injecting view controllers, for example) we prefer providing a "shortcut" in the object definition.

# Advanced examples #
## Core Data ##
```
- (OxICContainer *) buildContainer {
  id<OxICWrapperFactory> wrapperFactory = [[OxICSimpleWrapperFactory alloc] init];
  OxICContainer *newContainer = [[OxICContainer alloc] initWithWrapperFactory:wrapperFactory];
  [wrapperFactory release];
	
  [newContainer addDefinition: [OxICObjectDefinition withName: @"managedObjectModel"
                                                     andClass: @"OxICManagedObjectModelFactoryObject"
                                                 andSingleton: TRUE
                                                      andLazy: FALSE
                                                andReferences: nil
                                                    andValues: nil]
  ];
	
  NSURL* storeUrl = [NSURL fileURLWithPath:[[self applicationDocumentsDirectory]
                                              stringByAppendingPathComponent: @"myDb.sqlite"]];
	
  [newContainer addDefinition: [OxICObjectDefinition withName: @"persistentStoreCoordinator"
                                                     andClass: @"OxICPersistentStoreCoordinatorFactoryObject"
                                                 andSingleton: TRUE
                                                      andLazy: FALSE
                                                andReferences: [NSDictionary dictionaryWithObjectsAndKeys:
                                                                @"managedObjectModel", @"managedObjectModel",
                                                                nil]
                                                    andValues: [NSDictionary dictionaryWithObjectsAndKeys:
                                                                storeUrl, @"storeUrl",
                                                                nil]]
   ];

  [newContainer addDefinition: [OxICObjectDefinition withName: @"managedObjectContext"
                                                     andClass: @"NSManagedObjectContext"
                                                 andSingleton: TRUE
                                                      andLazy: FALSE
                                                andReferences: [NSDictionary dictionaryWithObjectsAndKeys:
                                                                @"persistentStoreCoordinator", @"persistentStoreCoordinator",
                                                                nil]
                                                    andValues: nil]
   ];
	
  return [newContainer autorelease];
}

- (NSString *)applicationDocumentsDirectory {
   return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
}
```

# The failed view / view controller decoupling experiment #
One of the ideas when building this container was decoupling the view controller from the view. Our first try was creating a factory for NIBs:

  * [OxICNibFactoryObject](http://code.google.com/p/oxeniphonecommons/source/browse/trunk/main/Classes/Container/OxICNibFactoryObject.m): this class creates a [UIView](http://developer.apple.com/library/ios/#documentation/uikit/reference/UIView_Class/UIView/UIView.html) from a NIB. The NIB name and the owner (typically the view controller) must be specified. The NIB is readed from the bundle.

We even wrote an example for that:

```
id<OxICWrapperFactory> wrapperFactory = [[OxICSimpleWrapperFactory alloc] init];
OxICContainer *newContainer = [[OxICContainer alloc] initWithWrapperFactory:wrapperFactory];
[wrapperFactory release];
	
[newContainer addDefinition: [OxICObjectDefinition withName: @"mainView"
                                                   andClass: @"OxICNibFactoryObject"
                                               andSingleton: FALSE
                                                    andLazy: FALSE
                                              andReferences: [NSDictionary dictionaryWithObjectsAndKeys:
                                                              @"mainViewController", @"owner",
                                                              nil]
                                                  andValues: [NSDictionary dictionaryWithObjectsAndKeys:
                                                              @"MyViewController", @"name",
                                                              nil]]
 ];
	
[newContainer addDefinitionFromClassName:@"MyViewController"];

```

but that didn't work. Why? Because creating the view and passing the controller as owner is not enough. So, according to [UIViewController](http://developer.apple.com/library/ios/#documentation/uikit/reference/UIViewController_Class/Reference/Reference.html) reference documentation:

". . . There are two mutually exclusive ways to specify these views: manually or using a nib file. If you specify the views manually, you must implement the loadView method and use it to assign a root view object to the view property. If you specify views using a nib file, you must not override loadView but should instead create a nib file in Interface Builder and then initialize your view controller object using the initWithNibName:bundle: method. . ."

The following methods are called in sequence:

  * initWithNibName:bundle:

  * loadView

  * viewDidLoad

If you don't override the loadView method and don't pass a NIB name (just like happens with the container, because it uses the empty init method), the UIViewController will try loading a NIB with the same name of the controller. But if you override loadView and do nothing, viewDidLoad is not triggered. In other words, the iPhone view creation is very rigid. It must be done inside view controller creation.

We tried a second option: creating a custom factory for creating view controllers using the initWithNibName:bundle: method ([OxICViewControllerFactoryObject](http://code.google.com/p/oxeniphonecommons/source/browse/trunk/main/Classes/Container/OxICViewControllerFactoryObject.m)), but there was other problem: the created view controller wasn't injected, because the object definition was used in order to inject the factory itself.

So, a solution could be creating a way to specify separated definitions for factory and for the object. Another option would be adding support for specifying the init method to use and its parameter. Both of them would be against our goal of keeping the container simple. We though in adding a custom "annotation" for the NIB name, but it would be almost the same thing that overriding the init method and passing the NIB name hardcode.

So, until we got a new idea (or somebody provides us a new one), use the following rules:

  * If the view is in a NIB with the same name, just create the view controller using a simple object declaration in the container.

  * If the view must be created by code, do the same as the previous point but override the loadView method

  * If the view is in a NIB with a different name, just override the init method and call the initWithNibName:bundle: method with the desired NIB name.