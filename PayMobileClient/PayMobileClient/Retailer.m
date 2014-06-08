//
//  Retailer.m
//  PayMobileClient
//
//  Created by Colden Prime on 6/7/14.
//  Copyright (c) 2014 IntrepidPursuits. All rights reserved.
//

#import "Retailer.h"
#import "PaymentMethodStore.h"

@implementation Retailer

#pragma mark - GET Methods

+ (NSDictionary *)getRetailerParametersWithFilter:(PaymentMethodFilter *)filter
                                       coordinate:(CLLocationCoordinate2D)coordinate
                                           radius:(float)radius {
    NSMutableDictionary *ret = [NSMutableDictionary dictionary];
    if (filter) {
        NSMutableArray *codes = [NSMutableArray array];
        for (PaymentMethod *method in filter.selectedMethods) {
            [codes addObject:method.typeString];
        }
        ret[@"codes"] = [codes componentsJoinedByString:@","];
    }
    if (CLLocationCoordinate2DIsValid(coordinate)) {
        ret[@"lat"] = [NSNumber numberWithDouble:coordinate.latitude];
        ret[@"lon"] = [NSNumber numberWithDouble:coordinate.longitude];
    }
    if (radius > 0) {
        ret[@"distance"] = [NSNumber numberWithFloat:radius];
    }
    return ret;
}


+ (void)getRetailersWithParameters:(id)parameters success:(RetailerRequestSuccess)success failure:(RetailerRequestFailure)failure {
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:@"http://pay-backend-staging.herokuapp.com/retailers.json" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
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

+ (void)getMockRetailersWithParameters:(RetailerRequestSuccess)success failure:(RetailerRequestFailure)failure {
    [self getRetailersWithParameters:nil success:success failure:failure];
}

+ (void)getRetailersWithFilter:(PaymentMethodFilter *)filter
                    coordinate:(CLLocationCoordinate2D)coordinate
                        radius:(float)radius
                       success:(RetailerRequestSuccess)success
                       failure:(RetailerRequestFailure)failure {
    NSDictionary *parameters = [self getRetailerParametersWithFilter:filter coordinate:coordinate radius:radius];
    [self getRetailersWithParameters:parameters success:success failure:failure];
}

+ (void)getRetailersWithFilter:(PaymentMethodFilter *)filter
                        radius:(float)radius
                       success:(RetailerRequestSuccess)success
                       failure:(RetailerRequestFailure)failure {
    NSDictionary *parameters = [self getRetailerParametersWithFilter:filter coordinate:kCLLocationCoordinate2DInvalid radius:radius];
    [self getRetailersWithParameters:parameters success:success failure:failure];
}

+ (void)getRetailersWithFilter:(PaymentMethodFilter *)filter
                       success:(RetailerRequestSuccess)success
                       failure:(RetailerRequestFailure)failure {
    NSDictionary *parameters = [self getRetailerParametersWithFilter:filter coordinate:kCLLocationCoordinate2DInvalid radius:0];
    [self getRetailersWithParameters:parameters success:success failure:failure];
}

#pragma mark - Instance Methods

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
        self.displayAddress = [dictionary objectForKey:(@"display_address")];
        self.phoneNumber = [dictionary objectForKey:(@"phone_number")];
        self.faxNumber = [dictionary objectForKey:(@"fax_number")];
        self.storeHours = [dictionary objectForKey:(@"store_hours")];
        self.paymentServiceCode = [dictionary objectForKey:(@"payment_service_code")];
        self.services = [dictionary objectForKey:(@"services")];
        self.coordinate = CLLocationCoordinate2DMake([[dictionary objectForKey:(@"latitude")] floatValue], [[dictionary objectForKey:(@"longitude")] floatValue]);
    }
    return self;
}

- (PaymentMethod *)primaryPaymentMethod {
    NSArray *components = [self.paymentServiceCode componentsSeparatedByString:@","];
    if (components.count > 0) {
        return [[PaymentMethodStore sharedStore] paymentMethodWithTypeString:components[0]];
    }
    return nil;
}


@end
