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
    return PaymentTypeUnknown;
}

- (id)initWithTypeString:(NSString *)typeString {
    self = [super init];
    if (self) {
        self.type = [PaymentMethod paymentTypeWithTypeString:typeString];
    }
    return self;
}

- (NSString *)displayName {
    switch (self.type) {
        default:
            return @"Unknown";
    }
}

- (NSString *)customURLScheme {
    switch (self.type) {
        case PaymentTypeStarbucks:
            return @"sbux331177714//";
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
        default:
            return @"Unknown";
    }
}

- (PaymentMethodPayType)methodPayType {
    switch (self.type) {
        default:
            return PaymentMethodPayTypeWebView;
    }
}

@end
