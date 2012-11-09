//
//  OxICServletSessionManager.m
//  OxeniPhoneCommons
//
//  Created by Lautaro Brasseur on 13/09/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "OxICServletSessionManager.h"
#define SESSION_COOKIE @"JSESSIONID"

/* This class must be singleton! */
@interface OxICServletSessionManager()
@property (nonatomic, retain) NSString* jsessionId;
@end

@implementation OxICServletSessionManager
@synthesize jsessionId;

#pragma mark Init and dealloc
- (id)init {
    self = [super init];
    if (self) {
        self.jsessionId = nil;
    }
    return self;
}

- (void)dealloc {
    self.jsessionId = nil;
    [super dealloc];
}

#pragma mark OxICSessionManager methods
- (void) processRequest:(NSMutableURLRequest*) request {
    if (self.jsessionId != nil) {
        NSString *value =[NSString stringWithFormat:@"%@=%@;", SESSION_COOKIE, self.jsessionId];
        [request addValue:value forHTTPHeaderField:@"Cookie"];
    }
}

- (void) processResponse:(NSHTTPURLResponse*) response {
    NSDictionary *headers = [response allHeaderFields];
    
    for (NSString *key in [headers keyEnumerator]) {
        if ([key isEqualToString:@"Set-Cookie"]) {
            for (NSString *value in [[headers valueForKey:key] componentsSeparatedByString:@";"]) {
                value = [value stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
                
                NSRange equalsRange = [value rangeOfString:@"="];
                
                if (equalsRange.location != NSNotFound) {
                    NSString *name = [value substringToIndex:equalsRange.location];
                    if ([name isEqualToString:SESSION_COOKIE]) {
                        self.jsessionId = [[value substringFromIndex:equalsRange.location + 1]
                                           stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
                        break;
                    }
                }
            }
        }
    }
}

@end
