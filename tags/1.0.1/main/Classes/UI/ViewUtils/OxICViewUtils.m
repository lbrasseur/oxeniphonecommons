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
	UIView *waitView;
}
@property (assign, nonatomic) SEL selector;
@property (retain, nonatomic) id targetObject;
@property (assign, nonatomic) SEL callback;
@property (retain, nonatomic) UIView *waitView;
@end

@implementation RunAsyncData
@synthesize selector;
@synthesize targetObject;
@synthesize callback;
@synthesize waitView;
- (void) dealloc {
	self.selector = nil;
	self.targetObject = nil;
	self.callback = nil;
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
	data.waitView = aWaitView;
	
	[NSThread detachNewThreadSelector:@selector(runAsync:)
                             toTarget:self
                           withObject:data];
	[data release];
}


- (void) runAsync:(RunAsyncData*) data {
    NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];
	
	[self showActivityIndicatorWithView:data.waitView];
	
	id returnedObject = [data.targetObject performSelector:data.selector];
	
	[self hideActivityIndicator];
	
	[data.targetObject performSelectorOnMainThread:data.callback withObject:returnedObject waitUntilDone:YES];

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
