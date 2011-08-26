//
//  OxICInteractiveSelectorOption.h
//  OxeniPhoneCommons
//
//  Created by Lautaro Brasseur on 25/08/11.
//  Copyright 2011 Oxen Software Studio. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OxICInteractiveSelector.h"

@interface OxICInteractiveSelectorOption : UIView {
	id identifier;
	BOOL selected;
	OxICInteractiveSelector *parent;
}

- (id) initWithFrame:(CGRect)frame
	   andIdentifier:(id) optionIdentifier
			andLabel:(NSString*) label
		   andParent:(OxICInteractiveSelector*) parentSelector;
	
@property (nonatomic, assign) BOOL selected;
@property (nonatomic, retain) id identifier;

@end
