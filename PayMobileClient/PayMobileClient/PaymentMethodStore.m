//
//  PaymentMethodStore.m
//  PayMobileClient
//
//  Created by Colden Prime on 6/7/14.
//  Copyright (c) 2014 IntrepidPursuits. All rights reserved.
//

#import "PaymentMethodStore.h"

@interface PaymentMethodStore ()

@property (nonatomic, strong) NSArray *paymentMethods;

@end

@implementation PaymentMethodStore

+ (id)sharedStore {
    static PaymentMethodStore *sharedStore = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedStore = [[self alloc] init];
    });
    return sharedStore;
}

- (id)init {
    self = [super init];
    if (self) {
        self.paymentMethods = @[
                                [[PaymentMethod alloc] initWithTypeString:@"bpay"],
                                [[PaymentMethod alloc] initWithTypeString:@"cfrm"],
                                [[PaymentMethod alloc] initWithTypeString:@"coin"],
                                [[PaymentMethod alloc] initWithTypeString:@"dnkn"],
                                [[PaymentMethod alloc] initWithTypeString:@"leaf"],
                                [[PaymentMethod alloc] initWithTypeString:@"lvup"],
                                [[PaymentMethod alloc] initWithTypeString:@"ppal"],
                                [[PaymentMethod alloc] initWithTypeString:@"sbux"],
                                ];
    }
    return self;
}

- (PaymentMethod *)paymentMethodWithType:(PaymentType)type {
    for (PaymentMethod *method in self.paymentMethods) {
        if (method.type == type) {
            return method;
        }
    }
    return nil;
}

- (PaymentMethod *)paymentMethodWithTypeString:(NSString *)typeString {
    for (PaymentMethod *method in self.paymentMethods) {
        if ([method.typeString isEqual:typeString]) {
            return method;
        }
    }
    return nil;
}

@end
