//
//  OtherATMTableViewCell.h
//  ATM Finder
//
//  Created by Archibald on 9/22/15.
//  Copyright © 2015 Buy n Large. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OtherATMTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *categoryIconImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;

@end
