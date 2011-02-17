//
//  ServiceExecutorImpl2.m
//  Otra
//
//  Created by Facundo Fumaneri on 12/27/10.
//  Copyright 2010 Oxen. All rights reserved.
//

#import "ServiceExecutorImpl2.h"
#import "OxICContainer.h"

@implementation ServiceExecutorImpl2
@synthesize service;

//Inject theService object to service property
IoCInject(service, theService)

- (void) executeService {
	[service execute];
}
@end
