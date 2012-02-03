//
//  OxICDaoProxy.m
//  OxeniPhoneCommons
//
//  Created by Lautaro Brasseur on 02/02/12.
//  Copyright 2012 Oxen Software Studio. All rights reserved.
//

#import "OxICDaoProxy.h"

@interface OxICDaoProxy()
@property (retain, nonatomic) id<OxICDaoProtocol> dao;
@property (retain, nonatomic) NSMutableDictionary *selectorQueries;
@end


@implementation OxICDaoProxy
@synthesize dao;
@synthesize selectorQueries;


- (id) initWithDao: (id<OxICDaoProtocol>) aDao{
		self.dao = aDao;
	self.selectorQueries = [NSMutableDictionary dictionaryWithCapacity:10];
	return self;
}

- (void) dealloc {
	self.dao = nil;
	self.selectorQueries = nil;
	[super dealloc];
}


- (void) addSelector:(NSString*) selectorName
		  withFilter:(NSString*) filter {
	[self.selectorQueries setValue:filter forKey:selectorName];
}

- (void)forwardInvocation:(NSInvocation *)anInvocation {
	NSString *selectorName = NSStringFromSelector(anInvocation.selector);
	NSString *filter = [self.selectorQueries objectForKey:selectorName];
	
	if (filter != nil) {
		NSArray *response = [self.dao findWithFilter:filter];
		[anInvocation setReturnValue:&response];
	} else {
		[anInvocation setTarget:self.dao];
		[anInvocation invoke];
	}
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector {
	return [NSMethodSignature signatureWithObjCTypes:"@^v^c"];
}
@end
