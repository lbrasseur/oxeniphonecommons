//
//  OxICScrollView.m
//  OxeniPhoneCommons
//
//  Created by Lautaro Brasseur on 25/11/11.
//  Copyright 2011 Oxen Software Studio. All rights reserved.
//

#import "OxICScrollView.h"


@implementation OxICScrollView

- (void) initialize {
	float contentWidth = 0;
	float contentHeight = 0;
	
	for (UIView *subview in self.subviews) {
		float newWidth = subview.frame.origin.x + subview.frame.size.width;
		float newHeight = subview.frame.origin.y + subview.frame.size.height;
		
		if (newWidth > contentWidth) {
			contentWidth = newWidth;
		}
		
		if (newHeight > contentHeight) {
			contentHeight = newHeight;
		}
	}
	
	self.contentSize = CGSizeMake(contentWidth,
								  contentHeight);
}


- (void)awakeFromNib {
	[self initialize];
}

@end
