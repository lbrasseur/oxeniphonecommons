//
//  OxICBaseJsonProxy.m
//  OxeniPhoneCommons
//
//  Created by Lautaro Brasseur on 30/09/11.
//  Copyright 2011 Oxen Software Studio. All rights reserved.
//

#import "OxICBaseJsonProxy.h"
#import "JSONKit.h"
#import "OxICDictionaryProxy.h"
#import "OxICDictionaryConverter.h"
#import <objc/runtime.h>

@interface OxICBaseJsonProxy()
@property (retain, nonatomic) Protocol* protocol;

- (NSDictionary*) buildMessageForMethod: (NSString*) method
						  withArguments: (NSArray*) arguments
						   andConverter: (OxICDictionaryConverter*) dictionaryConverter;
	
- (NSString*) buildUrlForMethod: (NSString*)method
				  withArguments: (NSArray*) arguments;

- (id) buildResponse: (id)serverResponse;

- (id) processJson: (NSString*)method
	 withArguments: (NSArray*) arguments;

@end

@implementation OxICBaseJsonProxy
@synthesize protocol;
@synthesize url;
@synthesize wrapperFactory;
@synthesize capitalizeMethods;
@synthesize capitalizeFields;


#pragma mark init and dealloc
- (id) initWithProtocol: (Protocol*) aProtocol
				 andURL: (NSString*) aURL
	  andWrapperFactory:(id<OxICWrapperFactory>) aWrapperFactory {
	
	self.protocol = aProtocol;
	self.url = aURL;
	self.wrapperFactory = aWrapperFactory;
	self.capitalizeMethods = NO;
	self.capitalizeFields = NO;
	
	return self;
}

- (void) dealloc {
	self.protocol = nil;
	self.url = nil;
	self.wrapperFactory = nil;
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
	
	OxICDictionaryConverter *dictionaryConverter = [[OxICDictionaryConverter alloc] initWithWrapperFactory:self.wrapperFactory];
	dictionaryConverter.capitalizeFields = self.capitalizeFields;
	NSDictionary *message = [self buildMessageForMethod:method
										  withArguments:arguments
										   andConverter:dictionaryConverter];
	[dictionaryConverter release];
	
	NSError *error = nil;
	NSData *requestData = [message JSONDataWithOptions:JKSerializeOptionNone error:&error];
#ifdef DEBUG
	NSLog(@"OxICBaseJsonProxy requestData: [%@]", [[NSString alloc] initWithData:requestData encoding:NSASCIIStringEncoding]);
#endif
	
	if (error != nil) {
		NSException* exception = [NSException
								  exceptionWithName:@"JSON generation error"
								  reason:[error description]
								  userInfo:[error userInfo]];
		@throw exception;
	}
	
	NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL: [NSURL URLWithString:[self  buildUrlForMethod:method
																										withArguments:arguments]]];
	[request setHTTPMethod:@"POST"];
	[request addValue:@"text/json" forHTTPHeaderField:@"content-type"];
    [request setHTTPBody:requestData];

	error = nil;
	NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:&error];
#ifdef DEBUG
	NSLog(@"OxICBaseJsonProxy responseData: [%@]", [[NSString alloc] initWithData:responseData encoding:NSASCIIStringEncoding]);
#endif
	
	if (error != nil) {
		NSException* exception = [NSException
								  exceptionWithName:@"HTTP request error"
								  reason:[error description]
								  userInfo:[error userInfo]];
		@throw exception;
	}
	
	error = nil;
	//NSData *responseData = [@"{\"d\":{\"__type\":\"contratodto:#ATUR.Web.DTO\",\"error\":null,\"estado\":true,\"fecha\":\"\\/Date(1323893169737+0000)\\/\",\"imei\":null,\"monto\":0,\"observaciones\":null,\"restricciones\":\"Este contrato solo es valido por un periodo de tiempo, por favor renueva tu contrato\",\"tiempovigencia\":5,\"tipo\":0,\"usuario\":null,\"usuarioid\":null,\"vigenciafinal\":\"\\/Date(1324325169737+0000)\\/\",\"vigenciainicial\":\"\\/Date(1323893169737+0000)\\/\"}}" dataUsingEncoding:NSUTF8StringEncoding];
	//NSLog(@"responseData: [%@]", [[NSString alloc] initWithData:responseData encoding:NSASCIIStringEncoding]);
	id parsedObject = [[JSONDecoder decoder] objectWithData:responseData error:&error];
	
	if (error != nil) {
		NSException* exception = [NSException
								  exceptionWithName:@"JSON parsing error"
								  reason:[error description]
								  userInfo:[error userInfo]];
		@throw exception;
	}
	
	return [OxICDictionaryProxy buildProxy:[self buildResponse:parsedObject]
							withCapitalize:self.capitalizeFields];
}

- (NSDictionary*) buildMessageForMethod: (NSString*) method
						  withArguments: (NSArray*) arguments
						   andConverter: (OxICDictionaryConverter*) dictionaryConverter {
	return nil;
}

- (NSString*) buildUrlForMethod: (NSString*) method
				  withArguments: (NSArray*) arguments {
	return nil;
}

- (id) buildResponse: (id)serverResponse {
	return nil;
}

@end