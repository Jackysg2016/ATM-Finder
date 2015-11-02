//
//  OtherATMTableViewCell.m
//  ATM Finder
//
//  Created by Archibald on 9/22/15.
//  Copyright © 2015 Buy n Large. All rights reserved.
//

#import "OtherATMTableViewCell.h"
#import "Constants.h"

@implementation OtherATMTableViewCell

-(void)layoutSubviews
{
    [super layoutSubviews];

    // Fonts
    [self.nameLabel setFont:[UIFont fontWithName:FONT_HELVETICA_MEDIUM size:16]];
    [self.addressLabel setFont:[UIFont fontWithName:FONT_HELVETICA_REGULAR size:16]];
    
    // Text Color
    [self.addressLabel setTextColor:UIColorFromRGB(RGB_GRAY)];
    
    // Corner Radius
    [self.categoryIconImageView.layer setCornerRadius:5];
    [self.categoryIconImageView setClipsToBounds:YES];
    [self.categoryIconImageView setBackgroundColor:UIColorFromRGB(RGB_GRAY)];
}


@end
