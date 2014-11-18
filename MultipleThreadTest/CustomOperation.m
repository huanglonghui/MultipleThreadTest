//
//  CustomOperation.m
//  MultipleThreadTest
//
//  Created by 黄龙辉 on 14/11/6.
//  Copyright (c) 2014年 黄龙辉. All rights reserved.
//

#import "CustomOperation.h"

@implementation CustomOperation{
    BOOL _isExecuting;
    BOOL _isFinished;
    BOOL _isCancel;
}


//
//
- (void)cancel
{
    [super cancel];
    if ([self isExecuting]) {
        [self setExecuting:NO];
        [self setFinished:YES];
    }
}
//}
//}
//
//
- (void)setExecuting:(BOOL)isExecuting {
    if (isExecuting != _isExecuting) {
        [self willChangeValueForKey:@"isExecuting"];
        _isExecuting = isExecuting;
        [self didChangeValueForKey:@"isExecuting"];
    }
}
//
- (BOOL)isConcurrent
{
    return YES;
}


- (void)main
{
    @try {
        
        for (int i = 0; i < 1000; ++i) {
            for (int j = 0; j < 1000; ++j) {
                for (int q = 0; q < 1000; ++q) {
                    for (int p = 0; p < 1000; ++p) {
                        if (499 == i && j == 999 && q == 999 && p == 999) {
                            NSLog(@"complete");
                            
                        }
                    }
                }
            }
        }
        
        [self setFinished:YES];
    }
    @catch (NSException *exception) {
    }
    @finally {
    }
}


- (void)setFinished:(BOOL)isFinished
{
    if (isFinished != _isFinished) {
        [self willChangeValueForKey:@"isFinished"];
        // Instance variable has the underscore prefix rather than the local
        _isFinished = isFinished;
        [self didChangeValueForKey:@"isFinished"];
    }
}


- (BOOL)isFinished
{
    return ([self isCancelled] ? YES : _isFinished);
}


- (BOOL)isExecuting
{
    return _isExecuting;
}


- (void)start
{
    if ([self isCancelled]) {
        [self willChangeValueForKey:@"isFinished"];
        [self setFinished:YES];
        [self didChangeValueForKey:@"isFinished"];
        return;
    }
    [self willChangeValueForKey:@"isExecuting"];
    [self setExecuting:YES];
    [NSThread detachNewThreadSelector:@selector(main) toTarget:self withObject:nil];
    [self didChangeValueForKey:@"isExecuting"];
}


@end
