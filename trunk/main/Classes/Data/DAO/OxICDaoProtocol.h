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


@end

