//
//  OxICContainer.h
//  Otra
//
//  Created by Lautaro Brasseur on 28/03/10.
//  Copyright 2010 Oxen Software Studio. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OxICObjectDefinition.h"
#import "OxICWrapperFactory.h"

@interface OxICContainer : NSObject {
	NSMutableDictionary *definitions;
	NSMutableDictionary *objects;
	id<OxICWrapperFactory> wrapperFactory;
}

- (id) initWithWrapperFactory: (id<OxICWrapperFactory>) aWrapperFactory;

- (void) addDefinition: (OxICObjectDefinition*) definition;
- (id) getObject: (NSString*) name;

@end
