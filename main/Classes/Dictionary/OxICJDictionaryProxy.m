//
//  OxICJDictionaryProxy.m
//  OxeniPhoneCommons
//
//  Created by Lautaro Brasseur on 01/10/11.
//  Copyright 2011 Oxen Software Studio. All rights reserved.
//

#import "OxICJDictionaryProxy.h"

@interface OxICJDictionaryProxy()
@property (retain, nonatomic) NSDictionary* dictionary;
@end


@implementation OxICJDictionaryProxy
@synthesize dictionary;

#pragma mark Init and dealloc
- (id) initWithDictionary: (NSDictionary*) aDictionary {
	self.dictionary = aDictionary;
	return self;
}

- (void) dealloc {
	self.dictionary = nil;
	[super dealloc];
}

#pragma mark Interface methods
+ (id) buildProxy: (id) object {
	if (object == nil || [object isKindOfClass:[NSNull class]]) {
		return nil;
	} else if ([object isKindOfClass:[NSDictionary class]]) {
		return [[[OxICJDictionaryProxy alloc] initWithDictionary:object] autorelease];
	} else {
		return object;
	}
}

#pragma mark NSProxy methods
- (void)forwardInvocation:(NSInvocation *)anInvocation {
	NSString *selectorName = NSStringFromSelector(anInvocation.selector);
	id returnValue = [OxICJDictionaryProxy buildProxy:[self.dictionary valueForKey:selectorName]];
	[anInvocation setReturnValue:&returnValue];
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector {
	return [NSMethodSignature signatureWithObjCTypes:"@^v^c"];
}

@end
