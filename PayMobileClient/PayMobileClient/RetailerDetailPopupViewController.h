//
//  RetailerDetailPopupViewController.h
//  PayMobileClient
//
//  Created by Colden Prime on 6/7/14.
//  Copyright (c) 2014 IntrepidPursuits. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PaymentMethod.h"
#import "Retailer.h"

@protocol RetailerDetailPopupViewControllerDelegate;

@interface RetailerDetailPopupViewController : UIViewController

@property (nonatomic, weak) id<RetailerDetailPopupViewControllerDelegate> delegate;
@property (nonatomic, readonly) Retailer *retailer;

- (id)initWithRetailer:(Retailer *)retailer;

@end

@protocol RetailerDetailPopupViewControllerDelegate <NSObject>

- (void)popupViewController:(RetailerDetailPopupViewController *)viewController didTapPayWithPaymentMethod:(PaymentMethod *)paymentMethod;
- (void)didTapClosePopupViewController:(RetailerDetailPopupViewController *)viewController;

@end