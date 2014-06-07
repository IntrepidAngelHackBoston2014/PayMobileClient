//
//  PaymentMethodFilter.m
//  PayMobileClient
//
//  Created by Colden Prime on 6/7/14.
//  Copyright (c) 2014 IntrepidPursuits. All rights reserved.
//

#import "PaymentMethodFilter.h"

@interface PaymentMethodFilter ()

@property (strong, nonatomic) NSMutableSet *selectedMethodsSet;

@end

@implementation PaymentMethodFilter

- (id)init {
    self = [super init];
    if (self) {
        self.selectedMethodsSet = [NSMutableSet set];
    }
    return self;
}

- (NSArray *)selectedMethods {
    return [self.selectedMethodsSet allObjects];
}

- (BOOL)containsMethod:(PaymentMethod *)paymentMethod {
    return [self.selectedMethodsSet containsObject:paymentMethod];
}

- (void)addMethod:(PaymentMethod *)paymentMethod {
    [self.selectedMethodsSet addObject:paymentMethod];
}

- (void)removeMethod:(PaymentMethod *)paymentMethod {
    [self.selectedMethodsSet removeObject:paymentMethod];
}

@end