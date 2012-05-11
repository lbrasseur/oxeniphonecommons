//
//  OxICSerializer.h
//  OxeniPhoneCommons
//
//  Created by Lautaro Brasseur on 11/05/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

/*!
 Protocol for serializing from/to NSString.
 */
@protocol OxICSerializer <NSObject>

/*!
 Converts an object to NSString.
 */
- (NSString*) serialize: (id) object;

/*!
 Reads an object from a NSString.
 */
- (id) deserialize: (NSString*) data;

/*!
 Returns the serialization encoding enconding.
 For example, xml or json.
 */
- (NSString*) encoding;

@end
