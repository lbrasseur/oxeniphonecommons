//
//  LFCObjectWrapper.m
//  Otra
//
//  Created by Lautaro Brasseur on 15/12/09.
//  Copyright 2009 na. All rights reserved.
//

#import "OxICSimpleObjectWrapper.h"
#import <objc/runtime.h>
#import <CoreData/CoreData.h>

@interface OxICSimpleClassWrapper()
@property (retain, nonatomic) id object;
@end

@implementation OxICSimpleObjectWrapper
@synthesize object;

#pragma mark Init and dealloc
- (id) initWithObject:(id) anObject {
	if (self = [super initWithClass:[anObject class]]) {
		self.object = anObject;
	}
	return self;
}

- (id) initWithClassName:(NSString*) aClassName {
	if (self = [super initWithClassName:aClassName]) {
		id anObject = [self newObject];
		self.object = anObject;
		[anObject release];
	}
	return self;
}

- (void) dealloc {
	self.object = nil;
	[super dealloc];
}

#pragma mark Overiden methods
- (NSArray*) getPropertyDescriptors {
    if ([self.object isKindOfClass:[NSManagedObject class]]) {
        NSMutableArray *propArray = [[NSMutableArray alloc] init];
        for (NSAttributeDescription *attributeDescr in [[self.object entity] properties]) {
            OxICPropertyDescriptor *descriptor = [[OxICPropertyDescriptor alloc] initWithName:[attributeDescr name]
                                                                                      andType:[NSManagedObject class]
                                                                                  andProtocol:nil];
            [propArray addObject:descriptor];
            [descriptor release];
        }
        return [propArray autorelease];            
    } else {
        return [super getPropertyDescriptors];
    }
}


#pragma mark OxICObjectWrapper methods
- (id) getProperty: (NSString*) name {
	SEL propertySelector = NSSelectorFromString(name);
	return [object performSelector:propertySelector];
}

- (void) setProperty: (NSString*)name withValue: (id)value {
	[object setValue:value forKey:name];
}

- (id) getObject {
	return object;
}

#pragma mark Private methods

@end
