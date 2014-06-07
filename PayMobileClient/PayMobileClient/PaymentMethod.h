//
//  PaymentType.h
//  PayMobileClient
//
//  Created by Colden Prime on 6/7/14.
//  Copyright (c) 2014 IntrepidPursuits. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    PaymentTypeUnknown,
    PaymentTypeStarbucks,
    PaymentTypeDunkinDonuts,
    PaymentTypeCumberlandFarms,
    PaymentTypePayPal,
    PaymentTypeLevelUp,
    PaymentTypeBitCoin,
    PaymentTypeLeaf,
    PaymentTypeBitPay
} PaymentType;

typedef enum {
    PaymentMethodPayTypeWebView,
    PaymentMethodPayTypeExternalApp,
    PaymentMethodPayTypeDetailPage,
} PaymentMethodPayType;

@interface PaymentMethod : NSObject

@property (readonly, nonatomic) PaymentType type;
@property (readonly, nonatomic) NSString *typeString;
@property (readonly, nonatomic) NSString *displayName;
@property (readonly, nonatomic) NSString *customURLScheme;
@property (readonly, nonatomic) NSString *appStoreURLString;
@property (readonly, nonatomic) NSString *externalURLString;
@property (readonly, nonatomic) PaymentMethodPayType methodPayType;

- (id)initWithTypeString:(NSString *)typeString;

@end
