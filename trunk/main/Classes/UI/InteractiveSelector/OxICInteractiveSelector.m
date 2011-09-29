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
@synthesize options, optionWidth, optionHeight, selectorDelegate;

#pragma mark Init and dealloc
- (id)initWithFrame:(CGRect)frame {
    if ((self = [super initWithFrame:frame])) {
		self.optionWidth = frame.size.height + 30;
		self.optionHeight = frame.size.height;		
		self.options = [NSMutableArray arrayWithCapacity:10];
		self.scrollEnabled = YES;
		self.selectorDelegate = nil;
    }
    return self;
}

- (void)dealloc {
	self.options = nil;
	self.selectorDelegate = nil;
    [super dealloc];
}

#pragma mark interface methods
- (void) addOption:(id) identifier
		 withLabel:(NSString*) label {
	float optionButtonSize = self.optionWidth - (BUTTON_MARGIN * 2);
	OxICInteractiveSelectorOption* option = [[OxICInteractiveSelectorOption alloc] initWithFrame:CGRectMake([self.options count] * self.optionWidth + BUTTON_MARGIN,
																											BUTTON_MARGIN,
																											optionButtonSize,
																											self.optionHeight - (BUTTON_MARGIN * 2))
																				   andIdentifier:identifier
																						andLabel:label
																					   andParent:self];
	[self addSubview:option];
	[self.options addObject:option];
	[option release];
	
	self.contentSize = CGSizeMake([self.options count] * self.optionWidth, self.optionHeight);
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
			option.frame = CGRectMake(visibleCount * self.optionHeight + BUTTON_MARGIN,
									  option.frame.origin.y,
									  option.frame.size.width,
									  option.frame.size.height);
			visibleCount ++;
			option.hidden = NO;
		} else {
			option.hidden = YES;
		}
	}
	
	self.contentSize = CGSizeMake(visibleCount * self.optionWidth, self.optionHeight);
	
	[UIView commitAnimations];
}


@end
