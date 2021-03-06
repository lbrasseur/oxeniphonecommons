//
//  OxICInteractiveSelectorOption.m
//  OxeniPhoneCommons
//
//  Created by Lautaro Brasseur on 25/08/11.
//  Copyright 2011 Oxen Software Studio. All rights reserved.
//

#import "OxICInteractiveSelectorOption.h"
#import "OxICInteractiveSelector.h"

@interface OxICInteractiveSelectorOption()
@property (nonatomic, retain) OxICInteractiveSelector *parent;
@end

@implementation OxICInteractiveSelectorOption
@synthesize identifier, label, selected, visible, parent;

- (id) initWithFrame:(CGRect)frame
	   andIdentifier:(id) optionIdentifier
			andLabel:(NSString*) aLabel
		   andParent:(OxICInteractiveSelector*) parentSelector {
	
    if ((self = [super initWithFrame:frame])) {
		self.selected = NO;
		self.visible = YES;
		self.parent = parentSelector;
		self.identifier = optionIdentifier;
		self.label = aLabel;
		
		UIButton *labelButton = [UIButton buttonWithType:UIButtonTypeCustom];
		[labelButton setTitle:self.label forState:UIControlStateNormal];
		labelButton.frame = CGRectMake(0, 0, frame.size.width, frame.size.height);
		[labelButton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
		labelButton.titleLabel.font = [UIFont fontWithName:@"Arial Rounded MT Bold" size:(12.0)];
		labelButton.titleLabel.textColor = [UIColor blackColor];
		labelButton.tag = 111;
		[self addSubview:labelButton];
		
    }
    return self;
}
-(UIButton*) optionButton {
	return (UIButton*)[self viewWithTag:111];
}

- (void)dealloc {
	self.parent = nil;
	self.identifier = nil;
	self.label = nil;
    [super dealloc];
}

#pragma mark Events
- (void) buttonClick:(id) sender {
	[self.parent setOption:self.identifier withSelected:YES];
}

@end
