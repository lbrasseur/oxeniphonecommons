//
//  ExampleServiceImpl2.m
//  Otra
//
//  Created by Facundo Fumaneri on 12/27/10.
//  Copyright 2010 Oxen. All rights reserved.
//

#import "ExampleServiceImpl2.h"


@implementation ExampleServiceImpl2
-(void) execute {
	NSLog(@"Service Implementation 2");
}
- (NSString*) sayHi {
	return @"Hi from ExampleServiceImpl2 !!!";
}
@end
