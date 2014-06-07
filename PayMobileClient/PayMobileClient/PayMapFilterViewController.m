//
//  PayMapFilterViewController.m
//  PayMobileClient
//
//  Created by Colden Prime on 6/7/14.
//  Copyright (c) 2014 IntrepidPursuits. All rights reserved.
//

#import "PayMapFilterViewController.h"
#import "PaymentMethodStore.h"

@interface PayMapFilterViewController () <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *optionsTableView;
@property (weak, nonatomic) IBOutlet UIView *footerView;
@property (strong, nonatomic) NSArray *paymentMethods;

@end

@implementation PayMapFilterViewController

- (void)setMethodFilter:(PaymentMethodFilter *)methodFilter {
    _methodFilter = methodFilter;
    [self.optionsTableView reloadData];
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

    self.paymentMethods = [[PaymentMethodStore sharedStore] paymentMethods];
    [self.optionsTableView reloadData];
}

#pragma mark - Setup Cell Selection

//TODO

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

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return self.footerView;
}

@end
