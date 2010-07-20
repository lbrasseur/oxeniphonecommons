//
//  AViewController.m
//  OxeniPhoneCommonsSamples
//
//  Created by Lautaro Brasseur on 19/07/10.
//  Copyright 2010 Oxen Software Studio. All rights reserved.
//

#import "AViewController.h"


@implementation AViewController
@synthesize service, textField;

- (IBAction) method: (id) sender {
	self.textField.text = [self.service sayHi:self.textField.text];
}

- (void)dealloc {
	self.textField = nil;
	self.service  = nil;
    [super dealloc];
}

@end
