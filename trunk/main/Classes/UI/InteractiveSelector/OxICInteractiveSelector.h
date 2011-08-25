//
//  OxICInteractiveSelector.h
//  OxeniPhoneCommons
//
//  Created by Lautaro Brasseur on 25/08/11.
//  Copyright 2011 Oxen Software Studio. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface OxICInteractiveSelector : UIScrollView {
	float optionSize;
	NSMutableArray* options;
}

- (void) addOption:(id) identifier
		 withLabel:(NSString*) label;

@end
