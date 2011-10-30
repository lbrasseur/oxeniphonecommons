//
//  OxICPopupInteractiveSelector.m
//  OxeniPhoneCommons
//
//  Created by Lautaro Brasseur on 08/10/11.
//  Copyright 2011 Oxen Software Studio. All rights reserved.
//

#import "OxICPopupInteractiveSelector.h"
#import "OxICViewUtils.h"

@interface OxICPopupInteractiveSelector()
- (void) showSelector;
@property (nonatomic, retain) NSMutableArray *identifiers;
@property (nonatomic, retain) NSMutableArray *labels;
@property (nonatomic, retain) NSArray *selectedIds;
@property (nonatomic, retain) OxICInteractiveSelector *availableSelector;
@property (nonatomic, retain) OxICInteractiveSelector *selectedSelector;
@property (nonatomic, retain) UITextField *textField;

@end

@implementation OxICPopupInteractiveSelector
@synthesize labels;
@synthesize identifiers;
@synthesize selectedIds;
@synthesize availableSelector;
@synthesize selectedSelector;
@synthesize textField;

#pragma mark Initialization and dealloc
- (void)initialize {
	self.identifiers = [NSMutableArray arrayWithCapacity:10];
	self.labels = [NSMutableArray arrayWithCapacity:10];
	self.selectedIds = [NSMutableArray arrayWithCapacity:0];
	
	self.textField = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
	self.textField.borderStyle = UITextBorderStyleNone;
	self.textField.adjustsFontSizeToFitWidth = YES;
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
	self.selectedIds = nil;
	self.textField = nil;
	self.availableSelector = nil;
	self.selectedSelector = nil;
    [super dealloc];
}

#pragma mark Interface methods
- (void) addOption:(id) identifier
		 withLabel:(NSString*) label {
	[self.identifiers addObject:identifier];
	[self.labels addObject:label];
}

- (NSArray*) selected {
	return self.selectedIds;
}

- (void) setSelected:(NSArray*) selected {
	self.selectedIds = selected;
	self.textField.text = nil;
	for (NSInteger n = 0; n < [self.identifiers count]; n++) {
		id current = [self.identifiers objectAtIndex:n];
		for (id identifier in self.selectedIds) {
			if ([current isEqual:identifier]) {
				if (self.textField.text == nil) {
					self.textField.text = [self.labels objectAtIndex:n];
				} else {
					self.textField.text = [NSString stringWithFormat:@"%@, %@", self.textField.text, [self.labels objectAtIndex:n] ];
				}

				break;
			}
		}
	}
}

#pragma mark Private methods
- (void) showSelector {
	OxICViewUtils *viewUtils = [[OxICViewUtils alloc] init];
	[[viewUtils findCurrentTextField] resignFirstResponder];
	[viewUtils release];
	
	UIActionSheet *menu = [[UIActionSheet alloc] initWithTitle:nil
													  delegate:self
											 cancelButtonTitle:NSLocalizedString(@"Done", @"Done")
										destructiveButtonTitle:NSLocalizedString(@"Cancel", @"Cancel")
											 otherButtonTitles:nil];
	
	// Add the selector
	self.availableSelector = [[OxICInteractiveSelector alloc] initWithFrame:CGRectMake(0,150,320,100)];
	self.selectedSelector = [[OxICInteractiveSelector alloc] initWithFrame:CGRectMake(0,250,320,100)];
	
	self.availableSelector.backgroundColor = [UIColor clearColor];
	self.selectedSelector.backgroundColor = [UIColor clearColor];
	
	for (int n = 0; n < [self.identifiers count]; n++) {
		id identifier = [self.identifiers objectAtIndex:n];
		NSString *label = [self.labels objectAtIndex:n];
		[self.availableSelector addOption:identifier
								withLabel:label];
		[self.selectedSelector addOption:identifier
							   withLabel:label];
		[self.selectedSelector setOption:identifier withSelected:YES];
	}

	for (id identifier in self.selectedIds) {
		[self.availableSelector setOption:identifier withSelected:YES];
		[self.selectedSelector setOption:identifier withSelected:NO];
	}
	self.availableSelector.selectorDelegate = self;
	self.selectedSelector.selectorDelegate = self;
	
	[menu addSubview:availableSelector];
	[menu addSubview:selectedSelector];
	[menu showInView:[[UIApplication sharedApplication] keyWindow]];
	[menu setBounds:CGRectMake(0,0,320, 575)];
	
	[availableSelector release];
	[selectedSelector release];
	[menu release];	
}


#pragma mark UITextFieldDelegate methods
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
	[self showSelector];
	return NO;
}

#pragma mark OxICInteractiveSelectorDelegate methods
- (void) selected:(id) identifier
	   onSelector:(OxICInteractiveSelector*) selector {
	OxICInteractiveSelector* otherSelector;
	if (selector == self.availableSelector) {
		otherSelector = self.selectedSelector;
	} else {
		otherSelector = self.availableSelector;
	}
	[otherSelector setOption:identifier withSelected:NO];
}

#pragma mark UIActionSheetDelegate methods
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
	if (buttonIndex == 1) {
		NSMutableArray *newSelected = [NSMutableArray arrayWithCapacity:[self.identifiers count]];
		for (id identifier in self.identifiers) {
			if ([[self.availableSelector getOption:identifier] selected]) {
				[newSelected addObject:identifier];
			}
		}
		self.selected = newSelected;
	}
	self.availableSelector = nil;
	self.selectedSelector = nil;
}

@end
