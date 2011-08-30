//
//  OxICInteractiveSelector.h
//  OxeniPhoneCommons
//
//  Created by Lautaro Brasseur on 25/08/11.
//  Copyright 2011 Oxen Software Studio. All rights reserved.
//

#import <UIKit/UIKit.h>
@class OxICInteractiveSelector;

@protocol OxICInteractiveSelectorDelegate
- (void) selected:(id) identifier
	   onSelector:(OxICInteractiveSelector*) selector;
@end


@interface OxICInteractiveSelector : UIScrollView<UISearchBarDelegate> {
	float optionSize;
	NSMutableArray* options;
	id<OxICInteractiveSelectorDelegate> selectorDelegate;
}

@property (nonatomic, retain) id<OxICInteractiveSelectorDelegate> selectorDelegate;

- (void) addOption:(id) identifier
		 withLabel:(NSString*) label;

- (void) setOption:(id) identifier
	  withSelected:(BOOL) selected;

@end
