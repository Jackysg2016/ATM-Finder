//
//  ATMMapAnntoation.h
//  ATM Finder
//
//  Created by Baldrick on 02/07/2015.
//  Copyright (c) 2015 Buy n Large. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface ATMMapAnntoation : NSObject <MKAnnotation>

@property (nonatomic, assign) CLLocationCoordinate2D coordinate;

@end
