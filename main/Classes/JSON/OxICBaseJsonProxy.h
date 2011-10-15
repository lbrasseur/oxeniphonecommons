//
//  OxICBaseJsonProxy.h
//  OxeniPhoneCommons
//
//  Created by Lautaro Brasseur on 30/09/11.
//  Copyright 2011 Oxen Software Studio. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OxICWrapperFactory.h"

@interface OxICBaseJsonProxy : NSProxy {
	Protocol *protocol;
	NSString *url;
	id<OxICWrapperFactory> wrapperFactory;
}

- (id) initWithProtocol: (Protocol*) aProtocol
				 andURL: (NSString*) aURL
	  andWrapperFactory:(id<OxICWrapperFactory>) aWrapperFactory;

@property (retain, nonatomic) id<OxICWrapperFactory> wrapperFactory;
@property (retain, nonatomic) NSString* url;

@end
