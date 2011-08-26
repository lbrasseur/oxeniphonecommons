//
//  OxICAccordionSection.m
//  RecetarioiPhone
//
//  Created by Lautaro Brasseur on 18/08/11.
//  Copyright 2011 Oxen Software Studio. All rights reserved.
//

#import "OxICAccordionSection.h"

@interface OxICAccordionSection()
@property (nonatomic, retain) OxICAccordion *parent;
@property (nonatomic, assign) BOOL collapsedFlag;
@property (nonatomic, assign) int position;
@property (nonatomic, retain) UIView* content;
@property (nonatomic, assign) float collapsedHeight;
@end


@implementation OxICAccordionSection
@synthesize parent, collapsedFlag, position, content, contentHeight, collapsedHeight;

# pragma mark Init and dealloc
- (id) initWithFrame:(CGRect)frame
		   andParent:(OxICAccordion*) parentAccordion
		    andTitle:(NSString*) title
		  andContent:(UIView*) sectionContent
		 andPosition:(int) sectionPosition {
	
    if ((self = [super initWithFrame:frame])) {
		self.parent = parentAccordion;
		self.collapsedFlag = YES;
		self.collapsedHeight = self.frame.size.height;
		self.position = sectionPosition;
		
		UIScrollView* contentScroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, 0)];
		sectionContent.frame = CGRectMake(0, 0, sectionContent.frame.size.width, sectionContent.frame.size.height);
		[contentScroll addSubview:sectionContent];
		self.content = contentScroll;
		[contentScroll release];
		
		[self addSubview:self.content];
		
		UIButton *labelButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
		[labelButton setTitle:title forState:UIControlStateNormal];
		labelButton.frame = CGRectMake(0, 0, frame.size.width, frame.size.height);
		[labelButton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
		
		[self addSubview:labelButton];
		
		[self collapse];
    }
    return self;
}

- (void) dealloc {
	self.parent = nil;
	self.content = nil;
    [super dealloc];
}

#pragma mark Interface methods
- (void) collapse {
	self.collapsedFlag = YES;
	self.content.frame = CGRectMake(0, self.collapsedHeight, content.frame.size.width, 0);
}

- (void) expand {
	self.collapsedFlag = NO;
	self.content.frame = CGRectMake(0, self.collapsedHeight, content.frame.size.width, self.contentHeight);
}

- (void) setContentHeight:(float) newContentHeight {
	contentHeight = newContentHeight;
	self.content.frame = CGRectMake(self.content.frame.origin.y, self.content.frame.origin.y, content.frame.size.width, contentHeight);
}

#pragma mark Events
- (void) buttonClick:(id) sender {
	if (self.collapsedFlag) {
		[self.parent expand:self.position];
	}
}

@end
