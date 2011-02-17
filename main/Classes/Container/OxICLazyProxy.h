//
//  OxICLazyProxy.h
//  Otra
//
//  Created by Lautaro Brasseur on 07/05/10.
//  Copyright 2010 Oxen Software Studio. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OxICObjectDefinition.h"
#import "OxICContainer.h"

@interface OxICLazyProxy : NSProxy {
	id realObject;
	NSString *className;
	OxICObjectDefinition* objectDefinition;
	OxICContainer* container;
}

- (id) initWithClassName: (id) aClassName andObjectDefinition: (OxICObjectDefinition*) aDefinition andContainer:(OxICContainer*) aContainer;

@end
