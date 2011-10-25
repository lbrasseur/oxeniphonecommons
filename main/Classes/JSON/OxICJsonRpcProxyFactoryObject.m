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

- (id) getObject {
	OxICJsonRpcProxy *proxy = [[OxICJsonRpcProxy alloc] initWithProtocol: self.protocol
																  andURL: self.url
													   andWrapperFactory: self.wrapperFactory];
	
	proxy.capitalizeMethods = self.capitalizeMethods;
	proxy.capitalizeFields = self.capitalizeFields;
	
	return [proxy autorelease];
}

@end
