//
//  PayImages.m
//  PayMobileClient
//
//  Created by Colden Prime on 6/7/14.
//  Copyright (c) 2014 IntrepidPursuits. All rights reserved.
//

#import "PayImages.h"

@implementation PayImages

+ (UIImage *)iconImageWithPaymentType:(PaymentType)paymentType {
    NSString *filename = nil;
    switch (paymentType) {
        case PaymentTypeBitPay:
        case PaymentTypeBitCoin:
            filename = @"bitcoin_color_144";
            break;
        case PaymentTypeStarbucks:
            filename = @"starbucks_color_144";
            break;
        case PaymentTypePayPal:
            filename = @"paypal_color_144";
            break;
        case PaymentTypeLevelUp:
            filename = @"levelup_color_144";
            break;
        case PaymentTypeDunkinDonuts:
            filename = @"dunkin_color_144";
            break;
        case PaymentTypeCumberlandFarms:
            filename = @"cfarms_color_144";
            break;
        case PaymentTypeLeaf:
            filename = @"leaf_color_144";
            break;
        default:
            break;
    }
    return [UIImage imageNamed:filename];
}

+ (UIImage *)greyIconImageWithPaymentType:(PaymentType)paymentType {
    NSString *filename = nil;
    switch (paymentType) {
        case PaymentTypeBitPay:
        case PaymentTypeBitCoin:
            filename = @"bitcoin_grey_144";
            break;
        case PaymentTypeStarbucks:
            filename = @"starbucks_grey_144";
            break;
        case PaymentTypePayPal:
            filename = @"paypal_grey_144";
            break;
        case PaymentTypeLevelUp:
            filename = @"levelup_grey_144";
            break;
        case PaymentTypeDunkinDonuts:
            filename = @"dunkin_grey_144";
            break;
        case PaymentTypeCumberlandFarms:
            filename = @"cfarms_grey_144";
            break;
        case PaymentTypeLeaf:
            filename = @"leaf_grey_144";
            break;
        default:
            break;
    }
    return [UIImage imageNamed:filename];
}

+ (UIImage *)pinImageWithPaymentType:(PaymentType)paymentType {
    NSString *filename = nil;
    switch (paymentType) {
        case PaymentTypeBitPay:
        case PaymentTypeBitCoin:
            filename = @"bitcoin_pin_144";
            break;
        case PaymentTypeStarbucks:
            filename = @"starbucks_pin_144";
            break;
        case PaymentTypePayPal:
            filename = @"paypal_pin_144";
            break;
        case PaymentTypeLevelUp:
            filename = @"levelup_pin_144";
            break;
        case PaymentTypeDunkinDonuts:
            filename = @"dunkin_pin_144";
            break;
        case PaymentTypeCumberlandFarms:
            filename = @"cfarms_pin_144";
            break;
        case PaymentTypeLeaf:
            filename = @"leaf_pin_144";
            break;
        default:
            break;
    }
    return [UIImage imageNamed:filename];
}

@end
