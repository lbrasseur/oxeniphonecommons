//
//  OxICBaseJsonProxyFactoryObject.m
//  OxeniPhoneCommons
//
//  Created by Lautaro Brasseur on 25/10/11.
//  Copyright 2011 Oxen Software Studio. All rights reserved.
//

#import "OxICBaseJsonProxyFactoryObject.h"


@implementation OxICBaseJsonProxyFactoryObject
@synthesize protocol;
@synthesize url;
@synthesize wrapperFactory;
@synthesize capitalizeMethods;
@synthesize capitalizeFields;

- (id) init {
	self = [super init];
	if (self != nil) {
		self.capitalizeMethods = NO;
		self.capitalizeFields = NO;
	}
	return self;
}

- (void) dealloc {
	self.protocol = nil;
	self.url = nil;
	self.wrapperFactory = nil;
	[super dealloc];
}

@end
