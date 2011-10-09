//
//  OxICPopupPickerView.h
//  OxeniPhoneCommons
//
//  Created by Lautaro Brasseur on 08/10/11.
//  Copyright 2011 Oxen Software Studio. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface OxICPopupDatePicker : UIView<UITextFieldDelegate, UIActionSheetDelegate> {
	UITextField *textField;
	UIDatePicker *datePicker;
	NSDate *date;
	UIDatePickerMode datePickerMode;
}

@property (nonatomic, retain) NSDate *date;
@property (nonatomic) UIDatePickerMode datePickerMode;

@end
