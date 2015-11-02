//
//  ATMAnnotationDetailViewController.h
//  ATM Finder
//
//  Created by Archibald on 9/22/15.
//  Copyright © 2015 Buy n Large. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ATMMapAnnotation.h"

@interface ATMAnnotationDetailViewController : UIViewController

@property (nonatomic) ATMMapAnnotation *annotation;
@property (nonatomic) NSArray *nearAnnotations;

@end
