//
//  OxICViewUtils.m
//  OxeniPhoneCommons
//
//  Created by Lautaro Brasseur on 08/10/11.
//  Copyright 2011 Oxen Software Studio. All rights reserved.
//

#import "OxICViewUtils.h"

@implementation OxICViewUtils

- (UIView *)findFirstResonder: (UIView *) aView{
    if (aView.isFirstResponder) {        
        return aView;     
    }
	
    for (UIView *subView in aView.subviews) {
        UIView *firstResponder = [self findFirstResonder:subView];
        if (firstResponder != nil) {
			return firstResponder;
        }
    }
	
    return nil;
}

- (UIView *)findFirstResonder {
	return [self findFirstResonder:[[UIApplication sharedApplication] keyWindow]];
}

- (UITextField*) findCurrentTextField {
	UIView *currentResponder = [self findFirstResonder:[[UIApplication sharedApplication] keyWindow]];
	if ([currentResponder isKindOfClass:[UITextField class]]) {
		return (UITextField*)currentResponder;
	} else {
		return nil;
	}
}

@end
