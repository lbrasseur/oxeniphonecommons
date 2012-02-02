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
@end


@implementation OxICBaseDao

@synthesize fetchedResultsController,managedObjectContext,entityName,sortField;

- (id) initWithEntity: (NSString*) anEntityName
			  andSort: (NSString*) aSortField {
	if (self = [super init]) {
		self.entityName = anEntityName;
		self.sortField = aSortField;
		self.fetchedResultsController = nil;
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

- (NSArray*) findAll {
	NSError *error = nil; 
	if (![self.fetchedResultsController performFetch:&error]) { 
		[self raiseError:error];
	} 
	
	return [self.fetchedResultsController fetchedObjects];
}

- (id) findFirst {
	NSArray *objects = [self findAll];
	
	id value = nil;
	
	if ([objects count] > 0) {
		value = [objects objectAtIndex: 0];
	}
	
	return value;
}

- (NSArray*) findWithFilter:(NSString*)filter {
	return [self findWithFilter:filter andSortField:sortField];
}

- (NSArray*) findWithFilter:(NSString*)filter andSortField:(NSString*) aSortField {
	return [self findWithFilter:filter andSortFields:[NSArray arrayWithObject:aSortField]];
}
/*!
 Reads the objects with filter and sort descriptors
 */
- (NSArray*) findWithFilter:(NSString*)filter andSortFields:(NSArray*) sortFields {
	NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
	NSEntityDescription *entity = 
	[NSEntityDescription entityForName: self.entityName
				inManagedObjectContext: self.managedObjectContext ];
	[fetchRequest setEntity:entity];
	
	NSPredicate *predicate = [NSPredicate predicateWithFormat: filter];
	[fetchRequest setPredicate: predicate];
	
	
	NSMutableArray *sortDescriptors = [[NSMutableArray alloc] init];
	NSSortDescriptor *sortDescriptor;
	for (NSString *aSortField in sortFields) {
		sortDescriptor = [[NSSortDescriptor alloc] 
						  initWithKey:aSortField ascending:YES];
		[sortDescriptors addObject:sortDescriptor];
		[sortDescriptor release];
	}
	[fetchRequest setSortDescriptors:sortDescriptors];
	
	[sortDescriptors release];
	
	NSError *error;
	NSArray *fetchResults = [managedObjectContext executeFetchRequest: fetchRequest error: &error];
	[fetchRequest release];
	
	if (fetchResults == nil) {
		[self raiseError:error];
	}
	
	return fetchResults;	
	
}

- (NSFetchedResultsController*) fetchedResultsController {
	if (fetchedResultsController != nil) {
		return fetchedResultsController;
	}
	
	NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
	NSEntityDescription *entity = [NSEntityDescription entityForName: self.entityName
											  inManagedObjectContext: self.managedObjectContext ];
	[fetchRequest setEntity:entity];
	
	NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:sortField ascending:YES];
	[fetchRequest setSortDescriptors:[NSArray arrayWithObject:sortDescriptor]];

	NSFetchedResultsController *aFetchedResultsController = 
	[[NSFetchedResultsController alloc] initWithFetchRequest: fetchRequest 
										managedObjectContext: self.managedObjectContext
										  sectionNameKeyPath: nil
												   cacheName: self.entityName];
	
	self.fetchedResultsController = aFetchedResultsController;
	
	[aFetchedResultsController release];
	[fetchRequest release];
	[sortDescriptor release];
	
	return fetchedResultsController;
}    


#pragma mark -
#pragma mark Memory management

- (void)dealloc {
	self.entityName = nil;
	self.sortField = nil;
	self.fetchedResultsController = nil;
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

@end
