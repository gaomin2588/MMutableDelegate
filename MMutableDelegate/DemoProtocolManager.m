//
//  DemoProtocolManager.m
//  MMutableDelegate
//
//  Created by 高敏 on 2018/6/16.
//  Copyright © 2018年 losermo4. All rights reserved.
//

#import "DemoProtocolManager.h"

@implementation DemoProtocolManager

static DemoProtocolManager *instance = nil;

+ (instancetype)shared{
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[DemoProtocolManager alloc] init];
    });
    return instance;
}

- (instancetype)init{
    self = [super init];
    if (!self) return nil;
    _mutableDelegate = (MMutableDelegate<DemoProtocol>*)[[MMutableDelegate alloc] init];
    return self;
}


@end
