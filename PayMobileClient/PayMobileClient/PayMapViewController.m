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

@interface PayMapViewController () <CLLocationManagerDelegate>

@property (strong, nonatomic) CLLocationManager *locationManager;

@property (weak, nonatomic) IBOutlet MKMapView *payMapView;


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

- (void)fetchVenuesForLocation:(CLLocation *)location {
    //TODO: Show Venues
}

#pragma mark - CLLocationManagerDelegate methods

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
    CLLocation *location = [locations lastObject];
    [self fetchVenuesForLocation:location];
    [self zoomToLocation:location radius:2000];

    [self.locationManager stopUpdatingLocation];
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    NSLog(@"%@", error);
}

@end
