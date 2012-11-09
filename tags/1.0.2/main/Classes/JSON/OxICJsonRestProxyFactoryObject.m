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

- (id) getObject {
	OxICJsonRestProxy *proxy = [[OxICJsonRestProxy alloc] initWithProtocol: self.protocol
																	andURL: self.url
														 andWrapperFactory: self.wrapperFactory];
	
	proxy.capitalizeMethods = self.capitalizeMethods;
	proxy.capitalizeFields = self.capitalizeFields;
	proxy.httpSessionManager = self.httpSessionManager;
	
	return [proxy autorelease];
}

@end
