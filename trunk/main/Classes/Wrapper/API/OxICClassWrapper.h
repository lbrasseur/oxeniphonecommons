//
//  OxICClassWrapper.h
//  OxeniPhoneCommons
//
//  Created by Lautaro Brasseur on 18/07/10.
//  Copyright 2010 Oxen Software Studio. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OxICPropertyDescriptor.h"

@protocol OxICClassWrapper
/**
 * Gets the property descriptors.
 * 
 * @return An array with the descriptors of the properties
 */
- (NSArray*) getPropertyDescriptors;

/**
 * Gets the property descriptor.
 * 
 * @param propertyName
 *            The property
 * @return A property descriptor
 */
- (OxICPropertyDescriptor*) getPropertyDescriptor: (NSString*) propertyName;

/**
 * Determines if a property exists.
 * 
 * @param propertyName
 *            The property name
 * @return Treu if the property exists
 */
- (BOOL) hasProperty:(NSString*) propertyName;

/**
 * Creates a new object.
 * @return The new object
 */
- (id) newObject;

@end
