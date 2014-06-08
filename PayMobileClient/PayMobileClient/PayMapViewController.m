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
#import "RetailerAnnotationView.h"
#import "RetailerDetailPopupViewController.h"
#import "LevelUpPaymentViewController.h"
#import "WebViewController.h"

@interface PayMapViewController () <CLLocationManagerDelegate, MKMapViewDelegate, PayMapFilterViewControllerDelegate, RetailerDetailPopupViewControllerDelegate>

@property (strong, nonatomic) CLLocationManager *locationManager;
@property (weak, nonatomic) IBOutlet MKMapView *payMapView;
@property (strong, nonatomic) NSArray *retailers;
@property (strong, nonatomic) PaymentMethodFilter *filter;


@property (assign, nonatomic) BOOL isShowFilter;
@property (strong, nonatomic) PayMapFilterViewController *filterViewController;
@property (strong, nonatomic) NSMutableDictionary *retailerIdToAnnotation;

@property (assign, nonatomic) BOOL isShowPopup;
@property (strong, nonatomic) RetailerDetailPopupViewController *popupViewController;

@property (assign, nonatomic) CLLocationCoordinate2D maxSwCoord;
@property (assign, nonatomic) CLLocationCoordinate2D maxNeCoord;
@property (strong, nonatomic) CLLocation *lastCenterPoint;

@end

@implementation PayMapViewController

- (NSArray *)filteredRetailers {
    return [self.filter filterRetailers:self.retailers];
}

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

    UIButton *filterButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [filterButton setImage:[UIImage imageNamed:@"card_72"] forState:UIControlStateNormal];
    [filterButton addTarget:self action:@selector(didTapFilterButton:) forControlEvents:UIControlEventTouchUpInside];
    [filterButton sizeToFit];

    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:filterButton];
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"NavigationIcon"]];

    self.filter = [PaymentMethodFilter fullFilter];
    self.retailerIdToAnnotation = [[NSMutableDictionary alloc] init];
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

- (void)zoomToCoordinate:(CLLocationCoordinate2D)coordinate radius:(CGFloat)radius animated:(BOOL)animated {
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(coordinate, radius * 2, radius * 2);
    [self.payMapView setRegion:region animated:animated];
}

- (void)fetchRetailersForCoordinate:(CLLocationCoordinate2D)coordinate {
    [Retailer getRetailersWithFilter:[PaymentMethodFilter fullFilter]
                          coordinate:coordinate
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
    NSArray *filtered = [self filteredRetailers];
    for (Retailer *retailer in self.retailers) {
        if ([filtered containsObject:retailer]) {
            if (![self.retailerIdToAnnotation objectForKey:retailer.retailerId]) {
                //Add annotation if it is included in the filter and not on the map
                PayMapAnnotation *annotation = [[PayMapAnnotation alloc] initWithRetailer:retailer];
                [self.payMapView addAnnotation:annotation];
                [self.retailerIdToAnnotation setObject:annotation forKey:retailer.retailerId];
            }
        } else {
            if ([self.retailerIdToAnnotation objectForKey:retailer.retailerId]) {
                //Remove annotation if it is not included in the filter and on the map
                PayMapAnnotation *annotation = [self.retailerIdToAnnotation objectForKey:retailer.retailerId];
                [self.payMapView removeAnnotation:annotation];
                [self.retailerIdToAnnotation removeObjectForKey:retailer.retailerId];
            }
        }
    }
}

#pragma mark - CLLocationManagerDelegate methods

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
    CLLocation *location = [locations lastObject];
    [self zoomToCoordinate:location.coordinate radius:1500 animated:NO];
    [self fetchRetailersForCoordinate:location.coordinate];

    [self.locationManager stopUpdatingLocation];
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    NSLog(@"%@", error);
}

#pragma mark - MKMapViewDelegate

- (void)mapView:(MKMapView *)mapView regionDidChangeAnimated:(BOOL)animated {
    if (self.shouldCallServer) {
        [self fetchRetailersForCoordinate:[self.payMapView centerCoordinate]];
    }
}

