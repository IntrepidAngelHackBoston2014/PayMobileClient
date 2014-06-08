//
//  PayAppearance.m
//  PayMobileClient
//
//  Created by Colden Prime on 6/7/14.
//  Copyright (c) 2014 IntrepidPursuits. All rights reserved.
//

#import "PayAppearance.h"

@implementation PayAppearance

+ (void)setupAppearance {
    [self setupNavigationBarAppearance];
}

+ (void)setupNavigationBarAppearance {
    [[UINavigationBar appearance] setBarStyle:UIBarStyleBlack];
    [[UINavigationBar appearance] setBarTintColor:[UIColor blackColor]];
    [[UINavigationBar appearance] setBackgroundColor:[UIColor blackColor]];

    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
}

@end
