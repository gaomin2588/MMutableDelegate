//
//  MutableDelegate.m
//  iOS-templet
//
//  Created by 高敏 on 2018/5/10.
//  Copyright © 2018年 黄隆. All rights reserved.
//

#import "MMutableDelegate.h"

#if ! __has_feature(objc_arc)
#warning This file must be compiled with ARC. Use -fobjc-arc flag (or convert project to ARC).
#endif


//代理对象和代理队列持有类
@interface DelegateNode : NSObject

@property (nonatomic, weak) id delegate;
@property (nonatomic, strong) dispatch_queue_t delegateQueue;

- (id)initWithDelegate:(id)delegate delegateQueue:(dispatch_queue_t)delegateQueue;

@end

@implementation DelegateNode

- (id)initWithDelegate:(id)delegate delegateQueue:(dispatch_queue_t)delegateQueue {
    self = [super init];
    if (self) {
        _delegate = delegate;
        _delegateQueue = delegateQueue;
    }
    return self;
}

@end



@interface MMutableDelegate()

@property (nonatomic, strong) NSMutableArray *delegateNodes;

@end

@implementation MMutableDelegate

- (instancetype)init {
    self = [super init];
    if (self) {
        _delegateNodes = [NSMutableArray array];
    }
    return self;
}


- (void)addDelegate:(id)delegate delegateQueue:(dispatch_queue_t)delegateQueue {
    
    if (!delegate) {
        return;
    }
    
    if (delegateQueue == NULL) {
        return;
    }
    
    DelegateNode *node = [[DelegateNode alloc] initWithDelegate:delegate delegateQueue:delegateQueue];
    [self.delegateNodes addObject:node];
}

- (void)removeDelegate:(id)delegate delegateQueue:(dispatch_queue_t)delegateQueue {
    if (!delegate) {
        return;
    }
    for (DelegateNode *node in self.delegateNodes) {
        id nodeDelegate = node.delegate;
        if (nodeDelegate == delegate) {
            if (delegateQueue == NULL || delegateQueue == node.delegateQueue) {
                [self.delegateNodes removeObject:node];
            }
        }
    }
}

- (void)removeDelegate:(id)delegate {
    [self removeDelegate:delegate delegateQueue:NULL];
}

- (void)removeAllDelegates {
    for (DelegateNode *node in self.delegateNodes) {
        node.delegate = nil;
    }
    [self.delegateNodes removeAllObjects];
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector {
    for (DelegateNode *node in self.delegateNodes) {
        id nodeDelegate = node.delegate;
        NSMethodSignature *result = [nodeDelegate methodSignatureForSelector:aSelector];
        if (result != nil) {
            return result;
        }
    }
    return [[self class] instanceMethodSignatureForSelector:@selector(emptyMethod)];
}

- (void)emptyMethod {
    NSLog(@"nothing");
}

- (void)forwardInvocation:(NSInvocation *)anInvocation {
    
    SEL selector = [anInvocation selector];
    BOOL foundNilDelegate = NO;
    
    for (DelegateNode *node in self.delegateNodes) {
        id nodeDelegate = node.delegate;
        if ([nodeDelegate respondsToSelector:selector]) {
            dispatch_async(node.delegateQueue, ^{
                [anInvocation invokeWithTarget:nodeDelegate];
            });
        } else if (nodeDelegate == nil) {
            foundNilDelegate = YES;//找到了delegate是空的node 需要移除掉
        }
    }
    
    if (foundNilDelegate) {
        NSMutableIndexSet *indexSet = [[NSMutableIndexSet alloc] init];
        NSUInteger i = 0;
        for (DelegateNode *node in self.delegateNodes) {
            id nodeDelegate = node.delegate;
            if (nodeDelegate == nil) {
                [indexSet addIndex:i];
            }
            i++;
        }
        [self.delegateNodes removeObjectsAtIndexes:indexSet];
    }
}

- (void)doesNotRecognizeSelector:(SEL)aSelector {
    NSLog(@"not found selector [%@]", NSStringFromSelector(aSelector));
}

- (void)dealloc {
    [self removeAllDelegates];
}


@end
