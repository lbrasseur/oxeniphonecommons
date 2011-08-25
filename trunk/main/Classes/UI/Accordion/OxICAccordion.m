//
//  OxICAccordion.m
//  RecetarioiPhone
//
//  Created by Lautaro Brasseur on 18/08/11.
//  Copyright 2011 Oxen Software Studio. All rights reserved.
//

#import "OxICAccordion.h"
#import "OxICAccordionSection.h"

@interface OxICAccordion()
@property (nonatomic, retain) NSMutableArray* sections;
@property (nonatomic, assign) float collapsedHeight;
@end


@implementation OxICAccordion
@synthesize sections, collapsedHeight;

#pragma mark Init and dealloc
- (id)initWithFrame:(CGRect)frame {
    if ((self = [super initWithFrame:frame])) {
		self.collapsedHeight = 25;
		self.sections = [NSMutableArray arrayWithCapacity:10];
		self.contentSize = CGSizeMake(frame.size.width, 0);
    }
    return self;
}

- (void)dealloc {
	self.sections = nil;
    [super dealloc];
}

#pragma mark Inteface methods

- (void) addSection: (NSString*) title
		withContent: (UIView*) content {
	
	int position = [self.sections count];
	
	OxICAccordionSection *section = [[OxICAccordionSection alloc] initWithFrame:CGRectMake(0, position * self.collapsedHeight, self.frame.size.width, self.collapsedHeight)
																	  andParent: self
																	   andTitle: title
																	 andContent: content
																	andPosition: position];
	[self addSubview:section];
	[self.sections addObject:section];
	[section release];
	
	float newContentHeight = self.frame.size.height - ([self.sections count] * self.collapsedHeight);
	for (OxICAccordionSection *section in self.sections) {
		section.contentHeight = newContentHeight;
	}
}

- (void) expand: (int) sectionPosition {
	int currentPosition = 0;
	int sectionCount = [self.sections count];
	[UIView beginAnimations:@"accordion" context:NULL];
	for (OxICAccordionSection *section in self.sections) {
		float yPosition;
		
		if (currentPosition <= sectionPosition) {
			yPosition = currentPosition * self.collapsedHeight;
		} else {
			yPosition = self.frame.size.height - ((sectionCount - currentPosition) * self.collapsedHeight);
		}
		
		
		if (currentPosition == sectionPosition) {
			[section expand];
		} else {
			[section collapse];
		}
		
		section.frame = CGRectMake(0, yPosition, self.frame.size.width, self.collapsedHeight);

		currentPosition++;
	}
	[UIView commitAnimations];
	
	//self.contentSize = CGSizeMake(self.contentSize.width, currentY);
}


@end
