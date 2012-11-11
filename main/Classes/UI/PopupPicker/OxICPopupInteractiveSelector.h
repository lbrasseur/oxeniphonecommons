//
//  OxICPopupInteractiveSelector.h
//  OxeniPhoneCommons
//
//  Created by Lautaro Brasseur on 08/10/11.
//  Copyright 2011 Oxen Software Studio. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OxICInteractiveSelector.h"

@protocol OxICPopupInteractiveSelectorDelegate<NSObject>
@optional
- (void) optionCreated:(OxICInteractiveSelectorOption*) option;
@end

@interface OxICPopupInteractiveSelector : UIView<UITextFieldDelegate, OxICInteractiveSelectorDelegate, UIActionSheetDelegate> {
	UITextField *textField;
	NSMutableArray *identifiers;
	NSMutableArray *labels;
	NSArray *selectedIds;
	OxICInteractiveSelector *availableSelector;
	OxICInteractiveSelector *selectedSelector;
    id<OxICPopupInteractiveSelectorDelegate> selectorDelegate;
}

- (void) addOption:(id) identifier
		 withLabel:(NSString*) label;

@property (nonatomic, assign) NSArray* selected;
@property (nonatomic, retain, readonly) UITextField *textField;
@property (nonatomic, retain) id<OxICPopupInteractiveSelectorDelegate> selectorDelegate;

@end