- (BOOL)shouldCallServer{
    CGPoint nePoint = CGPointMake(self.payMapView.bounds.origin.x + self.payMapView.bounds.size.width, self.payMapView.bounds.origin.y);
    CGPoint swPoint = CGPointMake((self.payMapView.bounds.origin.x), (self.payMapView.bounds.origin.y + self.payMapView.bounds.size.height));
    CLLocationCoordinate2D centerPoint = self.payMapView.centerCoordinate;
    CLLocation *newCenter = [[CLLocation alloc]initWithLatitude:centerPoint.latitude longitude:centerPoint.longitude];
    CLLocationCoordinate2D neCoord = [self.payMapView convertPoint:nePoint toCoordinateFromView:self.payMapView];
    CLLocationCoordinate2D swCoord = [self.payMapView convertPoint:swPoint toCoordinateFromView:self.payMapView];
    BOOL shouldUpdate = NO;

    //if either ne or sw bound are outside of our previous bounds, trigger server call then reset bounds
    if([newCenter distanceFromLocation:self.lastCenterPoint]/1609.34 > 3.0){
        shouldUpdate = YES;
    } else if (neCoord.latitude > self.maxNeCoord.latitude || neCoord.longitude > self.maxNeCoord.longitude){
        shouldUpdate = YES;
    } else if (swCoord.latitude < self.maxSwCoord.latitude || swCoord.longitude < self.maxSwCoord.longitude) {
        shouldUpdate = YES;
    }
    if(shouldUpdate){
        self.maxNeCoord = neCoord;
        self.maxSwCoord = swCoord;
        self.lastCenterPoint = newCenter;
    }
    return shouldUpdate;
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation {
    if ([annotation isKindOfClass:[MKUserLocation class]])
        return nil;

    static NSString* AnnotationIdentifier = @"AnnotationIdentifier";
    RetailerAnnotationView *annotationView = (RetailerAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:AnnotationIdentifier];
    if (!annotationView) {
        annotationView = [[RetailerAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:AnnotationIdentifier];
    }

    [annotationView setupWithRetailer:((PayMapAnnotation *)annotation).retailer];

    return annotationView;
}

- (void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view {
    if([view.annotation isKindOfClass:[PayMapAnnotation class]]) {
        PayMapAnnotation *anotation = (PayMapAnnotation *)view.annotation;
        [self showDetailsForRetailer:anotation.retailer];
        [self zoomToCoordinate:anotation.coordinate radius:1500 animated:YES];
    }
}

- (void)mapView:(MKMapView *)mapView didDeselectAnnotationView:(MKAnnotationView *)view {
    if([view.annotation isKindOfClass:[PayMapAnnotation class]]) {
        [self hideDetailsForRetailer];
    }
}

- (void)showDetailsForRetailer:(Retailer *)retailer {
    self.isShowPopup = YES;
    self.popupViewController = [[RetailerDetailPopupViewController alloc] initWithRetailer:retailer];
    self.popupViewController.delegate = self;
    self.popupViewController.view.frame = self.view.bounds;
    [self.view addSubview:self.popupViewController.view];
    [self addChildViewController:self.popupViewController];
}

- (void)hideDetailsForRetailer {
    self.isShowPopup = NO;
    [self.popupViewController.view removeFromSuperview];
    [self.popupViewController removeFromParentViewController];
    self.popupViewController = nil;
}

#pragma mark - PayMapFilterViewControllerDelegate methods

- (void)filterViewController:(PayMapFilterViewController *)viewController didSelectPaymentMethod:(PaymentMethod *)paymentMethod {
    [self updateAnnotations];
}

- (void)filterViewController:(PayMapFilterViewController *)viewController didDeselectPaymentMethod:(PaymentMethod *)paymentMethod {
    [self updateAnnotations];
}

- (void)didCloseFilterViewController:(PayMapFilterViewController *)viewController {
    self.isShowFilter = NO;
    [self hideFilterViewController];
}

#pragma mark - RetailerDetailPopupViewControllerDelegate Methods

- (void)popupViewController:(RetailerDetailPopupViewController *)viewController didTapPayWithPaymentMethod:(PaymentMethod *)paymentMethod {
    switch (paymentMethod.methodPayType) {
        case PaymentMethodPayTypeWebView:
            [self payWithWebViewControllerWithPaymentMethod:paymentMethod];
            break;
        case PaymentMethodPayTypeExternalApp:
            [self payWithExternalAppWithPaymentMethod:paymentMethod];
            break;
        case PaymentMethodPayTypeDetailPage:
            [self payWithDetailViewControllerWithPaymentMethod:paymentMethod];
            break;
        case PaymentMethodPayTypeAlert:
            [self payWithAlertWithPaymentMethod:paymentMethod];
            break;
    }
    [self hideDetailsForRetailer];
}

- (void)didTapClosePopupViewController:(RetailerDetailPopupViewController *)viewController {
    for (id<MKAnnotation> annotation in [self.payMapView selectedAnnotations]) {
        [self.payMapView deselectAnnotation:annotation animated:NO];
    }
    [self hideDetailsForRetailer];
}

- (void)payWithWebViewControllerWithPaymentMethod:(PaymentMethod *)paymentMethod {
    NSURL *url = [NSURL URLWithString:[paymentMethod externalURLString]];

    if (url) {
        WebViewController *vc = [[WebViewController alloc] init];
        vc.urlToLoad = url;
        [self.navigationController pushViewController:vc animated:YES];
    }
}

- (void)payWithExternalAppWithPaymentMethod:(PaymentMethod *)paymentMethod {
    NSURL *url = [NSURL URLWithString:paymentMethod.customURLScheme];
    if (url && [[UIApplication sharedApplication] canOpenURL:url]) {
        [[UIApplication sharedApplication] openURL:url];
    } else {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:paymentMethod.appStoreURLString]];
    }
}

- (void)payWithDetailViewControllerWithPaymentMethod:(PaymentMethod *)paymentMethod {
    switch (paymentMethod.type) {
        case PaymentTypeLevelUp: {
            LevelUpPaymentViewController *vc = [[LevelUpPaymentViewController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        default:
            break;
    }
}

- (void)payWithAlertWithPaymentMethod:(PaymentMethod *)paymentMethod {
    [[[UIAlertView alloc] initWithTitle:nil message:paymentMethod.alertString delegate:nil cancelButtonTitle:@"Okay" otherButtonTitles:nil] show];
}

#pragma mark - Radius

- (CLLocationDistance)getRadius {
    MKMapRect mRect = self.payMapView.visibleMapRect;
    MKMapPoint eastMapPoint = MKMapPointMake(MKMapRectGetMidX(mRect), MKMapRectGetMidY(mRect));
    MKMapPoint westMapPoint = MKMapPointMake(MKMapRectGetMidX(mRect), MKMapRectGetMaxY(mRect));
    return MIN(3, MKMetersBetweenMapPoints(eastMapPoint, westMapPoint)/1609.34);
}

@end
