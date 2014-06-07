//
//  PayMappAnnotation.m
//  PayMobileClient
//
//  Created by Colden Prime on 6/7/14.
//  Copyright (c) 2014 IntrepidPursuits. All rights reserved.
//

#import "PayMapAnnotation.h"

@interface PayMapAnnotation ()
@property (nonatomic, strong) Retailer *retailer;
@end

@implementation PayMapAnnotation

- (id)initWithRetailer:(Retailer *)retailer {
    self = [super init];
    if (self) {
        self.retailer = retailer;
    }
    return self;
}

- (CLLocationCoordinate2D)coordinate {
    return self.retailer.coordinate;
}

- (NSString *)title {
    return self.retailer.name;
}


@end
