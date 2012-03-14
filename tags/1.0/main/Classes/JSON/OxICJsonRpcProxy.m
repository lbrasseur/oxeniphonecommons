//
//  OxICJsonRpcProxy.m
//  OxeniPhoneCommons
//
//  Created by Lautaro Brasseur on 30/09/11.
//  Copyright 2011 Oxen Software Studio. All rights reserved.
//

#import "OxICJsonRpcProxy.h"
#import "OxICDictionaryConverter.h"

@implementation OxICJsonRpcProxy

- (NSDictionary*) buildMessageForMethod: (NSString*) method
						  withArguments: (NSArray*) arguments
						   andConverter: (OxICDictionaryConverter*) dictionaryConverter {
	
	NSString *methodInMessage;
	if (self.capitalizeMethods) {
		methodInMessage = [method capitalizedString];
	} else {
		methodInMessage = method;
	}
	
	return [NSDictionary dictionaryWithObjectsAndKeys:
			[NSNumber numberWithInt:1], @"id",
			@"1.0", @"jsonrpc",
			methodInMessage, @"method",
			[dictionaryConverter convert:arguments], @"params",
			nil];
}

- (NSString*) buildUrlForMethod: (NSString*)method
				  withArguments: (NSArray*) arguments {
	return self.url;
}

- (id) buildResponse: (id)serverResponse {
	NSDictionary *responseDict = serverResponse;
	
	return [responseDict valueForKey:@"result"];
}

@end
