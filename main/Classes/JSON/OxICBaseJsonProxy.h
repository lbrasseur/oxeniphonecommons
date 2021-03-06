//
//  OxICBaseJsonProxy.h
//  OxeniPhoneCommons
//
//  Created by Lautaro Brasseur on 30/09/11.
//  Copyright 2011 Oxen Software Studio. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OxICWrapperFactory.h"
#import "OxICHttpSessionManager.h"
#define DEFAULT_REQUEST_TIMEOUT 300

@interface OxICBaseJsonProxy : NSProxy {
	Protocol *protocol;
	NSString *url;
	id<OxICWrapperFactory> wrapperFactory;
	BOOL capitalizeMethods;
	BOOL capitalizeFields;
    id<OxICHttpSessionManager> httpSessionManager;
    NSTimeInterval timeout;
}

- (id) initWithProtocol: (Protocol*) aProtocol
				 andURL: (NSString*) aURL
	  andWrapperFactory:(id<OxICWrapperFactory>) aWrapperFactory;

@property (retain, nonatomic) id<OxICWrapperFactory> wrapperFactory;
@property (retain, nonatomic) NSString* url;
@property (assign, nonatomic) BOOL capitalizeMethods;
@property (assign, nonatomic) BOOL capitalizeFields;
@property (retain, nonatomic) id<OxICHttpSessionManager> httpSessionManager;
@property (assign, nonatomic) NSTimeInterval timeout;

@end
