//
//  DetailATMTableViewCell.m
//  ATM Finder
//
//  Created by Archibald on 9/23/15.
//  Copyright © 2015 Buy n Large. All rights reserved.
//

#import "DetailATMTableViewCell.h"
#import "Constants.h"

@implementation DetailATMTableViewCell

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    // Fonts
    [self.leftLabel setFont:[UIFont fontWithName:FONT_HELVETICA_LIGHT size:15]];
    [self.rightLabel setFont:[UIFont fontWithName:FONT_HELVETICA_MEDIUM size:16]];
    
    // Text Color
    [self.leftLabel setTextColor:UIColorFromRGB(RGB_RED)];
    [self.rightLabel setTextColor:UIColorFromRGB(RGB_GRAY)];
}
@end
