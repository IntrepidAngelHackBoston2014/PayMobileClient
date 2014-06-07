//
//  IPLCommonMacros.h
//  Intrepid Pursuits Library
//
//  Created by Colin Brash on 4/20/12.
//  Copyright (c) 2012 Intrepid Pursuits. All rights reserved.

#import <UIKit/UIKit.h>

#define DECLARE_SINGLETON_METHOD(classname, sharedInstanceMethodName) \
+ (classname *)sharedInstanceMethodName;

#define SYNTHESIZE_SINGLETON_METHOD(classname, sharedInstanceMethodName) \
\
+ (classname *)sharedInstanceMethodName \
{ \
    static classname *_##sharedInstanceMethodName = nil; \
    static dispatch_once_t oncePredicate; \
    dispatch_once(&oncePredicate, ^{ \
        _##sharedInstanceMethodName = [[classname alloc] init]; \
    }); \
\
    return _##sharedInstanceMethodName; \
}

#define mustOverride() \
@throw [NSException exceptionWithName:NSInvalidArgumentException reason:[NSString stringWithFormat:@"You must override %@ in a subclass", NSStringFromSelector(_cmd)] userInfo:nil]

#ifdef DEBUG
#define methodNotImplemented() \
NSLog(@"METHOD NOT IMPLEMENTED: %s:%d:%s", __FILE__, __LINE__, __PRETTY_FUNCTION__)
#else
#define methodNotImplemented()
#endif

#define IS_IPHONE_5 (BOOL)([[UIScreen mainScreen] bounds].size.height == 568)

#define IS_AT_LEAST_IOS6 ([[UIDevice currentDevice].systemVersion floatValue] >= 6.0)

#define USES_NATIVE_FACEBOOK (IS_AT_LEAST_IOS6)