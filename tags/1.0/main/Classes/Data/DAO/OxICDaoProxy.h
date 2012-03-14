//
//  OxICDaoProxy.h
//  OxeniPhoneCommons
//
//  Created by Lautaro Brasseur on 02/02/12.
//  Copyright 2012 Oxen Software Studio. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OxICDaoProtocol.h"
#import "OxICQuerySpec.h"

/*!
 Proxy for automatic DAO selector delegation.
 */
@interface OxICDaoProxy : NSProxy {
	id<OxICDaoProtocol> dao;
	Protocol *protocol;
	NSMutableDictionary *querySpecs;
}

@property (retain, nonatomic) id<OxICDaoProtocol> dao;
@property (retain, nonatomic) Protocol *protocol;
@property (retain, nonatomic) NSMutableDictionary *querySpecs;

- (id) initWithDao:(id<OxICDaoProtocol>) dao
	   andProtocol:(Protocol*)protocol;

- (void) addSelector:(NSString*) selectorName
	   withQuerySpec:(OxICQuerySpec*) querySpec;

@end
