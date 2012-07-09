//
//  OxeniPhoneCommonsSamplesAppDelegate.h
//  OxeniPhoneCommonsSamples
//
//  Created by Lautaro Brasseur on 18/07/10.
//  Copyright Oxen Software Studio 2010. All rights reserved.
//

#import <UIKit/UIKit.h>

@class OxeniPhoneCommonsSamplesViewController;

@interface OxeniPhoneCommonsSamplesAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    OxeniPhoneCommonsSamplesViewController *viewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet OxeniPhoneCommonsSamplesViewController *viewController;

@end

