//
//  OxICQuerySpec.m
//  OxeniPhoneCommons
//
//  Created by Lautaro Brasseur on 03/02/12.
//  Copyright 2012 Oxen Software Studio. All rights reserved.
//

#import "OxICQuerySpec.h"


@implementation OxICQuerySpec
@synthesize filter;
@synthesize sortFields;
@synthesize unique;

- (id) initWithFilter:(NSString*) aFilter
		andSortFields:(NSArray*) aSortFields
			andUnique:(BOOL) aUnique {
	self = [super init];
	if (self != nil) {
		self.filter = aFilter;
		self.sortFields = aSortFields;
		self.unique = aUnique;
	}
	return self;
}


- (void) dealloc {
	self.filter = nil;
	self.sortFields = nil;
	[super dealloc];
}

+ (id) withFilter:(NSString*) filter {
	return [self withFilter:filter
			  andSortFields:nil
				  andUnique:NO];
}

+ (id) withUnique:(BOOL) unique {
	return [self withFilter:nil
			  andSortFields:nil
				  andUnique:unique];
}

+ (id) withSortFields:(NSArray*) sortFields {
	return [self withFilter:nil
			  andSortFields:sortFields
				  andUnique:NO];
}

+ (id) withFilter:(NSString*) filter
	andSortFields:(NSArray*) sortFields {
	return [self withFilter:filter
			  andSortFields:sortFields
				  andUnique:NO];
}

+ (id) withFilter:(NSString*) filter
		andUnique:(BOOL) unique {
	return [self withFilter:filter
			  andSortFields:nil
				  andUnique:unique];
}

+ (id) withFilter:(NSString*) filter
	andSortFields:(NSArray*) sortFields
		andUnique:(BOOL) unique {
	return [[[OxICQuerySpec alloc] initWithFilter:filter
									 andSortFields:sortFields
										andUnique:unique] autorelease];
}

@end
