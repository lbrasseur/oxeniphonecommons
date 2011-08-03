//
//  OxICNibFactoryObject.m
//  OXENIPHONECOMMONS
//
//  Created by Lautaro Brasseur on 03/08/11.
//  Copyright 2011 Oxen Software Studio. All rights reserved.
//

#import "OxICNibFactoryObject.h"
#import <UIKit/UIKit.h>

@implementation OxICNibFactoryObject
@synthesize name, owner;

- (id) getObject {
	NSArray* nibViews = [[NSBundle mainBundle] loadNibNamed:self.name
													  owner:self.owner
													options:nil];
	
	return [nibViews objectAtIndex: 0];	
}

@end
