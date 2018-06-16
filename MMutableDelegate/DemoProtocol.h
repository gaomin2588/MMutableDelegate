//
//  MutableDelegateProtecol.h
//  MMutableDelegate
//
//  Created by 高敏 on 2018/6/16.
//  Copyright © 2018年 losermo4. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol DemoProtocol <NSObject>

@optional

- (void)test1;

- (void)test2;

- (void)test3WithString:(NSString *)message;



@end
