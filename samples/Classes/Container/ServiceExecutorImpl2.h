//
//  ServiceExecutorImpl2.h
//  Otra
//
//  Created by Facundo Fumaneri on 12/27/10.
//  Copyright 2010 Oxen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ServiceExecutor.h"
#import "ExampleService.h"

@interface ServiceExecutorImpl2 : NSObject<ServiceExecutor> {
	id<ExampleService> service;
}

@property (retain, nonatomic) id<ExampleService> service;
@end
