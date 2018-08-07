//
//  SignalHandler.m
//  UncaughtExceptionDemo
//
//  Created by netease163 on 2018/8/7.
//  Copyright © 2018年  netease163. All rights reserved.
//

#import "SignalHandler.h"
#include <libkern/OSAtomic.h>
#include <execinfo.h>
#import <UIKit/UIKit.h>
#import "UncaughtExceptionHandler.h"
#import "ExceptionModel.h"

@interface SignalHandler()

@end

@implementation SignalHandler
+(void)saveCreash:(NSString *)exceptionInfo{
    NSString * _libPath  = [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingPathComponent:@"SigCrash"];
    if (![[NSFileManager defaultManager] fileExistsAtPath:_libPath]){
        [[NSFileManager defaultManager] createDirectoryAtPath:_libPath withIntermediateDirectories:YES attributes:nil error:nil];
    }
    
    NSDate* dat = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval a=[dat timeIntervalSince1970];
    NSString *timeString = [NSString stringWithFormat:@"%f", a];
    NSString * savePath = [_libPath stringByAppendingFormat:@"/error%@.log",timeString];
    BOOL sucess = [exceptionInfo writeToFile:savePath atomically:YES encoding:NSUTF8StringEncoding error:nil];
    NSLog(@"YES sucess:%d",sucess);
}

@end

void SignalExceptionHandler(int signal){
    NSMutableString *mstr = [[NSMutableString alloc] init];
    [mstr appendString:@"Stack:\n"];
    void* callstack[128];
    int i, frames = backtrace(callstack, 128);
    char** strs = backtrace_symbols(callstack, frames);
    for (i = 0; i <frames; ++i) {
        [mstr appendFormat:@"%s\n", strs[i]];
    }
    //保存信号截断信息到本地
    [SignalHandler saveCreash:mstr];
}

void InstallSignalHandler(void){
    signal(SIGHUP, SignalExceptionHandler);
    signal(SIGINT, SignalExceptionHandler);
    signal(SIGQUIT, SignalExceptionHandler);
    
    signal(SIGABRT, SignalExceptionHandler);
    signal(SIGILL, SignalExceptionHandler);
    signal(SIGSEGV, SignalExceptionHandler);
    signal(SIGFPE, SignalExceptionHandler);
    signal(SIGBUS, SignalExceptionHandler);
    signal(SIGPIPE, SignalExceptionHandler);
}

