//
//  OxICBaseJsonProxyFactoryObject.h
//  OxeniPhoneCommons
//
//  Created by Lautaro Brasseur on 25/10/11.
//  Copyright 2011 Oxen Software Studio. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OxICWrapperFactory.h"

@interface OxICBaseJsonProxyFactoryObject : NSObject {
	Protocol *protocol;
	NSString *url;
	id<OxICWrapperFactory> wrapperFactory;
	BOOL capitalizeMethods;
	BOOL capitalizeFields;
}

@property (retain, nonatomic) Protocol* protocol;
@property (retain, nonatomic) NSString* url;
@property (retain, nonatomic) id<OxICWrapperFactory> wrapperFactory;
@property (assign, nonatomic) BOOL capitalizeMethods;
@property (assign, nonatomic) BOOL capitalizeFields;

@end
