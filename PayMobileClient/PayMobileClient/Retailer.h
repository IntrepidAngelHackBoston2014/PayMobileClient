//
//  Retailer.h
//  PayMobileClient
//
//  Created by Colden Prime on 6/7/14.
//  Copyright (c) 2014 IntrepidPursuits. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^RetailerRequestSuccess)(AFHTTPRequestOperation *operation, NSArray *retailers);
typedef void (^RetailerRequestFailure)(AFHTTPRequestOperation *operation, NSError *error);

@interface Retailer : NSObject

+ (void) getMockRetailersWithSuccess:(RetailerRequestSuccess)success failure:(RetailerRequestFailure)failure;

@property (assign, nonatomic) NSNumber *retailerId;
@property (strong, nonatomic) NSString *storeNumber;
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *city;
@property (strong, nonatomic) NSString *address;
@property (strong, nonatomic) NSString *state;
@property (strong, nonatomic) NSString *zipCode;
@property (strong, nonatomic) NSString *phoneNumber;
@property (strong, nonatomic) NSString *faxNumber;
@property (strong, nonatomic) NSString *storeHours;
@property (strong, nonatomic) NSArray *services;
@property (strong, nonatomic) NSString *paymentServiceCode;
@property (strong, nonatomic) CLLocation *location;

@end
