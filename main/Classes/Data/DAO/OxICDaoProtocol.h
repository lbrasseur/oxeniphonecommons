//
//  OxICDaoProtocol.h
//
//  Created by Lautaro Brasseur on 30/07/11.
//  Copyright Oxen Software Studio 2011. All rights reserved.
//

#import <Foundation/Foundation.h>

/*!
 Generic protocol to be implemented by DAOs.
 */
@protocol OxICDaoProtocol
/*!
 Inserts a new object.
 */
- (id) insertNewObject;

/*!
 Deletes an object.
 */
- (void) delete:(id) anObject;

/*!
 Flushes pending changes.
 */
- (void) flush;

/*!
 Reads all the object from the database.
 */
- (NSArray*) findAll;

/*!
 Finds the first object.
 */
- (id) findFirst;

/*!
 Reads the objects with filter 
 */
- (NSArray*) findWithFilter:(NSString*)filter;

/*!
 Reads the objects with filter and sort descriptors
 */
- (NSArray*) findWithFilter:(NSString*)filter andSortField:(NSString*) aSortField;

/*!
 Reads the objects with filter and sort descriptors
 */
- (NSArray*) findWithFilter:(NSString*)filter andSortFields:(NSArray*) sortFields;


@end

