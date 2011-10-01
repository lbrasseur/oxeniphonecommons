//
//  OxICJSONProxy.m
//  OxeniPhoneCommons
//
//  Created by Lautaro Brasseur on 30/09/11.
//  Copyright 2011 Oxen Software Studio. All rights reserved.
//

#import "OxICJsonRpcProxy.h"
#import "JSONKit.h"
#import <objc/runtime.h>

@interface OxICJsonRpcProxy()
- (id) processJson: (NSString*)method
	 withArguments: (NSArray*) arguments;
@property (retain, nonatomic) Protocol* protocol;
@property (retain, nonatomic) NSString* url;
@end

@implementation OxICJsonRpcProxy
@synthesize protocol, url;

#pragma mark init and dealloc
- (id) initWithProtocol: (Protocol*) aProtocol
				 andURL: (NSString*) aURL {
	self.protocol = aProtocol;
	self.url = aURL;
	
	return self;
}

- (void) dealloc {
	self.protocol = nil;
	self.url = nil;
	[super dealloc];
}

#pragma mark NSProxy methods
- (void)forwardInvocation:(NSInvocation *)anInvocation {
	/* Arguments parsing */
	int argCount = [[anInvocation methodSignature] numberOfArguments];
	NSMutableArray* arguments = [NSMutableArray arrayWithCapacity:argCount];
	for (int n = 2; n < argCount; n++) {
		id dummy;
		[anInvocation getArgument:&dummy atIndex:n];
		[arguments addObject:dummy];
	}
	
	/* Method name parsing */
	NSString *selectorName = NSStringFromSelector(anInvocation.selector);
	int nameLength = [selectorName length];
	NSMutableString * methodName = [NSMutableString stringWithCapacity:nameLength];
	BOOL capitalize = NO;
	for (int n = 0; n < nameLength; n++) {
		NSString *part = [selectorName substringWithRange:NSMakeRange(n, 1)];
		if ([part isEqualToString:@":"]) {
			capitalize = YES;
		} else if (capitalize) {
			[methodName appendString: [part uppercaseString]];
			capitalize = NO;
		} else {
			[methodName appendString: part];
		}
	}
	
	/* JSON process */
	id returnValue = [self processJson:methodName withArguments:arguments];
	[anInvocation setReturnValue:&returnValue];
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector {
	return [NSMethodSignature signatureWithObjCTypes: protocol_getMethodDescription(self.protocol, aSelector, YES, YES).types];
}

#pragma mark JSON methods
- (id) processJson: (NSString*)method
	 withArguments: (NSArray*) arguments {
	
	NSDictionary *message = [NSDictionary dictionaryWithObjectsAndKeys:
						     [NSNumber numberWithInt:1], @"id",
						     @"1.0", @"jsonrpc",
						     method, @"method",
						     arguments, @"params",
						     nil];
	
	NSError *error = nil;
	NSData *requestData = [message JSONDataWithOptions:JKSerializeOptionNone error:&error];
	
	if (error != nil) {
		NSException* exception = [NSException
								  exceptionWithName:@"JSON generation error"
								  reason:[error description]
								  userInfo:[error userInfo]];
		@throw exception;
	}
	
	NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL: [NSURL URLWithString:self.url]];
	[request setHTTPMethod:@"POST"];
    [request setHTTPBody:requestData];

	error = nil;
	NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:&error];
	
	if (error != nil) {
		NSException* exception = [NSException
								  exceptionWithName:@"HTTP request error"
								  reason:[error description]
								  userInfo:[error userInfo]];
		@throw exception;
	}
	
	NSDictionary *responseDict = [[JSONDecoder decoder] objectWithData:responseData];
	
	return [responseDict valueForKey:@"result"];
}

@end
