//
//  PayMapFilterViewController.h
//  PayMobileClient
//
//  Created by Colden Prime on 6/7/14.
//  Copyright (c) 2014 IntrepidPursuits. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PaymentMethodFilter.h"

@protocol PayMapFilterViewControllerDelegate;

@interface PayMapFilterViewController : UIViewController

@property (nonatomic, weak) id<PayMapFilterViewControllerDelegate> delegate;
@property (nonatomic, strong) PaymentMethodFilter *methodFilter;

- (id)initWithPaymentMethodFilter:(PaymentMethodFilter *)methodFilter;

@end

@protocol PayMapFilterViewControllerDelegate <NSObject>

- (void)filterViewController:(PayMapFilterViewController *)viewController didSelectPaymentMethod:(PaymentMethod *)paymentMethod;
- (void)filterViewController:(PayMapFilterViewController *)viewController didDeselectPaymentMethod:(PaymentMethod *)paymentMethod;
- (void)didCloseFilterViewController:(PayMapFilterViewController *)viewController;

@end