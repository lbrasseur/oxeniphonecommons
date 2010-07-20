//
//  ContainerSampleViewController.m
//  OxeniPhoneCommonsSamples
//
//  Created by Lautaro Brasseur on 19/07/10.
//  Copyright 2010 Oxen Software Studio. All rights reserved.
//

#import "ContainerSampleViewController.h"
#import "OxICSimpleObjectWrapper.h"
#import "OxICContainer.h"
#import "OxICObjectDefinition.h"
#import "OxICXmlContainerBuilder.h"
#import "OxICSimpleWrapperFactory.h"

@implementation ContainerSampleViewController

- (IBAction) generarContainer: (BOOL) lazyMode {
	id<OxICWrapperFactory> wrapperFactory = [[OxICSimpleWrapperFactory alloc] init];
	OxICContainer *container = [[OxICContainer alloc] initWithWrapperFactory:wrapperFactory];
	[wrapperFactory release];
	
	OxICObjectDefinition *serviceDefinition = [[OxICObjectDefinition alloc] init];
	serviceDefinition.name = @"serviceName";
	serviceDefinition.className = @"AServiceImpl";
	serviceDefinition.lazy = lazyMode;
	[container addDefinition:serviceDefinition];
	[serviceDefinition release];
	
	OxICObjectDefinition *vistaDefinition = [[OxICObjectDefinition alloc] init];
	vistaDefinition.name = @"viewName";
	vistaDefinition.className = @"AViewController";
	[vistaDefinition addPropertyReference:@"service" toObjectName:@"serviceName"];
	[container addDefinition:vistaDefinition];
	[vistaDefinition release];
	
	[self presentModalViewController:[container getObject:@"viewName"] animated:YES];
	
	[container release];
	
}

- (IBAction) withoutLazy: (id) sender {
	[self generarContainer:NO];
}

- (IBAction) withLazy: (id) sender {
	[self generarContainer:YES];
}

- (IBAction) withXmlContext: (id) sender {
	NSString *path =[[NSBundle mainBundle] pathForResource:@"context" ofType:@"xml"]; 
	
	OxICXmlContainerBuilder *builder = [[OxICXmlContainerBuilder alloc] init];
	id<OxICWrapperFactory> wrapperFactory = [[OxICSimpleWrapperFactory alloc] init];
	[builder buildContainer:[NSURL fileURLWithPath:path] withDelegate:self andWrapperFactory:wrapperFactory];
	[builder release];
	[wrapperFactory release];
}

- (void) containerBuildingFinished:(OxICContainer*) container {
	[self presentModalViewController:[container getObject:@"viewName"] animated:YES];
}

- (void) containerBuildingError {
	NSLog(@":(");
}

@end
