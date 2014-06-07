//
//  PayMapFilterViewController.m
//  PayMobileClient
//
//  Created by Colden Prime on 6/7/14.
//  Copyright (c) 2014 IntrepidPursuits. All rights reserved.
//

#import "PayMapFilterViewController.h"
#import "PaymentMethodStore.h"

@interface PayMapFilterViewController () <UITableViewDataSource, UITableViewDelegate, UIGestureRecognizerDelegate>

@property (weak, nonatomic) IBOutlet UITableView *optionsTableView;
@property (weak, nonatomic) IBOutlet UIView *footerView;
@property (strong, nonatomic) NSArray *paymentMethods;

@end

@implementation PayMapFilterViewController

- (void)setMethodFilter:(PaymentMethodFilter *)methodFilter {
    _methodFilter = methodFilter;
    [self updateSelection];
}

- (id)initWithPaymentMethodFilter:(PaymentMethodFilter *)methodFilter {
    self = [super init];
    if (self) {
        self.methodFilter = methodFilter;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    UITapGestureRecognizer *gr = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTapOutsideOfTableView:)];
    gr.delegate = self;
    [self.view addGestureRecognizer:gr];

    self.paymentMethods = [[PaymentMethodStore sharedStore] paymentMethods];
    [self.optionsTableView reloadData];
    [self updateSelection];
}

- (IBAction)didTapCloseButton:(id)sender {
    [self.delegate didCloseFilterViewController:self];
}

- (void)didTapOutsideOfTableView:(UIGestureRecognizer *)gr {
    [self.delegate didCloseFilterViewController:self];
}

#pragma mark - UIGestureRecognizerDelegate Methods

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    if (touch.view == self.optionsTableView || [touch.view isDescendantOfView:self.optionsTableView]) {
        return NO;
    }
    return YES;
}

#pragma mark - Setup Cell Selection

- (void)updateSelection {
    for(int i = 0; i < self.paymentMethods.count; i++) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:i inSection:0];
        if ([self.methodFilter containsMethod:self.paymentMethods[i]]) {
            [self.optionsTableView selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionNone];
        } else {
            [self.optionsTableView deselectRowAtIndexPath:indexPath animated:NO];
        }
    }
}

#pragma mark - UITableViewDataSource Methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.paymentMethods.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    }

    PaymentMethod *method = self.paymentMethods[indexPath.row];
    cell.textLabel.text = method.displayName;

    return cell;
}

#pragma mark - UITableViewDelegate Methods

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    PaymentMethod *method = self.paymentMethods[indexPath.row];
    [self.methodFilter addMethod:method];
    [self.delegate filterViewController:self didSelectPaymentMethod:method];
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath {
    PaymentMethod *method = self.paymentMethods[indexPath.row];
    [self.methodFilter removeMethod:method];
    [self.delegate filterViewController:self didDeselectPaymentMethod:method];
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return self.footerView;
}

@end
