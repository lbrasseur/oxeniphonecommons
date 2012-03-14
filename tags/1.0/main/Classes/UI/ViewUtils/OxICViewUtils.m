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
}
@property (assign, nonatomic) SEL selector;
@property (retain, nonatomic) id targetObject;
@property (assign, nonatomic) SEL callback;
@end

@implementation RunAsyncData
@synthesize selector;
@synthesize targetObject;
@synthesize callback;
- (void) dealloc {
	self.selector = nil;
	self.targetObject = nil;
	self.callback = nil;
	[super dealloc];
}
@end

@interface OxICViewUtils()
@property (retain, nonatomic) UIView *waitView;
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
	
	RunAsyncData *data = [[RunAsyncData alloc] init];
	data.selector = selector;
	data.targetObject = target;
	data.callback = callback;
	
	[NSThread detachNewThreadSelector:@selector(runAsync:) toTarget:self withObject:data];
	[data release];
}

- (void) runAsync:(RunAsyncData*) data {
    NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];
	
	[self showActivityIndicator];
	
	id returnedObject = [data.targetObject performSelector:data.selector];
	
	[self hideActivityIndicator];
	
	[data.targetObject performSelectorOnMainThread:data.callback withObject:returnedObject waitUntilDone:YES];

	[pool release];
}

- (void) showActivityIndicator {
	[self hideActivityIndicator];
	
	UIView *mainView = [[UIApplication sharedApplication] keyWindow];
	
	UIView *aWaitView = [[UIView alloc] initWithFrame:[[UIScreen mainScreen] applicationFrame]];
	self.waitView = aWaitView;
	[aWaitView release];
	
	[self.waitView setBackgroundColor:[UIColor blackColor]];
	[self.waitView setAlpha:0.5f];
	
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

@end
