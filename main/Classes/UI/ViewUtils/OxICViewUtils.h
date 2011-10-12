//
//  OxICViewUtils.h
//  OxeniPhoneCommons
//
//  Created by Lautaro Brasseur on 08/10/11.
//  Copyright 2011 Oxen Software Studio. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

/*! 
 Utility class for dealing with UI views.
 */
@interface OxICViewUtils : NSObject {
}

/*!
 Returns the UITextField that has the current focus.
 */
- (UITextField*) findCurrentTextField;

/*!
 Runs a selector asynchronously.
 */
- (void) runAsync:(SEL) selector
	   withTarget:(id) target
	  andCallback:(SEL) callback;

@end
