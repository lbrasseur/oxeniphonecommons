//
//  OxICBaseDao.m
//  RecetarioiPhone
//
//  Created by Lautaro Brasseur on 30/07/11.
//  Copyright Oxen Software Studio 2011. All rights reserved.
//

#import "OxICBaseDao.h"


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

- (NSArray*) findAll {
	NSError *error = nil; 
	if (![self.fetchedResultsController performFetch:&error]) { 
		NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
		exit(-1);
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
	NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
	NSEntityDescription *entity = 
	[NSEntityDescription entityForName: self.entityName
				inManagedObjectContext: self.managedObjectContext ];
	[fetchRequest setEntity:entity];
	
	NSPredicate *predicate = [NSPredicate predicateWithFormat: filter];
	[fetchRequest setPredicate: predicate];
	
	NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] 
										initWithKey:sortField ascending:YES];
	[fetchRequest setSortDescriptors:[NSArray arrayWithObject:sortDescriptor]];
	
	NSError *error;
	NSArray *fetchResults = [managedObjectContext executeFetchRequest: fetchRequest error: &error];
	[fetchRequest release];
	[sortDescriptor release];
	
	if (fetchResults == nil) {
		NSLog(@"Error while fetching objects: %@", [error description]);
		return nil;
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

@end
