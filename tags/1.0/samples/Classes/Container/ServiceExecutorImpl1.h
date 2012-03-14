//
//  ServiceExecutor.h
//  Otra
//
//  Created by Facundo Fumaneri on 12/27/10.
//  Copyright 2010 Oxen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ExampleService.h"
#import "ServiceExecutor.h"

@interface ServiceExecutorImpl1 : NSObject<ServiceExecutor> {
	id<ExampleService> service;
}

@property (retain, nonatomic) id<ExampleService> service;

@end
