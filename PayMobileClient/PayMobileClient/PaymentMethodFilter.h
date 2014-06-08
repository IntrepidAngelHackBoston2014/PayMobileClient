//
//  PaymentMethodFilter.h
//  PayMobileClient
//
//  Created by Colden Prime on 6/7/14.
//  Copyright (c) 2014 IntrepidPursuits. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PaymentMethod.h"

@interface PaymentMethodFilter : NSObject

+ (PaymentMethodFilter *)fullFilter;

@property (readonly, nonatomic) NSArray *selectedMethods;

- (BOOL)containsMethod:(PaymentMethod *)paymentMethod;
- (void)addMethod:(PaymentMethod *)paymentMethod;
- (void)removeMethod:(PaymentMethod *)paymentMethod;

- (NSArray *)filterRetailers:(NSArray *)retailers;

@end
