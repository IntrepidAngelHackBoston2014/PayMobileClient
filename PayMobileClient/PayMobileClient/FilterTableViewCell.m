//
//  FilterTableViewCell.m
//  PayMobileClient
//
//  Created by Colden Prime on 6/7/14.
//  Copyright (c) 2014 IntrepidPursuits. All rights reserved.
//

#import "FilterTableViewCell.h"
#import "PayImages.h"
#import "PayColor.h"

@interface FilterTableViewCell ()
@property (nonatomic, weak) IBOutlet UIImageView *logoImageView;
@property (nonatomic, weak) IBOutlet UIView *colorView;
@property (nonatomic, strong) PaymentMethod *paymentMethod;
@end

@implementation FilterTableViewCell

- (void)setupWithPaymentMethod:(PaymentMethod *)method {
    self.paymentMethod = method;
    [self updateConfiguration];
}

- (void)awakeFromNib
{
    // Initialization code
    self.colorView.layer.cornerRadius = 7;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    [self updateConfiguration];
}

- (void)updateConfiguration {
    if (self.selected) {
        self.logoImageView.image = [PayImages iconImageWithPaymentType:self.paymentMethod.type];
        self.colorView.backgroundColor = [PayColor colorWithPaymentType:self.paymentMethod.type];
    } else {
        self.logoImageView.image = [PayImages greyIconImageWithPaymentType:self.paymentMethod.type];
        self.colorView.backgroundColor = [UIColor colorWithHexValue:0xE6E6E6];
    }
}

@end
