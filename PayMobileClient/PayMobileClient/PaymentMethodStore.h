//
//  PaymentMethodStore.h
//  PayMobileClient
//
//  Created by Colden Prime on 6/7/14.
//  Copyright (c) 2014 IntrepidPursuits. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PaymentMethod.h"

@interface PaymentMethodStore : NSObject

+ (id)sharedStore;

- (NSArray *)paymentMethods;
- (PaymentMethod *)paymentMethodWithType:(PaymentType)type;
- (PaymentMethod *)paymentMethodWithTypeString:(NSString *)typeString;

@end
