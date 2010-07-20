//
//  OxICContainer.m
//  Otra
//
//  Created by Lautaro Brasseur on 28/03/10.
//  Copyright 2010 Oxen Software Studio. All rights reserved.
//

#import "OxICContainer.h"
#import "OxICObjectWrapper.h"
#import "OxICLazyProxy.h"
#import "OxICPropertyDescriptor.h"

@interface OxICContainer()
@property (nonatomic, retain) id<OxICWrapperFactory> wrapperFactory;

- (id) getObjectForDefinition: (OxICObjectDefinition*) definition;
- (id) buildObject: (OxICObjectDefinition*) definition;
@end

@implementation OxICContainer
@synthesize wrapperFactory;

#pragma mark Init and dealloc
- (id) initWithWrapperFactory: (id<OxICWrapperFactory>) aWrapperFactory {
	if (self = [super init]) {
		self.wrapperFactory = aWrapperFactory;
		definitions = [[NSMutableDictionary alloc] init];
		objects = [[NSMutableDictionary alloc] init];
	}
	return self;
}

- (void) dealloc {
	self.wrapperFactory = nil;
	[definitions release];
	[objects release];
	[super dealloc];
}


#pragma mark public methods
- (void) addDefinition: (OxICObjectDefinition*) definition {
	[definitions setObject:definition forKey:definition.name];
}

- (id) getObject: (NSString*) name {
	OxICObjectDefinition *definition = [definitions objectForKey:name];
	
	if (definition == nil) {
		return nil;
	} else {
		return [self getObjectForDefinition:definition];
	}
}

#pragma mark private methods
- (id) getObjectForDefinition: (OxICObjectDefinition*) definition {
	id object;
	
	if (definition.singleton) {
		object = [objects objectForKey:definition.name];
	}
	
	if (object == nil) {
		object = [self buildObject:definition];
		if (definition.singleton) {
			[objects setObject:object forKey:definition.name];
		}
	}
	
	return object;
}

- (id) buildObject: (OxICObjectDefinition*) definition {
	id<OxICObjectWrapper> wrapper;
	
	if (!definition.lazy) {
		wrapper = [self.wrapperFactory createAndWrapObject:definition.className];
	} else {
		id lazyProxy = [[OxICLazyProxy alloc] initWithClassName:definition.className];
		wrapper = [self.wrapperFactory wrapObject:lazyProxy];
		[lazyProxy release];
	}

	
	for (OxICPropertyDescriptor *propDescr in [wrapper getPropertyDescriptors]) {
		/* Process references */
		NSString *reference = [definition.propertyReferences objectForKey:propDescr.name];
		if (reference != nil) {
			[wrapper setProperty:propDescr.name withValue:[self getObject:reference]];
		}
	}
	
	id object = [[wrapper getObject] retain];
	return [object autorelease];
}


@end
