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

@end
