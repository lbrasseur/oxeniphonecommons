//
//  ExampleContainerController.h
//  OxeniPhoneCommonsSamples
//
//  Created by Lautaro Brasseur on 05/08/11.
//  Copyright 2011 Oxen Software Studio. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ExampleService.h"

@interface ExampleContainerController : UIViewController {
	UILabel* messageLabel;
	id<ExampleService> exampleService;
}

@property (nonatomic, retain) IBOutlet UILabel* messageLabel;
@property (nonatomic, retain) IBOutlet id<ExampleService> exampleService;

- (IBAction) sayHiByUi;


@end
