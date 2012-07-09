//
//  OxICAccordionSection.h
//  RecetarioiPhone
//
//  Created by Lautaro Brasseur on 18/08/11.
//  Copyright 2011 Oxen Software Studio. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OxICAccordion.h"

@interface OxICAccordionSection : UIView {
	OxICAccordion *parent;
	BOOL collapsedFlag;
	int position;
	UIView* titleView;
	UIView* content;
	float contentHeight;
	float collapsedHeight;
}

- (id) initWithFrame:(CGRect)frame
		   andParent:(OxICAccordion*) parentAccordion
		    andTitle:(UIView*) title
		    andContent:(UIView*) sectionContent
		 andPosition:(int) sectionPosition;


- (void) collapse;

- (void) expand;

@property (nonatomic, assign) float contentHeight;
@property (nonatomic, retain) UIView* titleView;

@end
