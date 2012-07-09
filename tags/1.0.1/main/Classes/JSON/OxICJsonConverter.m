//
//  OxICJsonConverter.m
//  OxeniPhoneCommons
//
//  Created by Lautaro Brasseur on 25/04/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "OxICJsonConverter.h"
#import "OxICDictionaryConverter.h"
#import "OxICDictionaryProxy.h"
#import "JSONKit.h"

@implementation OxICJsonConverter
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
- (id) fromJson: (NSString*) jsonData {
	NSError *error = nil;
	id parsedObject = [[JSONDecoder decoder] objectWithData:[jsonData dataUsingEncoding:NSUTF8StringEncoding] error:&error];
	
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

- (NSString*) toJson: (id) object {
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


@end
