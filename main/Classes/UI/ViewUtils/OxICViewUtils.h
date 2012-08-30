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
	UIView *waitView;
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

- (void) runAsync:(SEL) selector
	   withTarget:(id) target
	  andCallback:(SEL) callback
      andWaitView:(UIView*) waitView;

- (void)    runAsync:(SEL) selector
          withTarget:(id) target
         andCallback:(SEL) callback
andExceptionCallback:(SEL) exceptionCallback;

- (void)    runAsync:(SEL) selector
          withTarget:(id) target
         andCallback:(SEL) callback
andExceptionCallback:(SEL) exceptionCallback
         andWaitView:(UIView*) waitView;

- (void) showActivityIndicator;

- (void) showActivityIndicatorWithView:(UIView*) waitView;

- (void) hideActivityIndicator;

@end
