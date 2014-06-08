//
//  PayColor.m
//  PayMobileClient
//
//  Created by Colden Prime on 6/7/14.
//  Copyright (c) 2014 IntrepidPursuits. All rights reserved.
//

#import "PayColor.h"

@implementation PayColor

+ (UIColor *)colorWithPaymentType:(PaymentType)paymentType {
    NSInteger colorHex = 0;
    switch (paymentType) {
        case PaymentTypeBitPay:
        case PaymentTypeBitCoin:
            colorHex = 0xF7931A;
            break;
        case PaymentTypeStarbucks:
            colorHex = 0x007754;
            break;
        case PaymentTypePayPal:
            colorHex = 0x003087;
            break;
        case PaymentTypeLevelUp:
            colorHex = 0x1EBBF3;
            break;
        case PaymentTypeDunkinDonuts:
            colorHex = 0xE51A92;
            break;
        case PaymentTypeCumberlandFarms:
            colorHex = 0x80CC28;
            break;
        case PaymentTypeLeaf:
            colorHex = 0x8DAB6E;
            break;
        default:
            break;
    }
    return [UIColor colorWithHexValue:colorHex];
}

@end
