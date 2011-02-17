//
//  OxenIocAppDelegate.h
//  OxenIoc
//
//  Created by Facundo Fumaneri on 12/28/10.
//  Copyright Oxen 2010. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OxICContainer.h"
#import "OxICContainerBuilderDelegate.h"

@class OxenIocViewController;

@interface OxenIocAppDelegate : NSObject <UIApplicationDelegate, OxICContainerBuilderDelegate> {
    UIWindow *window;
    OxenIocViewController *viewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet OxenIocViewController *viewController;

- (void) buildContainerFromXml;
- (OxICContainer *) buildContainerFromCode;
- (OxICContainer *) buildContainerFromCodeAutoInject;

@end

