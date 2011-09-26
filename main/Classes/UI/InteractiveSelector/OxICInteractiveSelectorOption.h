//
//  OxICInteractiveSelectorOption.h
//  OxeniPhoneCommons
//
//  Created by Lautaro Brasseur on 25/08/11.
//  Copyright 2011 Oxen Software Studio. All rights reserved.
//

#import <UIKit/UIKit.h>
@class OxICInteractiveSelector;

@interface OxICInteractiveSelectorOption : UIView {
	id identifier;
	BOOL selected;
	BOOL visible;
	NSString *label;
	OxICInteractiveSelector *parent;
}

- (id) initWithFrame:(CGRect)frame
	   andIdentifier:(id) optionIdentifier
			andLabel:(NSString*) aLabel
		   andParent:(OxICInteractiveSelector*) parentSelector;
	
@property (nonatomic, assign) BOOL selected;
@property (nonatomic, assign) BOOL visible;
@property (nonatomic, retain) id identifier;
@property (nonatomic, retain) NSString *label;

@end
