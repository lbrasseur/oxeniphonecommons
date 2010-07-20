//
//  ContainerSampleViewController.h
//  OxeniPhoneCommonsSamples
//
//  Created by Lautaro Brasseur on 19/07/10.
//  Copyright 2010 Oxen Software Studio. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OxICContainerBuilderDelegate.h"

@interface ContainerSampleViewController : UIViewController<OxICContainerBuilderDelegate> {
}

- (IBAction) withoutLazy: (id) sender;
- (IBAction) withLazy: (id) sender;
- (IBAction) withXmlContext: (id) sender;


@end
