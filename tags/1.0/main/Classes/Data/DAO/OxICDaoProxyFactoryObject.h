//
//  OxICDaoProxyFactoryObject.h
//  OxeniPhoneCommons
//
//  Created by Lautaro Brasseur on 03/02/12.
//  Copyright 2012 Oxen Software Studio. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OxICFactoryObject.h"
#import "OxICDaoProtocol.h"

@interface OxICDaoProxyFactoryObject : NSObject<OxICFactoryObject> {
	id<OxICDaoProtocol> dao;
	Protocol *protocol;
	NSMutableDictionary *querySpecs;
}

@property (retain, nonatomic) id<OxICDaoProtocol> dao;
@property (retain, nonatomic) Protocol *protocol;
@property (retain, nonatomic) NSMutableDictionary *querySpecs;

@end
