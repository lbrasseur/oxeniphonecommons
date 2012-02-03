//
//  OxICDaoProxy.h
//  OxeniPhoneCommons
//
//  Created by Lautaro Brasseur on 02/02/12.
//  Copyright 2012 Oxen Software Studio. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OxICDaoProtocol.h"

@interface OxICDaoProxy : NSProxy {
	id<OxICDaoProtocol> dao;
	NSMutableDictionary *selectorQueries;
}

- (id) initWithDao: (id<OxICDaoProtocol>) dao;

- (void) addSelector:(NSString*) selectorName
		  withFilter:(NSString*) filter;

@end
