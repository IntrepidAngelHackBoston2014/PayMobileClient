//
//  PayHTTPClient.m
//  PayMobileClient
//
//  Created by Colden Prime on 6/7/14.
//  Copyright (c) 2014 IntrepidPursuits. All rights reserved.
//

#import "PayHTTPClient.h"

@implementation PayHTTPClient

- (id)init {
    self = [super initWithBaseURL:[NSURL URLWithString:@""]];
    if(self) {
        [self setParameterEncoding:AFFormURLParameterEncoding];
        [self registerHTTPOperationClass:[AFJSONRequestOperation class]];
        [self setDefaultHeader:@"Accept" value:@"application/json"];
        [self setDefaultHeader:@"Cookie" value:@""];
    }
    return self;
}

@end
