//
//  OxeniPhoneCommonsSamplesAppDelegate.m
//  OxeniPhoneCommonsSamples
//
//  Created by Lautaro Brasseur on 18/07/10.
//  Copyright Oxen Software Studio 2010. All rights reserved.
//

#import "OxeniPhoneCommonsSamplesAppDelegate.h"
#import "OxeniPhoneCommonsSamplesViewController.h"

@implementation OxeniPhoneCommonsSamplesAppDelegate

@synthesize window;
@synthesize viewController;


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {    
    
    // Override point for customization after app launch    
    [window addSubview:viewController.view];
    [window makeKeyAndVisible];
	
	return YES;
}


- (void)dealloc {
    [viewController release];
    [window release];
    [super dealloc];
}


@end
