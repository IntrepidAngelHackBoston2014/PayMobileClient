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
        case PaymentTypeBitCoin:
            break;
        case PaymentTypeStarbucks:
            break;
        case PaymentTypePayPal:
            break;
        case PaymentTypeLevelUp:
            break;
        case PaymentTypeDunkinDonuts:
            break;
        case PaymentTypeCumberlandFarms:
            break;
        case PaymentTypeBitPay:
            break;
        case PaymentTypeLeaf:
            break;
        default:
            break;
    }
    return [UIImage imageNamed:filename];
}

@end
