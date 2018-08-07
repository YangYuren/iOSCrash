//
//  SignalHandler.h
//  UncaughtExceptionDemo
//
//  Created by netease163 on 2018/8/7.
//  Copyright © 2018年  netease163. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SignalHandler : NSObject

+(void)saveCreash:(NSString *)exceptionInfo;

@end
///信号量截断
void InstallSignalHandler(void);
