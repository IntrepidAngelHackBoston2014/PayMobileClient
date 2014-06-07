//
//  RetailerAnnotationView.h
//  PayMobileClient
//
//  Created by Colden Prime on 6/7/14.
//  Copyright (c) 2014 IntrepidPursuits. All rights reserved.
//

#import <MapKit/MapKit.h>
#import "Retailer.h"

@interface RetailerAnnotationView : MKAnnotationView

- (void)setupWithRetailer:(Retailer *)retailer;

@end
