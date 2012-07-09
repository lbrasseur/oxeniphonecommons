//
//  OxICJsonSerializer.h
//  OxeniPhoneCommons
//
//  Created by Lautaro Brasseur on 11/05/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OxICSerializer.h"
#import "OxICWrapperFactory.h"

/*!
 JSON serializer.
 */
@interface OxICJsonSerializer : NSObject<OxICSerializer> {
	id<OxICWrapperFactory> wrapperFactory;
	BOOL capitalizeFields;
}

@property (retain, nonatomic) id<OxICWrapperFactory> wrapperFactory;
@property (assign, nonatomic) BOOL capitalizeFields;

@end
