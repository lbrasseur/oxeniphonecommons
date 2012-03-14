//
//  OxICQuerySpec.h
//  OxeniPhoneCommons
//
//  Created by Lautaro Brasseur on 03/02/12.
//  Copyright 2012 Oxen Software Studio. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface OxICQuerySpec : NSObject {
	NSString *filter;
	NSArray *sortFields;
	BOOL unique;
}

@property (retain, nonatomic) NSString* filter;
@property (retain, nonatomic) NSArray* sortFields;
@property (assign, nonatomic) BOOL unique;

- (id) initWithFilter:(NSString*) filter
		andSortFields:(NSArray*) sortFields
			andUnique:(BOOL) unique;

+ (id) withFilter:(NSString*) filter;

+ (id) withUnique:(BOOL) unique;

+ (id) withSortFields:(NSArray*) sortFields;

+ (id) withFilter:(NSString*) filter
	andSortFields:(NSArray*) sortFields;

+ (id) withFilter:(NSString*) filter
		andUnique:(BOOL) unique;

+ (id) withFilter:(NSString*) filter
	andSortFields:(NSArray*) sortFields
		andUnique:(BOOL) unique;

@end
