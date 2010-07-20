//
//  OxeniPhoneCommonsSamplesViewController.m
//  OxeniPhoneCommonsSamples
//
//  Created by Lautaro Brasseur on 18/07/10.
//  Copyright Oxen Software Studio 2010. All rights reserved.
//

#import "OxeniPhoneCommonsSamplesViewController.h"

@implementation OxeniPhoneCommonsSamplesViewController

@synthesize containerSampleViewController;

- (IBAction) navigateToContainerSample {
	[self presentModalViewController:self.containerSampleViewController animated:YES];
}

- (void) dealloc {
	self.containerSampleViewController = nil;
	[super dealloc];
}


@end
