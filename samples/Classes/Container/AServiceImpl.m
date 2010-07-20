//
//  AServiceImpl.m
//  OxeniPhoneCommonsSamples
//
//  Created by Lautaro Brasseur on 19/07/10.
//  Copyright 2010 Oxen Software Studio. All rights reserved.
//

#import "AServiceImpl.h"


@implementation AServiceImpl

- (id) init {
	self = [super init];
	if (self != nil) {
		NSLog(@"Service initialized!!!");
	}
	return self;
}


- (NSString*) sayHi: (NSString*) name {
	return [NSString stringWithFormat:@"HI %@ !!!", name];
}

@end
