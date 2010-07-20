//
//  OxICPropertyDescriptor.m
//  OxeniPhoneCommons
//
//  Created by Lautaro Brasseur on 19/07/10.
//  Copyright 2010 Oxen Software Studio. All rights reserved.
//

#import "OxICPropertyDescriptor.h"

@interface OxICPropertyDescriptor()

@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) Class type;

@end

@implementation OxICPropertyDescriptor
@synthesize name, type;

#pragma mark Init and dealloc
- (id) initWithName:(NSString*) aName andType:(Class)aType {
	if (self = [super init]) {
		self.name = aName;
		self.type = aType;
	}
	
	return self;
}

- (void) dealloc {
	self.name = nil;
	self.type = nil;
	[super dealloc];
}


@end
