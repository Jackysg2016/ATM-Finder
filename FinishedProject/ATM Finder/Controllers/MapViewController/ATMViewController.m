//
//  ATMViewController.m
//  ATM Finder
//
//  Created by Baldrick on 02/07/2015.
//  Copyright (c) 2015 Buy n Large. All rights reserved.
//

#import "ATMViewController.h"

#import "ATMNetworkHelper.h"
#import "ATMMapAnnotation.h"
#import "ATMPinAnnotationView.h"
#import "ATMAnnotationDetailViewController.h"
#import "Constants.h"

#import "NSObject+ATMFinder.h"
#import "UIView+ATMFinder.h"

@interface ATMViewController () <MKMapViewDelegate>
{
    CLLocationManager *locationManager;
    ATMMapAnnotation *selectedAnnotation;
    BOOL firstTime;
}

@property (weak, nonatomic) IBOutlet UIBarButtonItem *searchBarButton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *locationBarButton;
@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (nonatomic) ATMNetworkHelper *atmHelper;

@end

@implementation ATMViewController

NSString *const kAnnotationViewIdentifier = @"AnnotationViewIdentifier";
NSString *const kATMAnnotationDetailSegue = @"ATMAnnotationDetailSegue";

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initLocationManager];
    
    // Navigation Bar Title
    [self setTitle:@"FourSquare ATM Finder"];
    
    // Add UIBarButtonItem events
    [self.searchBarButton setTarget:self];
    [self.searchBarButton setAction:@selector(searchBarButtonPressed:)];
    [self.locationBarButton setTarget:self];
    [self.locationBarButton setAction:@selector(locationBarButtonPressed:)];
    
    // Map View
    [self.mapView setDelegate:self];
    [self.mapView setShowsUserLocation:YES];
    
    // ATM Helper
    self.atmHelper = [[ATMNetworkHelper alloc] init];
    
    firstTime = YES;
}


#pragma mark - MKMapViewDelegate

-(void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation
{
    if (firstTime && [self.mapView isEqual:mapView]) {
        [self centerMapUserCurrentLocation:userLocation];
        [self updateNearbyAtmsAtCoordinate:userLocation.coordinate];
    }
}

-(void)mapView:(MKMapView *)mapView regionDidChangeAnimated:(BOOL)animated
{
    if (!firstTime && [self.mapView isEqual:mapView]) {
        [self updateNearbyAtmsAtCoordinate:self.mapView.centerCoordinate];
    }
}

-(MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation
{
    ATMPinAnnotationView *customPinView;
    if (![annotation isMemberOfClass:[MKUserLocation class]]) {
        customPinView = (ATMPinAnnotationView *)[self.mapView dequeueReusableAnnotationViewWithIdentifier:kAnnotationViewIdentifier];
        
        if (!customPinView) {
            customPinView = [[ATMPinAnnotationView alloc] initWithAnnotation:annotation
                                                             reuseIdentifier:kAnnotationViewIdentifier];
            customPinView.animatesDrop = YES;
            customPinView.canShowCallout = YES;
            
            UIButton *detailButton = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
            [detailButton setImage:[[UIImage imageNamed:@"rightGrayArrow"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]
                          forState:UIControlStateNormal];
            [detailButton addTarget:self
                             action:@selector(annotationCalloutViewPressed:)
                   forControlEvents:UIControlEventTouchUpInside];
            customPinView.rightCalloutAccessoryView = detailButton;
        }
    }
    return customPinView;
}


#pragma mark - Actions

-(void)searchBarButtonPressed:(UIBarButtonItem *)button
{
    // search event
}

-(void)locationBarButtonPressed:(UIBarButtonItem *)button
{
    [self centerMapUserCurrentLocation:self.mapView.userLocation];
    [self updateNearbyAtmsAtCoordinate:self.mapView.userLocation.coordinate];
}

-(void)annotationCalloutViewPressed:(UIButton *)calloutButton
{
    ATMPinAnnotationView *pinAnnotationView = (ATMPinAnnotationView *)[calloutButton superviewOfType:[ATMPinAnnotationView class]];
    if (pinAnnotationView) {
        selectedAnnotation = pinAnnotationView.annotation;
        [self performSegueWithIdentifier:kATMAnnotationDetailSegue sender:self];
    }
}


#pragma mark - Segue

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:kATMAnnotationDetailSegue]){
        ATMAnnotationDetailViewController * viewController = (ATMAnnotationDetailViewController *) segue.destinationViewController;
        [viewController setAnnotation:selectedAnnotation];
        [viewController setNearAnnotations:[self annotationListWithout:selectedAnnotation distanceLessThan:ONE_MILE]];
        [self.navigationItem setBackBarButtonItem:[[UIBarButtonItem alloc] initWithTitle:@"Map"
                                                                                   style:UIBarButtonItemStylePlain
                                                                                  target:nil action:nil]];
    }
}


