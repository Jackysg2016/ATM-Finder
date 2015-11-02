//
//  ATMNetworkHelper.h
//  ATM Finder
//
//  Created by Baldrick on 02/07/2015.
//  Copyright (c) 2015 Buy n Large. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface ATMNetworkHelper : NSObject

- (void)getNearbyAtmsAtCoordinate:(CLLocationCoordinate2D)coordinate
            withCompletionHandler:(void (^)(NSArray *atmsArray, NSError *error))completionHandler;

-(void)getImageNSDataFromURL:(NSString *)urlString
       withCompletionHandler:(void (^)(NSData *data))completionHandler;

@end
