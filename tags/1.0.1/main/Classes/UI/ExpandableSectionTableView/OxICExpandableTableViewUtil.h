//
//  OxICExpandableTableViewDelegate.h
//  OxeniPhoneCommons
//
//  Created by Facundo Fumaneri on 10/5/11.
//  Copyright 2011 Oxen. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol OxICExpandableTableViewDelegate

-(void) tableView:(UITableView*)tableView didExpandSection:(NSInteger) section userInfo:(id) userInfo;
-(void) tableView:(UITableView*)tableView didCollapseSection:(NSInteger) section userInfo:(id) userInfo;

@end

@interface OxICExpandableTableViewUtil : NSObject {
	NSMutableArray *sectionTargets;
	NSMutableDictionary *sectionVisibility;
	id<OxICExpandableTableViewDelegate> delegate;
}

@property(nonatomic, assign) id<OxICExpandableTableViewDelegate> delegate;;

-(void) tableView:(UITableView*)tableView setVisibilityWithSection:(NSInteger) section andVisible:(BOOL) visible userInfoOrNil:(id)userInfo;
-(void) tableView:(UITableView*)tableView switchVisibility:(NSInteger) section userInfoOrNil:(id)userInfo;
-(void) tableView:(UITableView*)tableView addControl:(id) control forSection:(NSInteger) section userInfoOrNil:(id)userInfo;
-(BOOL) isSectionVisible:(NSInteger) section;
@end
