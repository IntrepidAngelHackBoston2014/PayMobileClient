//
//  PayHTTPClient.h
//  PayMobileClient
//
//  Created by Colden Prime on 6/7/14.
//  Copyright (c) 2014 IntrepidPursuits. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PayHTTPClient : AFHTTPClient

DECLARE_SINGLETON_METHOD(PayHTTPClient, sharedClient);

@end
