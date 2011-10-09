//
//  OxICPopupDatePicker.m
//  OxeniPhoneCommons
//
//  Created by Lautaro Brasseur on 08/10/11.
//  Copyright 2011 Oxen Software Studio. All rights reserved.
//

#import "OxICPopupDatePicker.h"

@interface OxICPopupDatePicker()
- (void) showPicker;
@end

@implementation OxICPopupDatePicker
@synthesize date;
@synthesize datePickerMode;

#pragma mark Initialization and dealloc
- (void)initialize {
	self.date = nil;
	self.datePickerMode = UIDatePickerModeDateAndTime;
	
	textField = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
	textField.borderStyle = UITextBorderStyleRoundedRect;
	textField.delegate = self;
	[self addSubview:textField];
	[textField release];
}

- (void)awakeFromNib {
	[self initialize];
}

- (id)initWithFrame:(CGRect)frame {
    if ((self = [super initWithFrame:frame])) {
		[self initialize];
    }
    return self;
}

- (void)dealloc {
	self.date = nil;
    [super dealloc];
}

#pragma mark Interface methods

#pragma mark Private methods
- (void) showPicker {
	UIActionSheet *menu = [[UIActionSheet alloc] initWithTitle:nil
													  delegate:self
											 cancelButtonTitle:NSLocalizedString(@"Done", @"Done")
										destructiveButtonTitle:NSLocalizedString(@"Cancel", @"Cancel")
											 otherButtonTitles:nil];
	
	// Add the picker
	datePicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0,150,0,216)];
	
	if (self.date != nil) {
		datePicker.date = self.date;
	}
	datePicker.datePickerMode = self.datePickerMode;
	[menu addSubview:datePicker];
	[menu showInView:[[UIApplication sharedApplication] keyWindow]];
	[menu setBounds:CGRectMake(0,0,320, 575)];
	
	[datePicker release];
	[menu release];	
}


#pragma mark UITextFieldDelegate methods
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
	[self showPicker];
	return NO;
}

#pragma mark UIActionSheetDelegate methods
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
	if (buttonIndex == 1) {
		self.date = datePicker.date;
		
		NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
		
		if (self.datePickerMode == UIDatePickerModeDateAndTime || self.datePickerMode == UIDatePickerModeDate) {
			[dateFormatter setDateStyle:NSDateFormatterMediumStyle];
		} else {
			[dateFormatter setDateStyle:NSDateFormatterNoStyle];
		}
		
		if (self.datePickerMode == UIDatePickerModeDateAndTime || self.datePickerMode == UIDatePickerModeTime) {
			[dateFormatter setTimeStyle:NSDateFormatterMediumStyle];
		} else {
			[dateFormatter setTimeStyle:NSDateFormatterNoStyle];
		}
		
		textField.text = [dateFormatter stringFromDate:self.date];
		[dateFormatter release];
	}
}
@end