#pragma mark - MapView update

-(void)centerMapUserCurrentLocation:(MKUserLocation *)userLocation
{
    MKCoordinateSpan span;
    span.latitudeDelta = 0.05;
    span.longitudeDelta = 0.05;
    
    CLLocationCoordinate2D location;
    location.latitude = userLocation.coordinate.latitude;
    location.longitude = userLocation.coordinate.longitude;
    
    MKCoordinateRegion region;
    region.span = span;
    region.center = location;
    [self.mapView setRegion:region animated:YES];
}

-(void)updateNearbyAtmsAtCoordinate:(CLLocationCoordinate2D)coordinate
{
    [self.atmHelper getNearbyAtmsAtCoordinate:coordinate
                        withCompletionHandler:^(NSArray *atmsArray, NSError *error) {
                            if (!error && atmsArray) {
                                [self updateMapWithResponse:atmsArray];
                            }
                        }];
}

- (void)updateMapWithResponse:(NSArray *)atmsArray
{
    MKCoordinateRegion region;
    if (firstTime) {
        firstTime = NO;
        region.span.latitudeDelta = 0.05;
        region.span.longitudeDelta = 0.05;
        region.center = self.mapView.userLocation.coordinate;
    }
    else{
        region = self.mapView.region;
    }
    
    for (int i = 0; i < atmsArray.count; i++) {
        NSDictionary *atm = atmsArray[i];
        
        NSString *identifier = [[atm objectForKey:@"id"] valueOrNil];
        double latitud = [[atm objectForKey:@"latitud"] doubleValue];
        double longitud = [[atm objectForKey:@"longitud"] doubleValue];
        CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake(latitud, longitud);
        
        if (![self annotationIdentifierInMapView:identifier] && [self coordinate:coordinate inRegion:region]) {
            ATMMapAnnotation *mapAnnotation = [[ATMMapAnnotation alloc] init];
            mapAnnotation.identifier = identifier;
            mapAnnotation.coordinate = coordinate;
            mapAnnotation.name = [[atm objectForKey:@"name"] valueOrNil];
            mapAnnotation.address = [[atm objectForKey:@"address"] valueOrNil];
            mapAnnotation.distance = [[atm objectForKey:@"distance"] valueOrNil];
            mapAnnotation.formattedAddress = [[atm objectForKey:@"formattedAddress"] valueOrNil];
            mapAnnotation.formattedPhone = [[atm objectForKey:@"formattedPhone"] valueOrNil];
            mapAnnotation.categoryIconURL = [[atm objectForKey:@"categoryIconURL"] valueOrNil];
            mapAnnotation.categoryName = [[atm objectForKey:@"categoryName"] valueOrNil];
            
            if (mapAnnotation.categoryIconURL) {
                [self.atmHelper getImageNSDataFromURL:mapAnnotation.categoryIconURL
                                withCompletionHandler:^(NSData *data) {
                                    mapAnnotation.categoryIcon = [[UIImage imageWithData:data] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
                                }
                 ];
            }
            
            [self.mapView addAnnotation:mapAnnotation];
        }
    }
}


#pragma mark - Helpers

-(void)initLocationManager
{
    locationManager = [[CLLocationManager alloc] init];
    locationManager.distanceFilter = kCLDistanceFilterNone;
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)
        [locationManager requestWhenInUseAuthorization];
    
    [locationManager startUpdatingLocation];
}

- (BOOL)coordinate:(CLLocationCoordinate2D)coord inRegion:(MKCoordinateRegion)region
{
    CLLocationCoordinate2D center = region.center;
    MKCoordinateSpan span = region.span;
    
    BOOL result = YES;
    result &= cos((center.latitude - coord.latitude)*M_PI/180.0) > cos(span.latitudeDelta/2.0*M_PI/180.0);
    result &= cos((center.longitude - coord.longitude)*M_PI/180.0) > cos(span.longitudeDelta/2.0*M_PI/180.0);
    return result;
}

-(BOOL)annotationIdentifierInMapView:(NSString *)identifier
{
    for (ATMMapAnnotation *mapAnnotation in self.mapView.annotations) {
        if (![mapAnnotation isMemberOfClass:[MKUserLocation class]] && [identifier isEqual:mapAnnotation.identifier]) {
            return YES;
        }
    }
    return NO;
}

-(NSArray *)annotationListWithout:(ATMMapAnnotation *)annotation distanceLessThan:(NSNumber *)distance
{
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"self isMemberOfClass: %@ AND identifier != %@ AND distance <= %@", [ATMMapAnnotation class],annotation.name, distance];
    NSSortDescriptor *descriptor = [NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES];
    return [[self.mapView.annotations filteredArrayUsingPredicate:predicate] sortedArrayUsingDescriptors:[NSArray arrayWithObject:descriptor]];
}


@end
