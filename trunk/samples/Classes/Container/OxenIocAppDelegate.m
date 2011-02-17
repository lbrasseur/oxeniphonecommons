//
//  OxenIocAppDelegate.m
//  OxenIoc
//
//  Created by Facundo Fumaneri on 12/28/10.
//  Copyright Oxen 2010. All rights reserved.
//

#import "OxenIocAppDelegate.h"
#import "OxenIocViewController.h"
#import "OxICXmlContainerBuilder.h"
#import "ServiceExecutor.h"
#import "OxICSimpleWrapperFactory.h"

@implementation OxenIocAppDelegate

@synthesize window;
@synthesize viewController;


- (void)applicationDidFinishLaunching:(UIApplication *)application {    
    
	/*************************************************/
	// check console log for results
	
	[self buildContainerFromXml];
    // Override point for customization after app launch    
    [window addSubview:viewController.view];
    [window makeKeyAndVisible];
	
}
- (void) buildContainerFromXml {
	
	
	NSString *path =[[NSBundle mainBundle] pathForResource:@"context" ofType:@"xml"]; 
	
	OxICXmlContainerBuilder *builder = [[OxICXmlContainerBuilder alloc] init];

	//this method call containerBuildingFinished method if it is ok
	id<OxICWrapperFactory> wrapperFactory = [[OxICSimpleWrapperFactory alloc] init];
	[builder buildContainer:[NSURL fileURLWithPath:path] withDelegate:self andWrapperFactory: wrapperFactory];
	[wrapperFactory release];
	[builder release];
}

- (void) containerBuildingFinished:(OxICContainer*) containerFromXml {
	OxICContainer *containerFromCode = [self buildContainerFromCode];
	OxICContainer *containerFromCodeAutoInject = [self buildContainerFromCodeAutoInject];
	
	// Now we have 3 containers
	
	//call to factory.
	// theExecutor: ServiceExecutorImpl1
	// theService: ExampleServiceImpl1
	id<ServiceExecutor> executorFromCode = [containerFromCode getObject:@"theExecutor"];
	
	//call to factory
	// theExecutor: ServiceExecutorImpl1
	// theService: ExampleServiceImpl2
	id<ServiceExecutor> executorFromXml = [containerFromXml getObject:@"theExecutor"];
	
	//call to factory
	// theExecutor: ServiceExecutorImpl2
	// theService: ExampleServiceImpl1
	id<ServiceExecutor> executorFromCodeAutoinject = [containerFromCodeAutoInject getObject:@"theExecutor"];

	id<ServiceExecutor> executor3FromCodeAutoinject = [containerFromCodeAutoInject getObject:@"ServiceExecutor3"];

	// this executor has an ExampleServiceImpl1 in service property.
	[executorFromCode executeService];
	
	// this executor has an ExampleServiceImpl2 in service property. Read context.xml.
	[executorFromXml executeService];
	
	// this executor has an ExampleServiceImpl1 in service property.
	[executorFromCodeAutoinject executeService];

	// this executor has an ExampleServiceImpl1 in service property.
	[executor3FromCodeAutoinject executeService];
	
}

- (void) containerBuildingError {
	NSLog(@":(");
}

- (OxICContainer *) buildContainerFromCode {
	OxICContainer *container = [[OxICContainer alloc] init];
	
	OxICObjectDefinition *serviceDefinition = [[OxICObjectDefinition alloc] init];
	serviceDefinition.name = @"theService";
	serviceDefinition.className = @"ExampleServiceImpl1";
	serviceDefinition.lazy = NO;
	[container addDefinition:serviceDefinition];
	[serviceDefinition release];
	
	OxICObjectDefinition *serviceExecutorDef = [[OxICObjectDefinition alloc] init];
	serviceExecutorDef.name = @"theExecutor";
	serviceExecutorDef.className = @"ServiceExecutorImpl1";
	
	// inject theService to serviceExecutor
	[serviceExecutorDef addPropertyReference:@"service" toObjectName:@"theService"];
	
	[container addDefinition:serviceExecutorDef];
	[serviceExecutorDef release];
	
	return [container autorelease];
}

- (OxICContainer *) buildContainerFromCodeAutoInject {
	OxICContainer *container = [[OxICContainer alloc] init];
	
	OxICObjectDefinition *serviceDefinition = [[OxICObjectDefinition alloc] init];
	serviceDefinition.name = @"theService";
	serviceDefinition.className = @"ExampleServiceImpl1";
	serviceDefinition.lazy = YES;
	[container addDefinition:serviceDefinition];
	[serviceDefinition release];
	
	OxICObjectDefinition *serviceExecutorDef = [[OxICObjectDefinition alloc] init];
	serviceExecutorDef.name = @"theExecutor";
	serviceExecutorDef.className = @"ServiceExecutorImpl2";
	[container addDefinition:serviceExecutorDef];
	[serviceExecutorDef release];
	
	[container addDefinitionFromClassName:@"ServiceExecutorImpl3"];
	
	return [container autorelease];
}


- (void)dealloc {
    [viewController release];
    [window release];
    [super dealloc];
}


@end
