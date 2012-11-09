//
//  ServiceExecutor.m
//  Otra
//
//  Created by Facundo Fumaneri on 12/27/10.
//  Copyright 2010 Oxen. All rights reserved.
//

#import "ServiceExecutorImpl1.h"


@implementation ServiceExecutorImpl1
@synthesize service;
- (void) executeService {
	[service execute];
}

@end
