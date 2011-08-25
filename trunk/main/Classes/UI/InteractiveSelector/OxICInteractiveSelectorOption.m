//
//  OxICInteractiveSelectorOption.m
//  OxeniPhoneCommons
//
//  Created by Lautaro Brasseur on 25/08/11.
//  Copyright 2011 Oxen Software Studio. All rights reserved.
//

#import "OxICInteractiveSelectorOption.h"


@implementation OxICInteractiveSelectorOption
@synthesize selected;

- (id)initWithFrame:(CGRect)frame
	  andIdentifier:(id) identifier
		   andLabel:(NSString*) label {
	
    if ((self = [super initWithFrame:frame])) {
		self.selected = NO;
		
		UIButton *labelButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
		[labelButton setTitle:label forState:UIControlStateNormal];
		labelButton.frame = CGRectMake(0, 0, frame.size.width, frame.size.height);
		//[labelButton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
		
		[self addSubview:labelButton];
		
    }
    return self;
}

- (void)dealloc {
    [super dealloc];
}

@end
