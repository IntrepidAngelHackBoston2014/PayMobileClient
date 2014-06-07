//
//  PayMapViewController.m
//  PayMobileClient
//
//  Created by Colden Prime on 6/7/14.
//  Copyright (c) 2014 IntrepidPursuits. All rights reserved.
//

#import "PayMapViewController.h"
#import "PayMapFilterViewController.h"
#import "PaymentMethodFilter.h"
#import "PaymentMethodStore.h"
#import "Retailer.h"
#import "PayMapAnnotation.h"

@interface PayMapViewController () <CLLocationManagerDelegate, PayMapFilterViewControllerDelegate, MKMapViewDelegate>

@property (strong, nonatomic) CLLocationManager *locationManager;

@property (weak, nonatomic) IBOutlet MKMapView *payMapView;
@property (strong, nonatomic) NSArray *retailers;

@property (strong, nonatomic) PaymentMethodFilter *filter;
@property (assign, nonatomic) BOOL isShowFilter;
@property (strong, nonatomic) PayMapFilterViewController *filterViewController;

@end

@implementation PayMapViewController

- (void)didTapFilterButton:(id)sender {
    self.isShowFilter = !self.isShowFilter;
    if (self.isShowFilter) {
        [self showFilterViewController];
    } else {
        [self hideFilterViewController];
    }
}

- (void)showFilterViewController {
    self.filterViewController = [[PayMapFilterViewController alloc] initWithPaymentMethodFilter:self.filter];
    self.filterViewController.delegate = self;
    self.filterViewController.view.frame = self.view.bounds;
    [self.view addSubview:self.filterViewController.view];
    [self addChildViewController:self.filterViewController];
}

- (void)hideFilterViewController {
    [self.filterViewController.view removeFromSuperview];
    [self.filterViewController removeFromParentViewController];
    self.filterViewController = nil;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.edgesForExtendedLayout = UIRectEdgeNone;

    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemEdit
                                                                                          target:self
                                                                                          action:@selector(didTapFilterButton:)];

    self.filter = [[PaymentMethodFilter alloc] init];
    for (PaymentMethod *method in [[PaymentMethodStore sharedStore] paymentMethods]) {
        [self.filter addMethod:method];
    }

    [self updateLocation];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

    self.locationManager = nil;
}

- (CLLocationManager *)locationManager {
    if (!_locationManager) {
        _locationManager = [[CLLocationManager alloc] init];
        _locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters;
        _locationManager.delegate = self;
    }
    return _locationManager;
}

- (void)updateLocation {
    [self.locationManager startUpdatingLocation];
}

- (void)zoomToLocation:(CLLocation *)location radius:(CGFloat)radius {
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(location.coordinate, radius * 2, radius * 2);
    [self.payMapView setRegion:region animated:YES];
}

- (void)fetchRetailersForCoordinate:(CLLocationCoordinate2D)coordinate {
    [Retailer getRetailersWithFilter:self.filter coordinate:coordinate
                              radius:[self getRadius]
                             success:^(AFHTTPRequestOperation *operation, NSArray *retailers) {
                                 self.retailers = retailers;
                                 [self updateAnnotations];
    }
                             failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
}

- (void)updateAnnotations {
    for (Retailer *retailer in self.retailers) {
        PayMapAnnotation *annotation = [[PayMapAnnotation alloc] initWithRetailer:retailer];
        [self.payMapView addAnnotation:annotation];
    }
}

#pragma mark - CLLocationManagerDelegate methods

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
    CLLocation *location = [locations lastObject];
    [self fetchRetailersForCoordinate:location.coordinate];
    [self zoomToLocation:location radius:2000];

    [self.locationManager stopUpdatingLocation];
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    NSLog(@"%@", error);
}

#pragma mark - MKMapViewDelegate

- (void)mapView:(MKMapView *)mapView regionDidChangeAnimated:(BOOL)animated {
    [self fetchRetailersForCoordinate:[self.payMapView centerCoordinate]];
}

#pragma mark - PayMapFilterViewControllerDelegate methods

- (void)filterViewController:(PayMapFilterViewController *)viewController didSelectPaymentMethod:(PaymentMethod *)paymentMethod {
    [self fetchRetailersForCoordinate:[self.payMapView centerCoordinate]];
}

- (void)filterViewController:(PayMapFilterViewController *)viewController didDeselectPaymentMethod:(PaymentMethod *)paymentMethod {
    [self fetchRetailersForCoordinate:[self.payMapView centerCoordinate]];
}

- (void)didCloseFilterViewController:(PayMapFilterViewController *)viewController {
    self.isShowFilter = NO;
    [self hideFilterViewController];
}

#pragma mark - 

- (CLLocationDistance)getRadius {
    return 2;
}

@end
