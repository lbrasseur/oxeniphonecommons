//
//  OxICInteractiveSelectorOption.m
//  OxeniPhoneCommons
//
//  Created by Lautaro Brasseur on 25/08/11.
//  Copyright 2011 Oxen Software Studio. All rights reserved.
//

#import "OxICInteractiveSelectorOption.h"

@interface OxICInteractiveSelectorOption()
@property (nonatomic, retain) OxICInteractiveSelector *parent;
@end

@implementation OxICInteractiveSelectorOption
@synthesize identifier, selected, parent;

- (id) initWithFrame:(CGRect)frame
	   andIdentifier:(id) optionIdentifier
			andLabel:(NSString*) label
		   andParent:(OxICInteractiveSelector*) parentSelector {
	
    if ((self = [super initWithFrame:frame])) {
		self.selected = NO;
		self.parent = parentSelector;
		self.identifier = optionIdentifier;
		
		UIButton *labelButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
		[labelButton setTitle:label forState:UIControlStateNormal];
		labelButton.frame = CGRectMake(0, 0, frame.size.width, frame.size.height);
		[labelButton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
		
		[self addSubview:labelButton];
		
    }
    return self;
}

- (void)dealloc {
	self.parent = nil;
	self.identifier = nil;
    [super dealloc];
}

#pragma mark Events
- (void) buttonClick:(id) sender {
	[self.parent setOption:self.identifier withSelected:YES];
}

@end
