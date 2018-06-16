//
//  MutableDelegate.h
//  iOS-templet
//
//  Created by 高敏 on 2018/5/10.
//  Copyright © 2018年 黄隆. All rights reserved.
//

#import <Foundation/Foundation.h>
NS_ASSUME_NONNULL_BEGIN
@interface MMutableDelegate : NSObject

- (void)addDelegate:(id)delegate delegateQueue:(dispatch_queue_t)delegateQueue;

- (void)removeDelegate:(id)delegate delegateQueue:(nullable dispatch_queue_t)delegateQueue;

- (void)removeDelegate:(id)delegate;

- (void)removeAllDelegates;

@end
NS_ASSUME_NONNULL_END
