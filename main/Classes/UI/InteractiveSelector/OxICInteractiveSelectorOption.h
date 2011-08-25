//
//  OxICInteractiveSelectorOption.h
//  OxeniPhoneCommons
//
//  Created by Lautaro Brasseur on 25/08/11.
//  Copyright 2011 Oxen Software Studio. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface OxICInteractiveSelectorOption : UIView {
	BOOL selected;
}

- (id)initWithFrame:(CGRect)frame
	  andIdentifier:(id) identifier
		   andLabel:(NSString*) label;
	
@property (nonatomic, assign) BOOL selected;

@end
