//
//  WebViewController.m
//  PayMobileClient
//
//  Created by Colden Prime on 6/8/14.
//  Copyright (c) 2014 IntrepidPursuits. All rights reserved.
//

#import "WebViewController.h"

@interface WebViewController ()

@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end

@implementation WebViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"NavigationIcon"]];

    NSURLRequest *request = [NSURLRequest requestWithURL:self.urlToLoad];
    [self.webView loadRequest:request];
}

@end
