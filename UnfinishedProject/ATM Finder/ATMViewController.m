//
//  ATMViewController.m
//  ATM Finder
//
//  Created by Baldrick on 02/07/2015.
//  Copyright (c) 2015 Buy n Large. All rights reserved.
//

#import "ATMViewController.h"
#import "ATMNetworkHelper.h"
#import "ATMMapAnntoation.h"

@interface ATMViewController ()

@property (strong, nonatomic) ATMNetworkHelper *helper;

@end

@implementation ATMViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.mapView setRegion:MKCoordinateRegionMake(CLLocationCoordinate2DMake(51.51, -0.11), MKCoordinateSpanMake(0.1, 0.1))];
    
    self.helper = [[ATMNetworkHelper alloc] init];
    [self.helper getNearbyAtmsAtCoordinate:CLLocationCoordinate2DMake(51.51, -0.11)];
    sleep(2);
    
    [self updateMap];
}

- (void)updateMap
{
    NSArray *parts = [self.helper.response componentsSeparatedByString:@"lat"];
    
    int maxAnnotations = 15;
    if (parts.count < 15) { // Don't want to read off the end of the array!
        maxAnnotations = parts.count;
    }
    
    for (int i = 1; i < 15; i++) {
        
        NSString *part = parts[i];
        double lat = [[part componentsSeparatedByString:@":"][1] doubleValue];
        double lon = [[part componentsSeparatedByString:@":"][2] doubleValue];
        
        ATMMapAnntoation *ann = [[ATMMapAnntoation alloc] init];
        ann.coordinate = CLLocationCoordinate2DMake(lat, lon);
        [self.mapView addAnnotation:ann];
    }
}

@end
