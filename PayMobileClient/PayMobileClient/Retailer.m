//
//  Retailer.m
//  PayMobileClient
//
//  Created by Colden Prime on 6/7/14.
//  Copyright (c) 2014 IntrepidPursuits. All rights reserved.
//

#import "Retailer.h"

@implementation Retailer

+ (void) getMockRetailersWithSuccess:(RetailerRequestSuccess)success failure:(RetailerRequestFailure)failure {
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:@"http://pay-backend-staging.herokuapp.com/retailers.json" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSArray *retailerDictionaries = [responseObject objectForKey:@"retailers"];
        NSMutableArray *retailers = [NSMutableArray array];
        for (NSDictionary *detailDictionary in retailerDictionaries) {
            [retailers addObject:[[Retailer alloc] initWithDictionary:detailDictionary]];
        }
        if (success) {
            success(operation, retailers);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (failure) {
            failure(operation, error);
        }
    }];
}

- (id)initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];
    if (self) {

    }
    return self;
}

@end
