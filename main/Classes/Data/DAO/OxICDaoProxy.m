//
//  OxICDaoProxy.m
//  OxeniPhoneCommons
//
//  Created by Lautaro Brasseur on 02/02/12.
//  Copyright 2012 Oxen Software Studio. All rights reserved.
//

#import "OxICDaoProxy.h"
#import <objc/runtime.h>

@implementation OxICDaoProxy
@synthesize dao;
@synthesize protocol;
@synthesize querySpecs;

- (id) initWithDao: (id<OxICDaoProtocol>) aDao
	   andProtocol:(Protocol*)aProtocol {
	self.dao = aDao;
	self.protocol = aProtocol;
	self.querySpecs = [NSMutableDictionary dictionaryWithCapacity:10];
	return self;
}

- (void) dealloc {
	self.dao = nil;
	self.protocol = nil;
	self.querySpecs = nil;
	[super dealloc];
}

- (void) addSelector:(NSString*) selectorName
	   withQuerySpec:(OxICQuerySpec*) querySpec {
	[self.querySpecs setValue:querySpec forKey:selectorName];
}

- (void)forwardInvocation:(NSInvocation *)anInvocation {
	NSString *selectorName = NSStringFromSelector(anInvocation.selector);
	OxICQuerySpec *querySpec = [self.querySpecs objectForKey:selectorName];
	
	if (querySpec != nil) {
		NSInteger argCount = anInvocation.methodSignature.numberOfArguments;
		NSMutableArray *arguments = [NSMutableArray arrayWithCapacity:argCount];
		
		for (int n = 2; n < argCount; n++) {
			id arg;
			[anInvocation getArgument:&arg atIndex:n];
			[arguments addObject:arg];
		}
		
		id returnValue = [self.dao findWithQuerySpec:querySpec
										andArguments:arguments];
		[anInvocation setReturnValue:&returnValue];
	} else {
		[anInvocation setTarget:self.dao];
		[anInvocation invoke];
	}
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector {
	return [NSMethodSignature signatureWithObjCTypes: protocol_getMethodDescription(self.protocol, aSelector, YES, YES).types];
}

@end
