//
//  PaymentType.m
//  PayMobileClient
//
//  Created by Colden Prime on 6/7/14.
//  Copyright (c) 2014 IntrepidPursuits. All rights reserved.
//

#import "PaymentMethod.h"

@interface PaymentMethod()

@property (assign, nonatomic) PaymentType type;

@end

@implementation PaymentMethod

+ (PaymentType)paymentTypeWithTypeString:(NSString *)typeString {
    if([typeString isEqualToString:@"coin"]) {
        return PaymentTypeBitCoin;
    } else if ([typeString isEqualToString:@"cfrm"]) {
        return PaymentTypeCumberlandFarms;
    } else if ([typeString isEqualToString:@"bpay"]) {
        return PaymentTypeBitPay;
    } else if ([typeString isEqualToString:@"dnkn"]) {
        return PaymentTypeDunkinDonuts;
    } else if ([typeString isEqualToString:@"leaf"]) {
        return PaymentTypeLeaf;
    } else if ([typeString isEqualToString:@"lvup"]) {
        return PaymentTypeLevelUp;
    } else if ([typeString isEqualToString:@"ppal"]) {
        return PaymentTypePayPal;
    } else if ([typeString isEqualToString:@"sbux"]) {
        return PaymentTypeStarbucks;
    }
    return PaymentTypeUnknown;
}

- (id)initWithTypeString:(NSString *)typeString {
    self = [super init];
    if (self) {
        self.type = [PaymentMethod paymentTypeWithTypeString:typeString];
    }
    return self;
}

- (NSString *)typeString {
    switch (self.type) {
        case PaymentTypeStarbucks:
            return @"sbux";
            break;
        case PaymentTypeDunkinDonuts:
            return @"dnkn";
            break;
        case PaymentTypeLevelUp:
            return @"lvup";
            break;
        case PaymentTypePayPal:
            return @"ppal";
            break;
        case PaymentTypeCumberlandFarms:
            return @"cfrm";
            break;
        case PaymentTypeLeaf:
            return @"leaf";
            break;
        case PaymentTypeBitCoin:
            return @"coin";
            break;
        case PaymentTypeBitPay:
            return @"bpay";
            break;
        default:
            return @"Unknown";
    }
}

- (NSString *)displayName {
    switch (self.type) {
        case PaymentTypeStarbucks:
            return @"Starbucks";
            break;
        case PaymentTypeDunkinDonuts:
            return @"Dunkin' Donuts";
            break;
        case PaymentTypeLevelUp:
            return @"LevelUp";
            break;
        case PaymentTypePayPal:
            return @"PayPal";
            break;
        case PaymentTypeCumberlandFarms:
            return @"Cumberland Farms";
            break;
        case PaymentTypeLeaf:
            return @"Leaf";
            break;
        case PaymentTypeBitCoin:
            return @"Bitcoin";
            break;
        case PaymentTypeBitPay:
            return @"BitPay";
            break;
        default:
            return @"Unknown";
    }
}

- (NSString *)customURLScheme {
    switch (self.type) {
        case PaymentTypeStarbucks:
            return @"sbux331177714://";
            break;
        case PaymentTypeDunkinDonuts:
            return @"dunkindonuts://";
            break;
        case PaymentTypeLevelUp:
            return @"thelevelup://";
            break;
        case PaymentTypePayPal:
            return @"ppmobile://";
            break;
        default:
            return @"Unknown";
    }
}

- (NSString *)appStoreURLString {
    switch (self.type) {
        case PaymentTypeStarbucks:
            return @"https://itunes.apple.com/us/app/starbucks/id331177714?mt=8";
            break;
        case PaymentTypeDunkinDonuts:
            return @"https://itunes.apple.com/us/app/dunkin-donuts/id552020897?mt=8";
            break;
        case PaymentTypeLevelUp:
            return @"https://itunes.apple.com/us/app/levelup-.-pay-with-your-phone/id424121785?mt=8";
            break;
        case PaymentTypePayPal:
            return @"https://itunes.apple.com/us/app/paypal/id283646709?mt=8";
            break;
        case PaymentTypeCumberlandFarms:
            return @"https://itunes.apple.com/us/app/cumberland-farms-smartpay/id509328660?mt=8";
            break;
        default:
            return @"Unknown";
    }
}

- (NSString *)externalURLString {
    switch (self.type) {
        case PaymentTypeBitCoin:
        case PaymentTypeBitPay:
            return @"https://bitpay.com/";
        default:
            return @"Unknown";
    }
}

- (PaymentMethodPayType)methodPayType {
    switch (self.type) {
        case PaymentTypeStarbucks:
        case PaymentTypeDunkinDonuts:
        case PaymentTypePayPal:
            return PaymentMethodPayTypeExternalApp;
            break;
        case PaymentTypeLevelUp:
        case PaymentTypeCumberlandFarms:
            return PaymentMethodPayTypeDetailPage;
            break;
        default:
            return PaymentMethodPayTypeWebView;
    }
}

@end
