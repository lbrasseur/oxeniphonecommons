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
	UIView* content;
}

- (id) initWithFrame:(CGRect)frame
		   andParent:(OxICAccordion*) parentAccordion
		    andTitle:(NSString*) title
		    andContent:(UIView*) sectionContent
		 andPosition:(int) sectionPosition;


- (void) collapse;

- (void) expand;

- (void) setContentHeight:(float) contentHeight;


@end
