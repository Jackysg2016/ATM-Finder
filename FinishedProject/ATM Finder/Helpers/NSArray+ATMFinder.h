//
//  NSArray+ATMFinder.h
//  ATM Finder
//
//  Created by Archibald on 9/21/15.
//  Copyright © 2015 Buy n Large. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (ATMFinder)

+(NSArray *)atmsFromServerData:(NSData *)data;

@end
