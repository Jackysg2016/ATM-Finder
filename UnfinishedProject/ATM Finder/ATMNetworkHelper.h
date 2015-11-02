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

@property (strong, nonatomic) NSString *response;

- (void)getNearbyAtmsAtCoordinate:(CLLocationCoordinate2D)coordinate;

@end
