//
//  OxICJsonRpcProxyFactoryObject.m
//  OxeniPhoneCommons
//
//  Created by Lautaro Brasseur on 01/10/11.
//  Copyright 2011 Oxen Software Studio. All rights reserved.
//

#import "OxICJsonRpcProxyFactoryObject.h"
#import "OxICJsonRpcProxy.h"

@implementation OxICJsonRpcProxyFactoryObject
@synthesize protocol, url, wrapperFactory;

- (void) dealloc {
	self.protocol = nil;
	self.url = nil;
	self.wrapperFactory = nil;
	[super dealloc];
}

- (id) getObject {
	return [[[OxICJsonRpcProxy alloc] initWithProtocol: self.protocol
												andURL: self.url
									 andWrapperFactory:self.wrapperFactory] autorelease];
}

@end
