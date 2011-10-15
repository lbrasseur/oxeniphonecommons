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

- (NSDictionary*) buildMessageForMethod: (NSString*)method
						  withArguments: (NSArray*) arguments {
	if ([arguments count] == 1) {
		OxICDictionaryConverter *dictionaryConverter = [[OxICDictionaryConverter alloc] initWithWrapperFactory:self.wrapperFactory];
		
		NSDictionary *message = [dictionaryConverter convert:[arguments objectAtIndex:0]];
		
		[dictionaryConverter release];
		
		return message;
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
	return [NSString stringWithFormat:@"%@/%@", self.url, method];
}

- (id) buildResponse: (id)serverResponse {
	return serverResponse;
}

@end
