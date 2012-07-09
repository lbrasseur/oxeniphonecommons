//
//  OxICBaseDao.m
//  RecetarioiPhone
//
//  Created by Lautaro Brasseur on 30/07/11.
//  Copyright Oxen Software Studio 2011. All rights reserved.
//

#import "OxICBaseDao.h"

@interface OxICBaseDao()
- (void) raiseError:(NSError*) error;
- (id) extractFirst:(NSArray*) objects;
@end


@implementation OxICBaseDao

@synthesize managedObjectContext;
@synthesize entityName;
@synthesize sortField;

- (id) initWithEntity: (NSString*) anEntityName
			  andSort: (NSString*) aSortField {
	if (self = [super init]) {
		self.entityName = anEntityName;
		self.sortField = aSortField;
		self.managedObjectContext = nil;
	}
	return self;
}

- (id) insertNewObject {
	return [NSEntityDescription insertNewObjectForEntityForName: self.entityName
										 inManagedObjectContext: self.managedObjectContext];
}

- (void) delete:(id) anObject {
	[self.managedObjectContext deleteObject:anObject];
}

- (void) flush {
	NSError* error = nil;
	if(![self.managedObjectContext save:&error]) {
		[self raiseError:error];
	}	
}

- (void) reset {
	[self.managedObjectContext reset];
}

- (NSArray*) findAll {
	NSArray *sortFields = nil;
	
	if (self.sortField != nil) {
		sortFields = [NSArray arrayWithObject:self.sortField];
	}
	
	return [self findWithQuerySpec:[OxICQuerySpec withSortFields:sortFields]
					  andArguments:nil];
}

- (id) findFirst {
	return [self findWithQuerySpec:[OxICQuerySpec withUnique:YES]
					  andArguments:nil];
}

- (id) findFirstWithFilter:(NSString*)filter {
	return [self findWithQuerySpec:[OxICQuerySpec withFilter:filter
												   andUnique:YES]
					  andArguments:nil];
}

- (NSArray*) findWithFilter:(NSString*)filter {
	return [self findWithQuerySpec:[OxICQuerySpec withFilter:filter]
					  andArguments:nil];
}

- (NSArray*) findWithFilter:(NSString*)filter andSortField:(NSString*) aSortField {
	return [self findWithQuerySpec:[OxICQuerySpec withFilter:filter
											   andSortFields:[NSArray arrayWithObject:aSortField]]
					  andArguments:nil];
}

- (NSArray*) findWithFilter:(NSString*) filter
			  andSortFields:(NSArray*) sortFields {
	return [self findWithQuerySpec:[OxICQuerySpec withFilter:filter
											   andSortFields:sortFields]
					  andArguments:nil];
}


- (id) findWithQuerySpec:(OxICQuerySpec*) querySpec
			andArguments:(NSArray*)arguments {
	NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
	
	[fetchRequest setEntity:[NSEntityDescription entityForName:self.entityName
										inManagedObjectContext: self.managedObjectContext]];
	
	if (querySpec.filter != nil) {
		NSPredicate *predicate;
		
		if (arguments == nil) {
			predicate = [NSPredicate predicateWithFormat:querySpec.filter];
		} else {
			predicate = [NSPredicate predicateWithFormat:querySpec.filter
										   argumentArray:arguments];
		}

		[fetchRequest setPredicate:predicate];
	}
	
	if (querySpec.sortFields != nil) {
		NSMutableArray *sortDescriptors = [NSMutableArray arrayWithCapacity:[querySpec.sortFields count]];
		
		for (NSString *currentField in querySpec.sortFields) {
			NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:currentField
																		   ascending:YES];
			[sortDescriptors addObject:sortDescriptor];
			[sortDescriptor release];
		}
		
		[fetchRequest setSortDescriptors:sortDescriptors];
	}
	
	NSError *error;
	NSArray *fetchResults = [managedObjectContext executeFetchRequest:fetchRequest
																error:&error];
	[fetchRequest release];
	
	if (fetchResults == nil) {
		[self raiseError:error];
	}
	
	if (querySpec.unique) {
		return [self extractFirst:fetchResults];
	} else {
		return fetchResults;
	}
}

#pragma mark -
#pragma mark Memory management

- (void)dealloc {
	self.entityName = nil;
	self.sortField = nil;
	self.managedObjectContext = nil;
	[super dealloc];
}

#pragma mark Private methods
- (void) raiseError:(NSError*) error {
#ifdef DEBUG
	NSLog(@"OxICBaseDao error localizedDescription: %@", [error localizedDescription]);
	NSLog(@"OxICBaseDao error userInfo: %@", [error userInfo]);
#endif
	NSException* exception = [NSException
							  exceptionWithName:[error localizedDescription]
							  reason:[error description]
							  userInfo:[error userInfo]];
	@throw exception;
	
}

- (id) extractFirst:(NSArray*) objects {
	id value = nil;
	
	if ([objects count] > 0) {
		value = [objects objectAtIndex: 0];
	}
	
	return value;
}

@end
