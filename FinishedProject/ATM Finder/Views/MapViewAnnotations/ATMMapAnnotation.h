//
//  ATMMapAnnotation.h
//  ATM Finder
//
//  Created by Baldrick on 02/07/2015.
//  Copyright (c) 2015 Buy n Large. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface ATMMapAnnotation: NSObject <MKAnnotation>

@property (nonatomic) NSString *identifier;
@property (nonatomic) CLLocationCoordinate2D coordinate;
@property (nonatomic) NSString *name;
@property (nonatomic) NSNumber *distance;
@property (nonatomic) NSString *address;
@property (nonatomic) NSArray *formattedAddress;
@property (nonatomic) NSString *formattedPhone;;
@property (nonatomic) NSString *categoryName;
@property (nonatomic) NSString *categoryIconURL;
@property (nonatomic) UIImage *categoryIcon;

@end
