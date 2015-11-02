//
//  ATMPinAnnotationView.m
//  ATM Finder
//
//  Created by Archibald on 9/22/15.
//  Copyright © 2015 Buy n Large. All rights reserved.
//

#import "ATMPinAnnotationView.h"

#import "Constants.h"
#import "ATMMapAnnotation.h"

@interface ATMPinAnnotationView ()
{
    UILabel *minWalkLabel;
}

@end


@implementation ATMPinAnnotationView

@synthesize leftCalloutAccessoryView = _leftCalloutAccessoryView;


-(UIView *)leftCalloutAccessoryView
{
    if (!_leftCalloutAccessoryView) {
        _leftCalloutAccessoryView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 40, self.frame.size.height + 11)];
        [_leftCalloutAccessoryView setBackgroundColor:UIColorFromRGB(RGB_RED)];
        
        UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"walkIcon"]];
        [imageView setCenter:CGPointMake(_leftCalloutAccessoryView.center.x, _leftCalloutAccessoryView.center.y - 5)];
        [_leftCalloutAccessoryView addSubview:imageView];
        
        minWalkLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, _leftCalloutAccessoryView.frame.size.height - 15, 40, 10)];
        [minWalkLabel setFont:[UIFont fontWithName:FONT_HELVETICA_MEDIUM size:8]];
        [minWalkLabel setTextColor:[UIColor whiteColor]];
        [minWalkLabel setTextAlignment:NSTextAlignmentCenter];
        [_leftCalloutAccessoryView addSubview:minWalkLabel];
    }
    [self updateMinWalkLabelText];
    return _leftCalloutAccessoryView;
}

-(void)updateMinWalkLabelText
{
    ATMMapAnnotation *annotation = self.annotation;
    [minWalkLabel setText:[NSString stringWithFormat:@"%@ mts",annotation.distance]];
}

@end
