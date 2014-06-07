//
//  RetailerAnnotationView.m
//  PayMobileClient
//
//  Created by Colden Prime on 6/7/14.
//  Copyright (c) 2014 IntrepidPursuits. All rights reserved.
//

#import "RetailerAnnotationView.h"
#import "PayImages.h"

@interface RetailerAnnotationView ()
@property (nonatomic, weak) IBOutlet UIImageView *pinImageView;
@end

@implementation RetailerAnnotationView

- (id)initWithAnnotation:(id <MKAnnotation>)annotation reuseIdentifier:(NSString*)reuseIdentifier
{
    self = [super initWithAnnotation:annotation reuseIdentifier:reuseIdentifier];
    if (self) {
        NSArray *views = [[NSBundle mainBundle] loadNibNamed:@"RetailerAnnotationView" owner:self options:nil];
        if (views.count > 0) {
            UIView *view = views[0];
            self.frame = view.bounds;
            [self addSubview:view];
        }
        self.centerOffset = CGPointMake(5, -20);
    }
    return self;
}

- (void)setupWithRetailer:(Retailer *)retailer {
    self.pinImageView.image = [PayImages pinImageWithPaymentType:[retailer primaryPaymentMethod].type];
}

@end
