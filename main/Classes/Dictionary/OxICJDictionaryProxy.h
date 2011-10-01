//
//  OxICJDictionaryProxy.h
//  OxeniPhoneCommons
//
//  Created by Lautaro Brasseur on 01/10/11.
//  Copyright 2011 Oxen Software Studio. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface OxICJDictionaryProxy : NSProxy {
	NSDictionary* dictionary;
}

+ (id) buildProxy: (id) object;

- (id) initWithDictionary: (NSDictionary*) aDictionary;

@end
