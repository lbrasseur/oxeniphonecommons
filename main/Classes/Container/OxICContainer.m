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
#import <objc/runtime.h>

@interface OxICContainer()
@property (nonatomic, retain) id<OxICWrapperFactory> wrapperFactory;

- (id) getObjectForDefinition: (OxICObjectDefinition*) definition;
- (id) buildObject: (OxICObjectDefinition*) definition;
- (OxICObjectDefinition*) getObjectDefinitionFromClassName:(NSString*) className;
- (void) addPropertyReferencesInClass:(NSObject*) anObject andDefinition:(OxICObjectDefinition *) definition;
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

- (void) addDefinitionFromClassName: (NSString*) className {
	OxICObjectDefinition *definition = [self getObjectDefinitionFromClassName:className];
	[self addDefinition:definition];
	
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
		//add propertyReference definitions	
		[self addPropertyReferencesInClass:[wrapper getObject] andDefinition:definition];
	} else {
		id lazyProxy = [[OxICLazyProxy alloc] initWithClassName:definition.className andObjectDefinition: definition andContainer:self];
		wrapper = [self.wrapperFactory wrapObject:lazyProxy];
		[lazyProxy release];

		//add propertyReference definitions from lazy	
		id object = [objc_getClass([definition.className UTF8String]) new];
		[self addPropertyReferencesInClass:object andDefinition:definition];
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

-(void) addPropertyReferencesInClass:(NSObject*) anObject andDefinition:(OxICObjectDefinition *) definition {
	// TODO: Ver si esto no se podría resolver mejor con el class wrapper
	int i=0;
	unsigned int mc = 0;
	Method * mlist = class_copyMethodList(object_getClass(anObject), &mc);
	NSString *methodName;
	NSString *propertyName;
	NSString *objectDefName;
	for(i=0;i<mc;i++){
		methodName = [NSString stringWithUTF8String:sel_getName(method_getName(mlist[i]))];
		NSRange iocMapRange = [methodName rangeOfString:@"iocMap_"];
		if (iocMapRange.location == 0) {
			NSRange $$location = [methodName rangeOfString:@"__"];
			propertyName = [methodName substringWithRange: NSMakeRange (iocMapRange.length, $$location.location - iocMapRange.length)];
			objectDefName = [methodName substringWithRange:NSMakeRange($$location.location + $$location.length, [methodName length] - $$location.location - $$location.length)];
			[definition addPropertyReference:propertyName toObjectName:objectDefName];
		}
	}
	free(mlist);
}
- (OxICObjectDefinition*) getObjectDefinitionFromClassName:(NSString*) className {
	// TODO: Ver si esto no se podría resolver mejor con el class wrapper
	id anObject = [objc_getClass([className UTF8String]) new];
	unsigned int mc = 0;
	Method * mlist = class_copyMethodList(object_getClass(anObject), &mc);
	NSString *methodName;
	NSString *defName;
	BOOL defLazy = NO;
	BOOL defSingleton = NO;
	int i;
	for(i=0;i<mc;i++){
		methodName = [NSString stringWithUTF8String:sel_getName(method_getName(mlist[i]))];
		NSRange iocNameRange = [methodName rangeOfString:@"iocName_"];
		if (iocNameRange.location == 0) {
			defName = [methodName substringWithRange: NSMakeRange (iocNameRange.length, [methodName length] - iocNameRange.length)];
		} else if ([methodName isEqualToString:@"iocLazy"]) {
			defLazy = YES;
		} else if ([methodName isEqualToString:@"iocSingleton"]) {
			defSingleton = YES;
		}
	}
	free(mlist);
	
	OxICObjectDefinition *objectDefinition = [[OxICObjectDefinition alloc] init];
	if (!defName) {
		defName = className;
	}
	objectDefinition.name = defName;
	objectDefinition.className = className;
	objectDefinition.lazy = defLazy;
	objectDefinition.singleton = defSingleton;
	return [objectDefinition autorelease];
	
}

@end
