//
//  AViewController.h
//  OxeniPhoneCommonsSamples
//
//  Created by Lautaro Brasseur on 19/07/10.
//  Copyright 2010 Oxen Software Studio. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AService.h"

@interface AViewController : UIViewController {
	id<AService> service;
	UITextField *textField;
}

@property (retain, nonatomic) IBOutlet id<AService> service;
@property (retain, nonatomic) IBOutlet UITextField *textField;

- (IBAction) method: (id) sender;

@end
