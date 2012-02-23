//
//  OxICAccordion.h
//  RecetarioiPhone
//
//  Created by Lautaro Brasseur on 18/08/11.
//  Copyright 2011 Oxen Software Studio. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol OxICAccordionDelegate

-(float) heighForTitle;
-(void) didCollapseSection:(int) section;
-(void) didExpandSection:(int) section;
@optional
-(void) prepareViewForTitleInSection:(int) section withView:(UIView*) view;
@end

@interface OxICAccordion : UIView {
	float collapsedHeight;
	float contentHeight;
	NSMutableArray* sections;
	NSObject<OxICAccordionDelegate> *delegate;
}

@property(nonatomic, assign) NSObject<OxICAccordionDelegate> *delegate;

- (void) addSection: (NSString*) title
		withContent: (UIView*) content;

- (void) addSectionWithView: (UIView*) titleView
		withContent: (UIView*) content;

- (void) expand: (int) sectionPosition;

-(UIView*) titleViewForSection:(int) section;

@end
