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
@property (nonatomic, assign) float contentHeight;
@end

@implementation OxICAccordion
@synthesize sections, collapsedHeight, contentHeight, delegate;

#pragma mark Init and dealloc
- (id)initWithFrame:(CGRect)frame {
    if ((self = [super initWithFrame:frame])) {
		self.collapsedHeight = -1.f;
		self.sections = [NSMutableArray arrayWithCapacity:10];
    }
    return self;
}

- (void)dealloc {
	self.sections = nil;
	[self.delegate release];
    [super dealloc];
}

#pragma mark Inteface methods

- (void) addSection: (NSString*) title
		withContent: (UIView*) content {
	UILabel *aLabel = [[UILabel alloc] init];
	[aLabel setText:title];
	[aLabel setBackgroundColor:[UIColor yellowColor]];
	[self addSectionWithView:aLabel withContent:content];
	[aLabel release];
}
- (void) addSectionWithView: (UIView*) titleView
		withContent: (UIView*) content {
	int position = [self.sections count];
	if (self.collapsedHeight < 0) {
		if (!delegate) {
			NSLog(@"OxICAccordion not delegate set");
			[NSException raise:NSInvalidArgumentException
						format:@"OxICAccordion not delegate set"];
			
		}
		self.collapsedHeight = [delegate heighForTitle];
	}
	OxICAccordionSection *section = [[OxICAccordionSection alloc] initWithFrame:CGRectMake(0, position * self.collapsedHeight, self.frame.size.width, self.collapsedHeight)
																	  andParent: self
																	   andTitle: titleView
																	 andContent: content
																	andPosition: position];
	[self addSubview:section];
	if ([delegate respondsToSelector:@selector(prepareViewForTitleInSection:withView:)]) {
		[self.delegate prepareViewForTitleInSection:position withView:titleView];
	}
	[self.sections addObject:section];
	[section release];
	
	self.contentHeight = self.frame.size.height - ([self.sections count] * self.collapsedHeight);
	for (OxICAccordionSection *section in self.sections) {
		section.contentHeight = self.contentHeight;
	}	
}
- (void) expand: (int) sectionPosition {
	[UIView beginAnimations:@"accordion" context:NULL];
	
	int currentPosition = 0;
	int sectionCount = [self.sections count];
	for (OxICAccordionSection *section in self.sections) {
		float yPosition;
		
		if (currentPosition <= sectionPosition) {
			yPosition = currentPosition * self.collapsedHeight;
		} else {
			yPosition = self.frame.size.height - ((sectionCount - currentPosition) * self.collapsedHeight);
		}
		
		
		if (currentPosition == sectionPosition) {
			[section expand];
			section.frame = CGRectMake(0, yPosition, self.frame.size.width, self.collapsedHeight + self.contentHeight);
		} else {
			[section collapse];
			section.frame = CGRectMake(0, yPosition, self.frame.size.width, self.collapsedHeight);
		}

		currentPosition++;
	}

	[UIView commitAnimations];
}

-(UIView*) titleViewForSection:(int) section {
	return [[self.sections objectAtIndex:section] titleView];
}


@end
