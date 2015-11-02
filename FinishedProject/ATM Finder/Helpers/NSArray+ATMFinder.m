//
//  NSArray+ATMFinder.m
//  ATM Finder
//
//  Created by Archibald on 9/21/15.
//  Copyright © 2015 Buy n Large. All rights reserved.
//

#import "NSArray+ATMFinder.h"
#import "NSObject+ATMFinder.h"

@implementation NSArray (ATMFinder)

+(NSArray *)atmsFromServerData:(NSData *)data
{
    NSError *error;
    NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:data
                                                               options:NSJSONReadingMutableLeaves
                                                                 error:&error];
    NSArray *response =  [[dictionary objectForKey:@"response"] objectForKey:@"venues"];
    
    if ([response count] < 1) {
        return nil;
    }
    
    NSMutableArray *atmsArray = [[NSMutableArray alloc] init];
    
    for (int position = 0; position < [response count]; position ++) {
        NSMutableDictionary *atmDictionary = [[NSMutableDictionary alloc] init];
        
        NSDictionary *responseItem = response[position];
        NSDictionary *location = [responseItem objectForKey:@"location"];
        NSDictionary *contact = [responseItem objectForKey:@"contact"];
        NSArray *categories = [responseItem objectForKey:@"categories"];
                
        [atmDictionary setObject:[responseItem objectForKey:@"id"] ? : [NSNull null]forKey:@"id"];
        [atmDictionary setObject:[responseItem objectForKey:@"name"] ? : [NSNull null]forKey:@"name"];

        [atmDictionary setObject:[location objectForKey:@"address"] ? : [NSNull null] forKey:@"address"];
        [atmDictionary setObject:[location objectForKey:@"formattedAddress"] ? : [NSNull null] forKey:@"formattedAddress"];
        [atmDictionary setObject:[location objectForKey:@"distance"] ? : [NSNull null] forKey:@"distance"];
        [atmDictionary setObject:[location objectForKey:@"lat"] ? : [NSNull null] forKey:@"latitud"];
        [atmDictionary setObject:[location objectForKey:@"lng"] ? : [NSNull null] forKey:@"longitud"];
        
        [atmDictionary setObject:[contact objectForKey:@"formattedPhone"] ? : [NSNull null] forKey:@"formattedPhone"];
        //phone: "+16466026263"
        
        if ([categories count]) {
            NSDictionary *firstCategoryIcon = [categories[0] objectForKey:@"icon"] ;
            [atmDictionary setObject:[categories[0] objectForKey:@"name"] ? : [NSNull null] forKey:@"categoryName"];
            [atmDictionary setObject:[NSString stringWithFormat:@"%@88%@",[firstCategoryIcon objectForKey:@"prefix"], [firstCategoryIcon objectForKey:@"suffix"]] forKey:@"categoryIconURL"];
        }
        
        [atmsArray addObject:atmDictionary];
    }
    
    return atmsArray;
}

@end
