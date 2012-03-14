//
//  OxICJsonRestProxy.m
//  OxeniPhoneCommons
//
//  Created by Lautaro Brasseur on 30/09/11.
//  Copyright 2011 Oxen Software Studio. All rights reserved.
//

#import "OxICJsonRestProxy.h"
#import "JSONKit.h"
#import "OxICDictionaryProxy.h"
#import "OxICDictionaryConverter.h"
#import <objc/runtime.h>

@implementation OxICJsonRestProxy

- (NSDictionary*) buildMessageForMethod: (NSString*) method
						  withArguments: (NSArray*) arguments
						   andConverter: (OxICDictionaryConverter*) dictionaryConverter {
	if ([arguments count] == 1) {
		return [dictionaryConverter convert:[arguments objectAtIndex:0]];
	} else if ([arguments count] == 0) {
		return nil;
	} else {
		NSException* exception = [NSException
								  exceptionWithName:@"ArgumentException"
								  reason:@"Json Rest proxy supports only one argument"
								  userInfo:nil];
		@throw exception;
	}
}

- (NSString*) buildUrlForMethod: (NSString*)method
				  withArguments: (NSArray*) arguments {
	
	NSString *methodInUrl;
	if (self.capitalizeMethods) {
		methodInUrl = [method capitalizedString];
	} else {
		methodInUrl = method;
	}
	
	return [NSString stringWithFormat:@"%@/%@", self.url, methodInUrl];
}

- (id) buildResponse: (id)serverResponse {
	return serverResponse;
}

@end
