//
//  OxICExpandableTableViewDelegate.m
//  OxeniPhoneCommons
//
//  Created by Facundo Fumaneri on 10/5/11.
//  Copyright 2011 Oxen. All rights reserved.
//

#import "OxICExpandableTableViewUtil.h"

@interface OxICTargetDelegate : NSObject {
	NSInteger section;
	OxICExpandableTableViewUtil *util;
	UITableView* tableView;
	id userInfo;
}

@property (assign, nonatomic) NSInteger section;
@property (assign, nonatomic) id userInfo;
@property (assign, nonatomic) OxICExpandableTableViewUtil *util;
@property (assign, nonatomic) UITableView* tableView;

-(void) sectionControlClick:(id) sender;

@end

@implementation OxICTargetDelegate
@synthesize section, util, tableView, userInfo;

-(void) sectionControlClick:(id) sender {
	[util tableView:tableView switchVisibility:section userInfoOrNil:userInfo];
}

-(void) dealloc {
	userInfo = nil;
	[super dealloc];
}
@end

@interface OxICExpandableTableViewUtil()

@property (nonatomic, retain) NSMutableArray *sectionTargets;
@property (nonatomic, retain) NSMutableDictionary *sectionVisibility;;

@end


@implementation OxICExpandableTableViewUtil
@synthesize sectionTargets, sectionVisibility, delegate;

-(id) init {
	if (self = [super init]) {
		NSMutableArray *targets = [[NSMutableArray alloc] init];
		self.sectionTargets = targets;
		[targets release];
		
		NSMutableDictionary *visivility = [[NSMutableDictionary alloc] init];
		self.sectionVisibility = visivility;
		[visivility release];
	}
	return self;
}
-(void) tableView:(UITableView*)tableView switchVisibility:(NSInteger) section userInfoOrNil:(id)userInfo{
	[self tableView:tableView setVisibilityWithSection:section andVisible:![self isSectionVisible:section] userInfoOrNil:userInfo];
}

-(void) tableView:(UITableView*)tableView setVisibilityWithSection:(NSInteger) section andVisible:(BOOL) visible userInfoOrNil:(id)userInfo{
	[self.sectionVisibility setObject:[NSNumber numberWithBool:visible] forKey:[NSNumber numberWithInt:section]];
	[tableView beginUpdates];
	if (visible) {
		NSMutableArray *indexPaths = [[NSMutableArray alloc] init];
		NSInteger rows = [tableView.dataSource tableView:tableView numberOfRowsInSection:section];
		for (int i = 0; i < rows; i++) {
			[indexPaths addObject:[NSIndexPath indexPathForRow:i inSection:section]];
		}
		[tableView insertRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationTop];
		[indexPaths release];
	} else {
		NSMutableArray *indexPaths = [[NSMutableArray alloc] init];
		NSInteger rows = [tableView numberOfRowsInSection:section];
		for (int i = 0; i < rows; i++) {
			[indexPaths addObject:[NSIndexPath indexPathForRow:i inSection:section]];
		}

		[tableView deleteRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationTop];
		[indexPaths release];		
	}
	[tableView endUpdates];
	if (visible) {
		if (delegate) {
			[delegate tableView:tableView didExpandSection:section userInfo:userInfo];
		}
	} else {
		if (delegate) {
			[delegate tableView:tableView didCollapseSection:section userInfo:userInfo];
		}
		[tableView reloadData];
	}
}

-(void) tableView:(UITableView*)tableView addControl:(id) control forSection:(NSInteger) section userInfoOrNil:(id)userInfo {
	OxICTargetDelegate *target = [[OxICTargetDelegate alloc] init];
	[target setSection:section];
	[target setUtil:self];
	[target setTableView:tableView];
	[target setUserInfo:userInfo];
	[control addTarget:target action:@selector(sectionControlClick:) forControlEvents:UIControlEventTouchUpInside];
	[self.sectionTargets addObject:target];
	[target release];
}

-(BOOL) isSectionVisible:(NSInteger) section {
	NSNumber *visible = [self.sectionVisibility objectForKey:[NSNumber numberWithInt:section]];
	if (!visible) {
		[self.sectionVisibility setObject:[NSNumber numberWithBool:NO] forKey:[NSNumber numberWithInt:section]];
		return NO;
	}
	return [visible boolValue];
}


-(void) dealloc {
	[sectionTargets release];
	[sectionVisibility release];
	[super dealloc];
}

@end
