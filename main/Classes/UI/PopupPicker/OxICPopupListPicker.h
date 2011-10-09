//
//  OxICPopupListPicker.h
//  OxeniPhoneCommons
//
//  Created by Lautaro Brasseur on 08/10/11.
//  Copyright 2011 Oxen Software Studio. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface OxICPopupListPicker : UIView<UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource, UIActionSheetDelegate> {
	UITextField *textField;
	NSMutableArray *identifiers;
	NSMutableArray *labels;
	NSInteger selectedRow;
	NSInteger pickerSelectedRow;
}

- (void) addOption:(id) identifier
		 withLabel:(NSString*) label;

@property (nonatomic, retain) id selected;


@end
