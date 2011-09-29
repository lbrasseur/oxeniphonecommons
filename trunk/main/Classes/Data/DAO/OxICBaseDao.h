//
//  OxICBaseDao.h
//
//  Created by Lautaro Brasseur on 30/07/11.
//  Copyright Oxen Software Studio 2011. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "OxICDaoProtocol.h"

/*!
 Base class for DAOs.
 */
@interface OxICBaseDao : NSObject<OxICDaoProtocol> {
	NSFetchedResultsController *fetchedResultsController;
	NSManagedObjectContext *managedObjectContext;
	NSString* entityName;
	NSString* sortField;
}

@property (nonatomic, retain) NSFetchedResultsController *fetchedResultsController;
@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, retain) NSString* entityName;
@property (nonatomic, retain) NSString* sortField;

- (id) initWithEntity: (NSString*) anEntityName
			  andSort: (NSString*) aSortField;


@end
