//
//  OxICJDictionaryAdapter.m
//  OxeniPhoneCommons
//
//  Created by Lautaro Brasseur on 01/10/11.
//  Copyright 2011 Oxen Software Studio. All rights reserved.
//

#import "OxICDictionaryConverter.h"
#import "OxICObjectWrapper.h"

@interface OxICDictionaryConverter()
@property (nonatomic, retain) id<OxICWrapperFactory> wrapperFactory;
@end

@implementation OxICDictionaryConverter
@synthesize wrapperFactory;
@synthesize capitalizeFields;

#pragma mark Init and dealloc
- (id) initWithWrapperFactory: (id<OxICWrapperFactory>) aWrapperFactory {
	if (self = [super init]) {
		self.wrapperFactory = aWrapperFactory;
		self.capitalizeFields = NO;
	}
	return self;
}

- (void) dealloc {
	self.wrapperFactory = nil;
	[super dealloc];
}

#pragma mark public methods
- (id) convert: (id) object {
	if (object == nil ||
		[object isKindOfClass:[NSString class]] ||
		[object isKindOfClass:[NSDate class]] ||
		[object isKindOfClass:[NSNumber class]]) {
		
		return object;
		
	} else if ([object isKindOfClass:[NSArray class]]) {
		NSArray *sourceArray = object;
		NSMutableArray *targetArray = [NSMutableArray arrayWithCapacity:[sourceArray count]];
		
		for (id element in sourceArray) {
			[targetArray addObject:[self convert:element]];
		}						
		
		return targetArray;
		
	} else if ([object isKindOfClass:[NSSet class]]) {
		NSSet *sourceSet = object;
		NSMutableSet *targetSet = [NSMutableSet setWithCapacity:[sourceSet count]];
		
		for (id element in sourceSet) {
			[targetSet addObject:[self convert:element]];
		}						
		
		return targetSet;
		
	} else if ([object isKindOfClass:[NSDictionary class]]) {
		NSDictionary *sourceDictionary = object;
		NSMutableDictionary *targetDictionary = [NSMutableDictionary dictionaryWithCapacity:[sourceDictionary count]];
		
		for (NSString* key in sourceDictionary) {
			id value = [sourceDictionary objectForKey:key];
			if (value != nil) {
				[targetDictionary setObject:[self convert:value] forKey:key];
			}
		}						
		
		return targetDictionary;
	} else {
		id<OxICObjectWrapper> wrapper = [self.wrapperFactory wrapObject:object];
		NSArray* descriptors = [wrapper getPropertyDescriptors];
		
		NSMutableDictionary *dictionary = [NSMutableDictionary dictionaryWithCapacity:[descriptors count]];
		
		for (OxICPropertyDescriptor *descriptor in descriptors) {
			id value = [wrapper getProperty:descriptor.name];
			NSString *key;
			
			if (self.capitalizeFields) {
				key = [descriptor.name capitalizedString];
			} else {
				key = descriptor.name;
			}

			
			if (value != nil) {
				[dictionary setObject:[self convert:value] forKey:key];
			}
		}
		
		return dictionary;
	}
}

@end
