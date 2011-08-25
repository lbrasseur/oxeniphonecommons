//
//  OxICAccordion.h
//  RecetarioiPhone
//
//  Created by Lautaro Brasseur on 18/08/11.
//  Copyright 2011 Oxen Software Studio. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface OxICAccordion : UIView {
	float collapsedHeight;
	float contentHeight;
	NSMutableArray* sections;
}

- (void) addSection: (NSString*) title
		withContent: (UIView*) content;

- (void) expand: (int) sectionPosition;

@end
