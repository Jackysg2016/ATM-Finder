//
//  ATMNetworkHelper.m
//  ATM Finder
//
//  Created by Baldrick on 02/07/2015.
//  Copyright (c) 2015 Buy n Large. All rights reserved.
//

#import "ATMNetworkHelper.h"
#import "NSArray+ATMFinder.h"
#import "Constants.h"

@implementation ATMNetworkHelper

-(void)getNearbyAtmsAtCoordinate:(CLLocationCoordinate2D)coordinate
           withCompletionHandler:(void (^)(NSArray *atmsArray, NSError *error))completionHandler
{
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:SERVICE_HOST, CLIENT_ID, CLIENT_SECRET,coordinate.latitude,coordinate.longitude]];
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url];
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    
    [NSURLConnection sendAsynchronousRequest:urlRequest
                                       queue:queue
                           completionHandler:^void (NSURLResponse *response, NSData *data, NSError *connectionError) {
                               if (!connectionError && completionHandler) {
                                   NSArray *atmsArray = [NSArray atmsFromServerData:data];
                                   completionHandler(atmsArray, connectionError);
                               }
                           }];
}

-(void)getImageNSDataFromURL:(NSString *)urlString
   withCompletionHandler:(void (^)(NSData *data))completionHandler
{
    NSURL *imageURL = [NSURL URLWithString:urlString];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
        NSData *imageData = [NSData dataWithContentsOfURL:imageURL];
        if (completionHandler && imageData) {
            completionHandler(imageData);
        }
    });
    
}

@end
