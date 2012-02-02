//
//  OxICJDictionaryProxy.m
//  OxeniPhoneCommons
//
//  Created by Lautaro Brasseur on 01/10/11.
//  Copyright 2011 Oxen Software Studio. All rights reserved.
//

#import "OxICDictionaryProxy.h"

@interface OxICDictionaryProxy()
@property (retain, nonatomic) NSDictionary* dictionary;
@end


@implementation OxICDictionaryProxy
@synthesize dictionary;
@synthesize capitalizeFields;

#pragma mark Init and dealloc
- (id) initWithDictionary: (NSDictionary*) aDictionary {
	self.dictionary = aDictionary;
	self.capitalizeFields = NO;
	return self;
}

- (void) dealloc {
	self.dictionary = nil;
	[super dealloc];
}

#pragma mark Interface methods
+ (id) buildProxy: (id) object
   withCapitalize:(BOOL)capitalizeFields {
	if (object == nil || [object isKindOfClass:[NSNull class]]) {
		return nil;
	} else if ([object isKindOfClass:[NSDictionary class]]) {
		OxICDictionaryProxy *proxy = [[OxICDictionaryProxy alloc] initWithDictionary:object];
		proxy.capitalizeFields = capitalizeFields;
		return [proxy autorelease];
	} else if ([object isKindOfClass:[NSArray class]]) {
		NSArray *sourceArray = object;
		NSMutableArray *targetArray = [NSMutableArray arrayWithCapacity:[sourceArray count]];
		
		for (id element in sourceArray) {
			[targetArray addObject:[self buildProxy:element
									 withCapitalize:capitalizeFields]];
		}						
		
		return targetArray;
		
	} else if ([object isKindOfClass:[NSSet class]]) {
		NSSet *sourceSet = object;
		NSMutableSet *targetSet = [NSMutableSet setWithCapacity:[sourceSet count]];
		
		for (id element in sourceSet) {
			[targetSet addObject:[self buildProxy:element
								   withCapitalize:capitalizeFields]];
		}						
		
		return targetSet;
		
	} else {
		return object;
	}
}

#pragma mark NSProxy methods
- (void)forwardInvocation:(NSInvocation *)anInvocation {
	if (anInvocation.selector == @selector(respondsToSelector:)) {
		BOOL response = YES;
		[anInvocation setReturnValue:&response];
	} else {
		NSString *selectorName = NSStringFromSelector(anInvocation.selector);
		
		NSString *key;
		if (self.capitalizeFields) {
			key = [selectorName capitalizedString];
		} else {
			key = selectorName;
		}
		
		id returnValue = [OxICDictionaryProxy buildProxy:[self.dictionary valueForKey:key]
										  withCapitalize:self.capitalizeFields];
		[anInvocation setReturnValue:&returnValue];
	}
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector {
	return [NSMethodSignature signatureWithObjCTypes:"@^v^c"];
}

@end
