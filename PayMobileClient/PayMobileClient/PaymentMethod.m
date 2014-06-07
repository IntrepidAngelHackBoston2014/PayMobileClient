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
        default:
            return @"Unknown";
    }
}

- (NSString *)appStoreURLString {
    switch (self.type) {
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
