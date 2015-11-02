//
//  ATMNetworkHelper.m
//  ATM Finder
//
//  Created by Baldrick on 02/07/2015.
//  Copyright (c) 2015 Buy n Large. All rights reserved.
//

#import "ATMNetworkHelper.h"

@interface ATMNetworkHelper ()

@property (strong, nonatomic) void (^handler)(NSURLResponse *response, NSData *data, NSError *connectionError);

@end

@implementation ATMNetworkHelper

- (void)getNearbyAtmsAtCoordinate:(CLLocationCoordinate2D)coordinate
{
    NSString *clientId = @"PWS55XITBPEMFL041SC5BC1YVFABXGL5KRHFVOHZ0PDXW5WY";
    NSString *clientSecret = @"X5RA0VO1FK0F0DYR54ZLRBIB33TOOJ2JGGMEGY2PFBMJGOGK";
    
    NSString *search = [NSString stringWithFormat:@"https://api.foursquare.com/v2/venues/search?client_id=%@&client_secret=%@&v=20130815&ll=51.51,-0.11&query=atm", clientId, clientSecret];
    NSURL *url = [NSURL URLWithString:search];
    
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url];
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    
    self.handler = ^void (NSURLResponse *response, NSData *data, NSError *connectionError) {
        self.response = [[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding];
    };
    
    [NSURLConnection sendAsynchronousRequest:urlRequest queue:queue completionHandler:self.handler];
}

@end
