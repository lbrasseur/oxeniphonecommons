//
//  OxICViewUtils.m
//  OxeniPhoneCommons
//
//  Created by Lautaro Brasseur on 08/10/11.
//  Copyright 2011 Oxen Software Studio. All rights reserved.
//

#import "OxICViewUtils.h"

@interface RunAsyncData : NSObject {
	SEL selector;
	id targetObject;
	SEL callback;
	SEL exceptionCallback;
	UIView *waitView;
}
@property (assign, nonatomic) SEL selector;
@property (retain, nonatomic) id targetObject;
@property (assign, nonatomic) SEL callback;
@property (assign, nonatomic) SEL exceptionCallback;
@property (retain, nonatomic) UIView *waitView;
@end

@implementation RunAsyncData
@synthesize selector;
@synthesize targetObject;
@synthesize callback;
@synthesize exceptionCallback;
@synthesize waitView;
- (void) dealloc {
	self.selector = nil;
	self.targetObject = nil;
	self.callback = nil;
	self.exceptionCallback = nil;
	self.waitView = nil;
	[super dealloc];
}
@end

@interface OxICViewUtils()
@property (retain, nonatomic) UIView *waitView;
- (UIView*) createDefaultWaitView;
@end

@implementation OxICViewUtils
@synthesize waitView;

#pragma mark Memory management
- (id) init {
	self = [super init];
	if (self != nil) {
		self.waitView = nil;
	}
	return self;
}

- (void) dealloc {
	self.waitView = nil;
	[super dealloc];
}

#pragma mark Public methods
- (UIView *)findFirstResonder: (UIView *) aView{
    if (aView.isFirstResponder) {        
        return aView;     
    }
	
    for (UIView *subView in aView.subviews) {
        UIView *firstResponder = [self findFirstResonder:subView];
        if (firstResponder != nil) {
			return firstResponder;
        }
    }
	
    return nil;
}

- (UIView *)findFirstResonder {
	return [self findFirstResonder:[[UIApplication sharedApplication] keyWindow]];
}

- (UITextField*) findCurrentTextField {
	UIView *currentResponder = [self findFirstResonder:[[UIApplication sharedApplication] keyWindow]];
	if ([currentResponder isKindOfClass:[UITextField class]]) {
		return (UITextField*)currentResponder;
	} else {
		return nil;
	}
}

- (void) runAsync:(SEL) selector
	   withTarget:(id) target
	  andCallback:(SEL) callback {
	[self runAsync:selector
        withTarget:target
       andCallback:callback
       andWaitView:[self createDefaultWaitView]];
}

- (void) runAsync:(SEL) selector
	   withTarget:(id) target
	  andCallback:(SEL) callback
      andWaitView:(UIView*) aWaitView {
    
	RunAsyncData *data = [[RunAsyncData alloc] init];
	data.selector = selector;
	data.targetObject = target;
	data.callback = callback;
	data.exceptionCallback = nil;
	data.waitView = aWaitView;
	
	[NSThread detachNewThreadSelector:@selector(runAsync:)
                             toTarget:self
                           withObject:data];
	[data release];
}

- (void)    runAsync:(SEL) selector
          withTarget:(id) target
         andCallback:(SEL) callback 
andExceptionCallback:(SEL) exceptionCallback {

	[self   runAsync:selector
          withTarget:target
         andCallback:callback
andExceptionCallback:exceptionCallback 
         andWaitView:[self createDefaultWaitView]];
}

- (void)    runAsync:(SEL) selector
          withTarget:(id) target
         andCallback:(SEL) callback
andExceptionCallback:(SEL) exceptionCallback
         andWaitView:(UIView*) aWaitView {
    
	RunAsyncData *data = [[RunAsyncData alloc] init];
	data.selector = selector;
	data.targetObject = target;
	data.callback = callback;
	data.exceptionCallback = exceptionCallback;
	data.waitView = aWaitView;
	
	[NSThread detachNewThreadSelector:@selector(runAsync:)
                             toTarget:self
                           withObject:data];
	[data release];
}


- (void) runAsync:(RunAsyncData*) data {
    NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];
	
	[self showActivityIndicatorWithView:data.waitView];

    id returnedObject = nil;
    NSException *exception = nil;
    
    @try {
        returnedObject = [data.targetObject performSelector:data.selector];
	}
    @catch (NSException * e) {
        exception = e;
	}	        

	[self hideActivityIndicator];

	if (data.exceptionCallback != nil && exception != nil) {
        [data.targetObject performSelectorOnMainThread:data.exceptionCallback withObject:exception waitUntilDone:YES];
    } else {
        [data.targetObject performSelectorOnMainThread:data.callback withObject:returnedObject waitUntilDone:YES];
    }

	[pool release];
}

- (void) showActivityIndicator {
    [self showActivityIndicatorWithView:[self createDefaultWaitView]];
}

- (void) showActivityIndicatorWithView:(UIView*) aWaitView {
	[self hideActivityIndicator];
    self.waitView = aWaitView;
	
	UIView *mainView = [[UIApplication sharedApplication] keyWindow];
	
	UIActivityIndicatorView *activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
	activityIndicator.center = self.waitView.center;
	[activityIndicator startAnimating];
	
	[self.waitView addSubview:activityIndicator];
	[activityIndicator release];
	
	[mainView performSelectorOnMainThread:@selector(addSubview:)
							   withObject:self.waitView
							waitUntilDone:YES];
}

- (void) hideActivityIndicator {
	if (self.waitView != nil) {
		[self.waitView performSelectorOnMainThread:@selector(removeFromSuperview)
										withObject:nil
									 waitUntilDone:YES];
		self.waitView = nil;
	}
}

#pragma Private methods
- (UIView*) createDefaultWaitView {
    UIView *aWaitView = [[UIView alloc] initWithFrame:[[UIScreen mainScreen] applicationFrame]];
	
	[aWaitView setBackgroundColor:[UIColor blackColor]];
	[aWaitView setAlpha:0.5f];
	
    return [aWaitView autorelease];
}

@end
