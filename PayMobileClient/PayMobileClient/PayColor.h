//
//  PayColor.h
//  PayMobileClient
//
//  Created by Colden Prime on 6/7/14.
//  Copyright (c) 2014 IntrepidPursuits. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PaymentMethod.h"

@interface PayColor : NSObject

+ (UIColor *)colorWithPaymentType:(PaymentType)paymentType;

@end
