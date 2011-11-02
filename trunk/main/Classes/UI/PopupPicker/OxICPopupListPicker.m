//
//  OxICPopupListPicker.m
//  OxeniPhoneCommons
//
//  Created by Lautaro Brasseur on 08/10/11.
//  Copyright 2011 Oxen Software Studio. All rights reserved.
//

#import "OxICPopupListPicker.h"
#import "OxICViewUtils.h"

@interface OxICPopupListPicker()
- (void) showPicker;
@property (nonatomic, retain) NSMutableArray *identifiers;
@property (nonatomic, retain) NSMutableArray *labels;
@property (nonatomic, retain) UITextField *textField;
@end

@implementation OxICPopupListPicker
@synthesize labels;
@synthesize identifiers;
@synthesize textField;
@synthesize pickerDelegate;

#pragma mark Initialization and dealloc
- (void)initialize {
	self.identifiers = [NSMutableArray arrayWithCapacity:10];
	self.labels = [NSMutableArray arrayWithCapacity:10];
	
	selectedRow = -1;
	
	self.textField = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
	self.textField.borderStyle = UITextBorderStyleNone;
	self.textField.delegate = self;
	[self addSubview:self.textField];
	[self.textField release];
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
	self.identifiers = nil;
	self.labels = nil;
	self.textField = nil;
    [super dealloc];
}

#pragma mark Interface methods
- (void) addOption:(id) identifier
		 withLabel:(NSString*) label {
	[self.identifiers addObject:identifier];
	[self.labels addObject:label];
}

- (void) clear {
	[self.identifiers removeAllObjects];
	[self.labels removeAllObjects];
	self.textField.text = nil;
}

- (id) selected {
	if (selectedRow >= 0 && selectedRow < [self.identifiers count]) {
		return [self.identifiers objectAtIndex:selectedRow];
	} else {
		return nil;
	}
}

- (void) setSelected:(id) identifier {
	selectedRow = -1;
	textField.text = nil;
	for (NSInteger n = 0; n < [self.identifiers count]; n++) {
		id current = [self.identifiers objectAtIndex:n];
		if ([current isEqual:identifier]) {
			selectedRow = n;
			textField.text = [self.labels objectAtIndex:selectedRow];
			break;
		}
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
	UIPickerView *pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0,150,0,216)];
	
	pickerView.delegate = self;
	pickerView.showsSelectionIndicator = YES;
	
	if (selectedRow >= 0) {
		pickerSelectedRow = selectedRow;
	} else {
		pickerSelectedRow = 0;
	}

	[pickerView selectRow:selectedRow inComponent:0 animated:NO];
	
	[menu addSubview:pickerView];
	[menu showInView:[[UIApplication sharedApplication] keyWindow]];
	[menu setBounds:CGRectMake(0,0,320, 575)];
	
	[pickerView release];
	[menu release];	
}


#pragma mark UITextFieldDelegate methods
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
	if ([self.identifiers count] > 0) {
		[self showPicker];
	}
	return NO;
}

#pragma mark UIPickerViewDataSource and UIPickerViewDelegate methods
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
	return (NSString*)[self.labels objectAtIndex:row];
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
	return 1;
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
	return [self.labels count];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
	pickerSelectedRow = row;
}

#pragma mark UIActionSheetDelegate methods
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
	if (buttonIndex == 1 && pickerSelectedRow >= 0) {
		selectedRow = pickerSelectedRow;
		textField.text = [self.labels objectAtIndex:selectedRow];
		if (self.pickerDelegate != nil) {
			[self.pickerDelegate onListItemSelection:self];
		}
	}
}
@end
