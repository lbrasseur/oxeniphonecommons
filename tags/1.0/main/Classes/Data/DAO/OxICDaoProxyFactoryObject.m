//
//  OxICDaoProxyFactoryObject.m
//  OxeniPhoneCommons
//
//  Created by Lautaro Brasseur on 03/02/12.
//  Copyright 2012 Oxen Software Studio. All rights reserved.
//

#import "OxICDaoProxyFactoryObject.h"
#import "OxICDaoProxy.h"

@implementation OxICDaoProxyFactoryObject
@synthesize dao;
@synthesize protocol;
@synthesize querySpecs;

- (id) getObject {
	OxICDaoProxy *proxy = [[OxICDaoProxy alloc] initWithDao:self.dao
												andProtocol:self.protocol];
	proxy.querySpecs = self.querySpecs;
	return [proxy autorelease];
}
@end
