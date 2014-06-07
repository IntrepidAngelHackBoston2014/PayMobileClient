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
        self.retailerId = [dictionary objectForKey:(@"id")];
        self.storeNumber = [dictionary objectForKey:(@"store_number")];
        self.name = [dictionary objectForKey:(@"name")];
        self.address = [dictionary objectForKey:(@"address")];
        self.city = [dictionary objectForKey:(@"city")];
        self.state = [dictionary objectForKey:(@"state")];
        self.zipCode = [dictionary objectForKey:(@"zip_code")];
        self.phoneNumber = [dictionary objectForKey:(@"phone_number")];
        self.faxNumber = [dictionary objectForKey:(@"fax_number")];
        self.storeHours = [dictionary objectForKey:(@"store_hours")];
        self.paymentServiceCode = [dictionary objectForKey:(@"payment_service_code")];
        self.services = [dictionary objectForKey:(@"services")];
        self.location = CLLocationCoordinate2DMake([[dictionary objectForKey:(@"latitude")] floatValue],
                                                    [[dictionary objectForKey:(@"longitude")] floatValue]);
        
    }
    return self;
}

@end
