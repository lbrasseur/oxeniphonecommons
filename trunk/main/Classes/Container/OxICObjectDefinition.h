//
//  OxICObjectDefinition.h
//  Otra
//
//  Created by Lautaro Brasseur on 28/03/10.
//  Copyright 2010 Oxen Software Studio. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface OxICObjectDefinition : NSObject {
	NSString *name;
	NSString *className;
	BOOL autowire;
	BOOL singleton;
	BOOL lazy;
	NSMutableDictionary *propertyReferences;
	// TODO: propiedades con valores.... propiedades anidadas... etc. Pensar una clase generica
}

@property (retain,nonatomic) NSString *name;
@property (retain,nonatomic) NSString *className;
@property (assign,nonatomic) BOOL autowire;
@property (assign,nonatomic) BOOL singleton;
@property (assign,nonatomic) BOOL lazy;
@property (assign,nonatomic,readonly) NSDictionary *propertyReferences;;

- (void) addPropertyReference:(NSString*) propertyName toObjectName:(NSString*) objectName;

@end
