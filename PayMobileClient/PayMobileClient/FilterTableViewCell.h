//
//  FilterTableViewCell.h
//  PayMobileClient
//
//  Created by Colden Prime on 6/7/14.
//  Copyright (c) 2014 IntrepidPursuits. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PaymentMethod.h"

@interface FilterTableViewCell : UITableViewCell

- (void)setupWithPaymentMethod:(PaymentMethod *)method;

@end
