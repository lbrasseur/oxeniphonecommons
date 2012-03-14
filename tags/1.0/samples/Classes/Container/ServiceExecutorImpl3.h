//
//  ServiceExecutorImpl3.h
//  OxenIoc
//
//  Created by Facundo Fumaneri on 1/19/11.
//  Copyright 2011 Oxen. All rights reserved.
//

#import "ServiceExecutor.h"
#import "ExampleService.h"

@interface ServiceExecutorImpl3 : NSObject<ServiceExecutor> {
	id<ExampleService> service;
}

@property (retain, nonatomic) id<ExampleService> service;
@end
