//
//  OxICJsonSerializer.m
//  OxeniPhoneCommons
//
//  Created by Lautaro Brasseur on 11/05/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "OxICJsonSerializer.h"
#import "OxICDictionaryConverter.h"
#import "OxICDictionaryProxy.h"
#import "JSONKit.h"

@implementation OxICJsonSerializer
@synthesize wrapperFactory;
@synthesize capitalizeFields;

#pragma mark Init and dealloc
- (id)init {
    self = [super init];
    if (self) {
        self.wrapperFactory = nil;
        self.capitalizeFields = NO;
    }
    return self;
}

- (void)dealloc {
    self.wrapperFactory = nil;
    [super dealloc];
}

#pragma mark Interface methods
- (NSString*) serialize: (id) object {
	OxICDictionaryConverter *dictionaryConverter = [[OxICDictionaryConverter alloc] initWithWrapperFactory:self.wrapperFactory];
	dictionaryConverter.capitalizeFields = self.capitalizeFields;
	NSDictionary *message = [dictionaryConverter convert:object];
	[dictionaryConverter release];
	
	NSError *error = nil;
	NSData *jsonData = [message JSONDataWithOptions:JKSerializeOptionNone error:&error];
	
	if (error != nil) {
		NSException* exception = [NSException
								  exceptionWithName:@"JSON generation error"
								  reason:[error description]
								  userInfo:[error userInfo]];
		@throw exception;
	}
    
    return [[[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding] autorelease];
}

- (id) deserialize: (NSString*) data {
	NSError *error = nil;
	id parsedObject = [[JSONDecoder decoder] objectWithData:[data dataUsingEncoding:NSUTF8StringEncoding]
                                                      error:&error];
	
	if (error != nil) {
		NSException* exception = [NSException
								  exceptionWithName:@"JSON parsing error"
								  reason:[error description]
								  userInfo:[error userInfo]];
		@throw exception;
	}
	
	return [OxICDictionaryProxy buildProxy:parsedObject
							withCapitalize:self.capitalizeFields];
}

- (NSString*) encoding {
    return @"json";
}

@end
