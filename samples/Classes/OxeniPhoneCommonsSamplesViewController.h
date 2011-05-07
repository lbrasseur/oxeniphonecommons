//
//  OxeniPhoneCommonsSamplesViewController.h
//  OxeniPhoneCommonsSamples
//
//  Created by Lautaro Brasseur on 18/07/10.
//  Copyright Oxen Software Studio 2010. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OxICContainerBuilderDelegate.h"

@interface OxeniPhoneCommonsSamplesViewController : UIViewController<OxICContainerBuilderDelegate> {
	UIViewController* containerSampleViewController;
}

@property (nonatomic, retain) IBOutlet UIViewController* containerSampleViewController;

- (IBAction) navigateToContainerSample;

@end

