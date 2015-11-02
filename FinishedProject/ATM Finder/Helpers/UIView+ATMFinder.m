//
//  UIView+ATMFinder.m
//  ATM Finder
//
//  Created by Archibald on 9/22/15.
//  Copyright © 2015 Buy n Large. All rights reserved.
//

#import "UIView+ATMFinder.h"

@implementation UIView (ATMFinder)

-(UIView *)superviewOfType:(Class)superviewClass
{
    if (!self.superview){
        return nil;
    }
    if ([self.superview isKindOfClass:superviewClass]){
        return self.superview;
    }
    return [self.superview superviewOfType:superviewClass];
}

@end
