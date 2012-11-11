//
//  OxICInteractiveSelector.h
//  OxeniPhoneCommons
//
//  Created by Lautaro Brasseur on 25/08/11.
//  Copyright 2011 Oxen Software Studio. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OxICInteractiveSelectorOption.h"

@class OxICInteractiveSelector;

@protocol OxICInteractiveSelectorDelegate<NSObject>
- (void) selected:(id) identifier
	   onSelector:(OxICInteractiveSelector*) selector;
@optional
- (void) searchBarDidBeginEditing:(UISearchBar*) searchBar
					   onSelector:(OxICInteractiveSelector*) selector;
- (void) searchBarDidEndEditing:(UISearchBar*) searchBar
					 onSelector:(OxICInteractiveSelector*) selector;
@end


@interface OxICInteractiveSelector : UIView<UISearchBarDelegate> {
	float optionWidth;
	float optionHeight;
	float margin;
	NSMutableArray* options;
	id<OxICInteractiveSelectorDelegate> selectorDelegate;
	BOOL vertical;
	UIScrollView *scrollView;
}

@property (nonatomic, retain) id<OxICInteractiveSelectorDelegate> selectorDelegate;
@property (nonatomic, assign) BOOL vertical;
@property (nonatomic, assign) float optionWidth;
@property (nonatomic, assign) float optionHeight;
@property (nonatomic, assign) UIScrollView *scrollView;

- (OxICInteractiveSelectorOption*) addOption:(id) identifier
		 withLabel:(NSString*) label;

- (void) setOption:(id) identifier
	  withSelected:(BOOL) selected;

- (OxICInteractiveSelectorOption*) getOption:(id) identifier;

-(void) setMargin:(float)aMargin;
-(float) getMargin;
@end
