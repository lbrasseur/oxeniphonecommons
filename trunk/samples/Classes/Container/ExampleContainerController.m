//
//  ExampleContainerController.m
//  OxeniPhoneCommonsSamples
//
//  Created by Lautaro Brasseur on 05/08/11.
//  Copyright 2011 Oxen Software Studio. All rights reserved.
//

#import "ExampleContainerController.h"
#import "OxICContainer.h"

@implementation ExampleContainerController
@synthesize messageLabel,exampleService;

IoCName(exampleContainerController)
IoCSingleton
IoCInject(exampleService,exampleService)

- (IBAction) sayHiByUi {
	self.messageLabel.text = [self.exampleService sayHi];
}

- (void)dealloc {
    [super dealloc];
}


@end
