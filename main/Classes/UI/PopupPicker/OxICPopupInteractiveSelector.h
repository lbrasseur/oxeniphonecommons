//
//  OxICPopupInteractiveSelector.h
//  OxeniPhoneCommons
//
//  Created by Lautaro Brasseur on 08/10/11.
//  Copyright 2011 Oxen Software Studio. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OxICInteractiveSelector.h"

@interface OxICPopupInteractiveSelector : UIView<UITextFieldDelegate, OxICInteractiveSelectorDelegate, UIActionSheetDelegate> {
	UITextField *textField;
	NSMutableArray *identifiers;
	NSMutableArray *labels;
	NSArray *selectedIds;
	OxICInteractiveSelector *availableSelector;
	OxICInteractiveSelector *selectedSelector;
}

- (void) addOption:(id) identifier
		 withLabel:(NSString*) label;

@property (nonatomic, retain) NSArray* selected;

@end
