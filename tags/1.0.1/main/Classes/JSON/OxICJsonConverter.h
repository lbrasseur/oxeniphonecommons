//
//  OxICJsonConverter.h
//  OxeniPhoneCommons
//
//  Created by Lautaro Brasseur on 25/04/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OxICWrapperFactory.h"

@interface OxICJsonConverter : NSObject {
	id<OxICWrapperFactory> wrapperFactory;
	BOOL capitalizeFields;
}

@property (retain, nonatomic) id<OxICWrapperFactory> wrapperFactory;
@property (assign, nonatomic) BOOL capitalizeFields;

- (id) fromJson: (NSString*) jsonData;

- (NSString*) toJson: (id) object;

@end
