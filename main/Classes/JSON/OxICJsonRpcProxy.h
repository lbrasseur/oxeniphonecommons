//
//  OxICJSONProxy.h
//  OxeniPhoneCommons
//
//  Created by Lautaro Brasseur on 30/09/11.
//  Copyright 2011 Oxen Software Studio. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OxICJsonRpcProxy : NSProxy {
	Protocol *protocol;
	NSString *url;
}

- (id) initWithProtocol: (Protocol*) aProtocol
				 andURL: (NSString*) aURL;

@end
