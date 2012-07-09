//
//  OxICPopupDatePicker.m
//  OxeniPhoneCommons
//
//  Created by Lautaro Brasseur on 08/10/11.
//  Copyright 2011 Oxen Software Studio. All rights reserved.
//

#import "OxICPopupDatePicker.h"
#import "OxICViewUtils.h"

@interface OxICPopupDatePicker()
- (void) showPicker;
@property (nonatomic, retain) UITextField *textField;
@property (nonatomic, retain) UIDatePicker *datePicker;
@end

@implementation OxICPopupDatePicker
@synthesize date;
@synthesize datePickerMode;
@synthesize textField;
@synthesize datePicker;
@synthesize pickerDelegate;

#pragma mark Initialization and dealloc
- (void)initialize {
	self.date = nil;
	self.datePickerMode = UIDatePickerModeDateAndTime;
	
	UITextField *aTextField = [[UITextField alloc] initWithFrame:CGRectMake(0,
																			0,
																			self.frame.size.width,
																			self.frame.size.height)];
	self.textField = aTextField;
	[aTextField release];
	
	self.textField.delegate = self;
	[self addSubview:self.textField];
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
	self.datePicker = nil;
	self.textField = nil;
	self.pickerDelegate = nil;
    [super dealloc];
}

#pragma mark Interface methods
- (void) setDate:(NSDate *) aDate {
	if (date != aDate) {
        [date release];
        date = [aDate copy];
		
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

#pragma mark Private methods
- (void) showPicker {
	OxICViewUtils *viewUtils = [[OxICViewUtils alloc] init];
	[[viewUtils findCurrentTextField] resignFirstResponder];
	[viewUtils release];
	
	UIActionSheet *menu = [[UIActionSheet alloc] initWithTitle:nil
													  delegate:self
											 cancelButtonTitle:NSLocalizedString(@"Done", @"Done")
										destructiveButtonTitle:NSLocalizedString(@"Cancel", @"Cancel")
											 otherButtonTitles:nil];
	
	// Add the picker
    UIDatePicker *aPicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0,150,0,216)];
	self.datePicker = aPicker;
    [aPicker release];
	
	if (self.date != nil) {
		self.datePicker.date = self.date;
	}
	self.datePicker.datePickerMode = self.datePickerMode;
	[menu addSubview:self.datePicker];
	[menu showInView:[[UIApplication sharedApplication] keyWindow]];
	[menu setBounds:CGRectMake(0,0,320, 575)];
	
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

		if (self.pickerDelegate != nil) {
			[self.pickerDelegate onDateSelection:self];
		}
	}
	self.datePicker = nil;
}
@end
