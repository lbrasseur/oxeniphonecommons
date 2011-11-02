//
//  OxICPopupListPicker.h
//  OxeniPhoneCommons
//
//  Created by Lautaro Brasseur on 08/10/11.
//  Copyright 2011 Oxen Software Studio. All rights reserved.
//

#import <UIKit/UIKit.h>

@class OxICPopupListPicker;

@protocol OxICPopupListPickerDelegate
- (void) onListItemSelection:(OxICPopupListPicker*) picker;
@end

@interface OxICPopupListPicker : UIView<UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource, UIActionSheetDelegate> {
	UITextField *textField;
	NSMutableArray *identifiers;
	NSMutableArray *labels;
	NSInteger selectedRow;
	NSInteger pickerSelectedRow;
	id<OxICPopupListPickerDelegate> pickerDelegate;
}

- (void) addOption:(id) identifier
		 withLabel:(NSString*) label;

- (void) clear;

@property (nonatomic, retain) id selected;
@property (nonatomic, retain) id<OxICPopupListPickerDelegate> pickerDelegate;


@end
