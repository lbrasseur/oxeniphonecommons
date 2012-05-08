//
//  OxICDaoProtocol.h
//
//  Created by Lautaro Brasseur on 30/07/11.
//  Copyright Oxen Software Studio 2011. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OxICQuerySpec.h"

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
 Resets pending changes.
 */
- (void) reset;

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
- (NSArray*) findWithFilter:(NSString*) filter;

/*!
 Finds the first object with filter 
 */
- (id) findFirstWithFilter:(NSString*) filter;

/*!
 Reads the objects with filter and sort descriptors
 */
- (NSArray*) findWithFilter:(NSString*) filter
			   andSortField:(NSString*) aSortField;

/*!
 Reads the objects with filter and sort descriptors
 */
- (NSArray*) findWithFilter:(NSString*) filter
			  andSortFields:(NSArray*) sortFields;

/*!
 Reads objects according a query specification. It may return a single object or an array.
 */
- (id) findWithQuerySpec:(OxICQuerySpec*) querySpec
			andArguments:(NSArray*)arguments;

@end

