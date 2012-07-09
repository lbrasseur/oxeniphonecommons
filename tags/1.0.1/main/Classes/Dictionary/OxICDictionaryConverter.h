//
//  OxICJDictionaryAdapter.h
//  OxeniPhoneCommons
//
//  Created by Lautaro Brasseur on 01/10/11.
//  Copyright 2011 Oxen Software Studio. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OxICObjectWrapper.h"
#import "OxICWrapperFactory.h"

@interface OxICDictionaryConverter : NSObject {
	id<OxICWrapperFactory> wrapperFactory;
	BOOL capitalizeFields;
}

@property (assign, nonatomic) BOOL capitalizeFields;

- (id) initWithWrapperFactory: (id<OxICWrapperFactory>) aWrapperFactory;

- (id) convert: (id) object;

@end
