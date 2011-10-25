//
//  OxICJDictionaryProxy.h
//  OxeniPhoneCommons
//
//  Created by Lautaro Brasseur on 01/10/11.
//  Copyright 2011 Oxen Software Studio. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface OxICDictionaryProxy : NSProxy {
	NSDictionary* dictionary;
	BOOL capitalizeFields;
}

@property (assign, nonatomic) BOOL capitalizeFields;

+ (id) buildProxy: (id) object
   withCapitalize:(BOOL)capitalizeFields;

- (id) initWithDictionary: (NSDictionary*) aDictionary;

@end
