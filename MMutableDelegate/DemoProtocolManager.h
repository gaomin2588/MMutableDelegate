//
//  DemoProtocolManager.h
//  MMutableDelegate
//
//  Created by 高敏 on 2018/6/16.
//  Copyright © 2018年 losermo4. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MMutableDelegate.h"
#import "DemoProtocol.h"

@interface DemoProtocolManager : NSObject

@property (nonatomic, strong) MMutableDelegate <DemoProtocol>*mutableDelegate;

+ (instancetype)shared;

@end
