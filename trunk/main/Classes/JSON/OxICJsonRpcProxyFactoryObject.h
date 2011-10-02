//
//  OxICJsonRpcProxyFactoryObject.h
//  OxeniPhoneCommons
//
//  Created by Lautaro Brasseur on 01/10/11.
//  Copyright 2011 Oxen Software Studio. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OxICFactoryObject.h"
#import "OxICWrapperFactory.h"

@interface OxICJsonRpcProxyFactoryObject : NSObject<OxICFactoryObject> {
	Protocol *protocol;
	NSString *url;
	id<OxICWrapperFactory> wrapperFactory;
}

@property (retain, nonatomic) Protocol* protocol;
@property (retain, nonatomic) NSString* url;
@property (retain, nonatomic) id<OxICWrapperFactory> wrapperFactory;

@end
