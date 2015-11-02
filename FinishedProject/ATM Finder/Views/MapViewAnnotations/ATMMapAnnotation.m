//
//  ATMMapAnnotation.m
//  ATM Finder
//
//  Created by James on 02/07/2015.
//  Copyright (c) 2015 Buy n Large. All rights reserved.
//

#import "ATMMapAnnotation.h"

@implementation ATMMapAnnotation

-(NSString *)title
{
    return self.name;
}

-(NSString *)subtitle
{
    return self.address;
}

@end
