//
//  OxICServletSessionManager.h
//  OxeniPhoneCommons
//
//  Created by Lautaro Brasseur on 13/09/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OxICHttpSessionManager.h"

@interface OxICServletSessionManager : NSObject<OxICHttpSessionManager> {
    NSString* jsessionId;
}
@end
