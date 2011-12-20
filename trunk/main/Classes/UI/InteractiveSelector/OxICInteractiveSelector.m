//
//  OxICInteractiveSelector.m
//  OxeniPhoneCommons
//
//  Created by Lautaro Brasseur on 25/08/11.
//  Copyright 2011 Oxen Software Studio. All rights reserved.
//

#import "OxICInteractiveSelector.h"
#import "OxICInteractiveSelectorOption.h"

#define BUTTON_MARGIN 3

@interface OxICInteractiveSelector()
- (void) redraw;
@property (nonatomic, retain) NSMutableArray* options;
@property (nonatomic, assign) float optionWidth;
@property (nonatomic, assign) float optionHeight;
@end

@implementation OxICInteractiveSelector
@synthesize options, optionWidth, optionHeight, selectorDelegate, vertical;

#pragma mark Init and dealloc
- (void) initialize {
	self.options = [NSMutableArray arrayWithCapacity:10];
	self.scrollEnabled = YES;
	self.selectorDelegate = nil;
	self.vertical = NO;
	self.backgroundColor = [UIColor whiteColor];
	self.clipsToBounds = YES;
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
	self.options = nil;
	self.selectorDelegate = nil;
    [super dealloc];
}

#pragma mark interface methods
- (OxICInteractiveSelectorOption*) addOption:(id) identifier
		 withLabel:(NSString*) label {

	CGRect optionFrame;
	if (self.vertical) {
		self.optionWidth = self.frame.size.width;
		self.optionHeight = 30;		
		optionFrame = CGRectMake(BUTTON_MARGIN,
								 [self.options count] * self.optionHeight + BUTTON_MARGIN,
								 self.optionWidth  - (BUTTON_MARGIN * 2),
								 self.optionHeight - (BUTTON_MARGIN * 2));
	} else {
		self.optionWidth = self.frame.size.height + 30;
		self.optionHeight = self.frame.size.height;		
		optionFrame = CGRectMake([self.options count] * self.optionWidth + BUTTON_MARGIN,
				   BUTTON_MARGIN,
				   self.optionWidth - (BUTTON_MARGIN * 2),
				   self.optionHeight - (BUTTON_MARGIN * 2));
		
	}

	OxICInteractiveSelectorOption* option = [[OxICInteractiveSelectorOption alloc] initWithFrame:optionFrame
																				   andIdentifier:identifier
																						andLabel:label
																					   andParent:self];
	[self addSubview:option];
	[self.options addObject:option];
	
	if (self.vertical) {
		self.contentSize = CGSizeMake(self.optionWidth, [self.options count] * self.optionHeight);
	} else {
		self.contentSize = CGSizeMake([self.options count] * self.optionWidth, self.optionHeight);
	}
	return 	[option autorelease];	

	
}

- (void) setOption:(id) identifier
	  withSelected:(BOOL) selected {
	for (OxICInteractiveSelectorOption* option in self.options) {
		if ([identifier isEqual:option.identifier]) {
			if (option.selected != selected) {
				option.selected = selected;
				[self redraw];
				if (selected && self.selectorDelegate !=nil) {
					[self.selectorDelegate selected:identifier onSelector:self];
				}
				break;
			}
		}
	}
}
- (OxICInteractiveSelectorOption*) getOption:(id) identifier {
	for (OxICInteractiveSelectorOption* option in self.options) {
		if (option.identifier == identifier) {
			return option;
		}
	}
	return nil;
}
#pragma mark UISearchBarDelegate
- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar{
	if (self.selectorDelegate !=nil) {
		[self.selectorDelegate searchBarDidBeginEditing:searchBar onSelector:self];
	}
}
- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar{
	if (self.selectorDelegate !=nil) {
		[self.selectorDelegate searchBarDidEndEditing:searchBar onSelector:self];
	}
}
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
	for (OxICInteractiveSelectorOption* option in self.options) {
		option.visible = [searchText isEqualToString:@""] || [option.label rangeOfString:searchText].location != NSNotFound;
	}
	[self redraw];
}

#pragma mark Private methods
- (void) redraw {
	[UIView beginAnimations:@"interactiveSelector" context:NULL];
	
	int visibleCount = 0;
	for (OxICInteractiveSelectorOption* option in self.options) {
		if (!option.selected && option.visible) {
			if (self.vertical) {
				option.frame = CGRectMake(option.frame.origin.x,
										  visibleCount * self.optionHeight + BUTTON_MARGIN,
										  option.frame.size.width,
										  option.frame.size.height);
			} else {
				option.frame = CGRectMake(visibleCount * self.optionWidth + BUTTON_MARGIN,
										  option.frame.origin.y,
										  option.frame.size.width,
										  option.frame.size.height);
			}

			visibleCount ++;
			option.hidden = NO;
		} else {
			option.hidden = YES;
		}
	}
	if (self.vertical) {
		self.contentSize = CGSizeMake(self.optionWidth, visibleCount * self.optionHeight);
	} else {
		self.contentSize = CGSizeMake(visibleCount * self.optionWidth, self.optionHeight);
	}

	[UIView commitAnimations];
}


@end
