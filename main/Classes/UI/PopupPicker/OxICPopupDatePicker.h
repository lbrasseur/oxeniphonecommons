//
//  OxICPopupPickerView.h
//  OxeniPhoneCommons
//
//  Created by Lautaro Brasseur on 08/10/11.
//  Copyright 2011 Oxen Software Studio. All rights reserved.
//

#import <UIKit/UIKit.h>

@class OxICPopupDatePicker;

@protocol OxICPopupDatePickerDelegate
- (void) onDateSelection:(OxICPopupDatePicker*) picker;
@end

@interface OxICPopupDatePicker : UIView<UITextFieldDelegate, UIActionSheetDelegate> {
	UITextField *textField;
	UIDatePicker *datePicker;
	NSDate *date;
	UIDatePickerMode datePickerMode;
	id<OxICPopupDatePickerDelegate> pickerDelegate;
}

@property (nonatomic, retain) NSDate *date;
@property (nonatomic) UIDatePickerMode datePickerMode;
@property (nonatomic, retain) id<OxICPopupDatePickerDelegate> pickerDelegate;
@property (nonatomic, retain, readonly) UITextField *textField;
@property (nonatomic, assign) NSDate *minimumDate;
@property (nonatomic, assign) NSDate *maximumDate;

- (void) enabled:(BOOL)value;

@end
