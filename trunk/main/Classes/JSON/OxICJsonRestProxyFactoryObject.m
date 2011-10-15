//
//  OxICJsonRestProxyFactoryObject.m
//  OxeniPhoneCommons
//
//  Created by Lautaro Brasseur on 01/10/11.
//  Copyright 2011 Oxen Software Studio. All rights reserved.
//

#import "OxICJsonRestProxyFactoryObject.h"
#import "OxICJsonRestProxy.h"

@implementation OxICJsonRestProxyFactoryObject
@synthesize protocol, url, wrapperFactory;

- (void) dealloc {
	self.protocol = nil;
	self.url = nil;
	self.wrapperFactory = nil;
	[super dealloc];
}

- (id) getObject {
	return [[[OxICJsonRestProxy alloc] initWithProtocol: self.protocol
												 andURL: self.url
									  andWrapperFactory:self.wrapperFactory] autorelease];
}

@end
