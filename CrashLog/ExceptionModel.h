//
//  ExceptionModel.h
//  UncaughtExceptionDemo
//
//  Created by netease163 on 2018/8/7.
//  Copyright © 2018年  netease163. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSString * const UncaughtExceptionHandlerSignalExceptionName;
extern NSString * const UncaughtExceptionHandlerSignalKey;
extern NSString * const UncaughtExceptionHandlerAddressesKey;

extern const volatile int32_t UncaughtExceptionCount;
extern const int32_t UncaughtExceptionMaximum;

extern const NSInteger UncaughtExceptionHandlerSkipAddressCount;
extern const NSInteger UncaughtExceptionHandlerReportAddressCount;

@interface ExceptionModel : NSObject

@end
