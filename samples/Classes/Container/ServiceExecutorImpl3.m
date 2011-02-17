//
//  ServiceExecutorImpl3.m
//  OxenIoc
//
//  Created by Facundo Fumaneri on 1/19/11.
//  Copyright 2011 Oxen. All rights reserved.
//

#import "ServiceExecutorImpl3.h"
#import "OxICContainer.h"

@implementation ServiceExecutorImpl3
@synthesize service;

IoCName(ServiceExecutor3)
IoCLazy
IoCSingleton

//Inject theService object to service property
IoCInject(service, theService)

- (void) executeService {
	[service execute];
}
@end
