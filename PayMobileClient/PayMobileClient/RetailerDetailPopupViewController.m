//
//  RetailerDetailPopupViewController.m
//  PayMobileClient
//
//  Created by Colden Prime on 6/7/14.
//  Copyright (c) 2014 IntrepidPursuits. All rights reserved.
//

#import "RetailerDetailPopupViewController.h"

@interface RetailerDetailPopupViewController () <UIGestureRecognizerDelegate>

@property (nonatomic, readwrite) Retailer *retailer;

@property (nonatomic, weak) IBOutlet UIView *contentView;
@property (nonatomic, weak) IBOutlet UILabel *nameLabel;
@property (nonatomic, weak) IBOutlet UILabel *addressLabel;
@property (nonatomic, weak) IBOutlet UILabel *paymentLabel;
@property (nonatomic, weak) IBOutlet UIButton *paymentButton;

- (IBAction)didTapCloseButton:(id)sender;
- (IBAction)didTapPaymentButton:(id)sender;

@end

@implementation RetailerDetailPopupViewController

- (id)initWithRetailer:(Retailer *)retailer {
    self = [super init];
    if (self) {
        self.retailer = retailer;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    UITapGestureRecognizer *gr = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTapOutsideOfContentView:)];
    gr.delegate = self;
    [self.view addGestureRecognizer:gr];

    self.nameLabel.text = self.retailer.name;
    self.addressLabel.text = [NSString stringWithFormat:@"%@\n%@, %@, %@", self.retailer.address, self.retailer.city, self.retailer.state, self.retailer.zipCode];
}

- (void)didTapOutsideOfContentView:(UIGestureRecognizer *)gr {
    [self.delegate didTapClosePopupViewController:self];
}


- (IBAction)didTapPaymentButton:(id)sender {
    [self.delegate popupViewController:self didTapPayWithPaymentMethod:[self.retailer primaryPaymentMethod]];
}

- (IBAction)didTapCloseButton:(id)sender {
    [self.delegate didTapClosePopupViewController:self];
}

#pragma mark - UIGestureRecognizerDelegate Methods

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    if (touch.view == self.contentView || [touch.view isDescendantOfView:self.contentView]) {
        return NO;
    }
    return YES;
}

@end
