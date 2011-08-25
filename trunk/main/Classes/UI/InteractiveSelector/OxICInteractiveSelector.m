//
//  OxICInteractiveSelector.m
//  OxeniPhoneCommons
//
//  Created by Lautaro Brasseur on 25/08/11.
//  Copyright 2011 Oxen Software Studio. All rights reserved.
//

#import "OxICInteractiveSelector.h"
#import "OxICInteractiveSelectorOption.h"

#define BUTTON_MARGIN 3

@interface OxICInteractiveSelector()
@property (nonatomic, retain) NSMutableArray* options;
@property (nonatomic, assign) float optionSize;
@end

@implementation OxICInteractiveSelector
@synthesize options, optionSize;

- (id)initWithFrame:(CGRect)frame {
    if ((self = [super initWithFrame:frame])) {
		self.optionSize = frame.size.height;
		self.options = [NSMutableArray arrayWithCapacity:10];
		self.scrollEnabled = YES;
    }
    return self;
}

- (void) addOption:(id) identifier
		 withLabel:(NSString*) label {
	float optionButtonSize = self.optionSize - (BUTTON_MARGIN * 2);
	OxICInteractiveSelectorOption* option = [[OxICInteractiveSelectorOption alloc] initWithFrame:CGRectMake([self.options count] * self.optionSize + BUTTON_MARGIN, BUTTON_MARGIN, optionButtonSize, optionButtonSize)
																				   andIdentifier:identifier
																						andLabel:label];
	[self addSubview:option];
	[self.options addObject:option];
	[option release];
	
	self.contentSize = CGSizeMake([self.options count] * self.optionSize, self.optionSize);
}

- (void)dealloc {
	self.options = nil;
    [super dealloc];
}


@end
