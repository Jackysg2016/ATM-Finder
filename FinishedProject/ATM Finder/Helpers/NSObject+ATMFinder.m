//
//  NSObject+ATMFinder.m
//  ATM Finder
//
//  Created by Archibald on 9/21/15.
//  Copyright © 2015 Buy n Large. All rights reserved.
//

#import "NSObject+ATMFinder.h"

@implementation NSObject (ATMFinder)

-(id)valueOrNil
{
    return [self isMemberOfClass:[NSNull class]] ? nil : [self copy];
}
@end
