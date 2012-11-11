//
//  OxICBaseJsonProxyFactoryObject.m
//  OxeniPhoneCommons
//
//  Created by Lautaro Brasseur on 25/10/11.
//  Copyright 2011 Oxen Software Studio. All rights reserved.
//

#import "OxICBaseJsonProxyFactoryObject.h"
#import "OxICBaseJsonProxy.h"

@implementation OxICBaseJsonProxyFactoryObject
@synthesize protocol;
@synthesize url;
@synthesize wrapperFactory;
@synthesize capitalizeMethods;
@synthesize capitalizeFields;
@synthesize httpSessionManager;
@synthesize timeout;

- (id) init {
	self = [super init];
	if (self != nil) {
		self.capitalizeMethods = NO;
		self.capitalizeFields = NO;
        self.httpSessionManager = nil;
        self.timeout = DEFAULT_REQUEST_TIMEOUT;
	}
	return self;
}

- (void) dealloc {
	self.protocol = nil;
	self.url = nil;
	self.wrapperFactory = nil;
	self.httpSessionManager = nil;
	[super dealloc];
}

@end
