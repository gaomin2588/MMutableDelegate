//
//  ViewController.m
//  MMutableDelegate
//
//  Created by 高敏 on 2018/6/16.
//  Copyright © 2018年 losermo4. All rights reserved.
//

#import "ViewController.h"
#import "DemoProtocolManager.h"
#import "Demo1Controller.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)dealloc{
    [[DemoProtocolManager shared].mutableDelegate removeDelegate:self];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [[DemoProtocolManager shared].mutableDelegate addDelegate:self delegateQueue:dispatch_get_global_queue(0, 0)];
    
    UIButton *push = [[UIButton alloc] initWithFrame:CGRectMake(100, 100, 100, 40)];
    [push setTitle:@"push" forState:UIControlStateNormal];
    [push setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [push addTarget:self action:@selector(push) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:push];
    
    
    UIButton *response = [[UIButton alloc] initWithFrame:CGRectMake(100, 200, 100, 40)];
    [response setTitle:@"response" forState:UIControlStateNormal];
    [response setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [response addTarget:self action:@selector(response) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:response];
    
}

- (void)push{
    Demo1Controller *d = [[Demo1Controller alloc] init];
    [self.navigationController pushViewController:d animated:YES];
}

- (void)response{
    [[DemoProtocolManager shared].mutableDelegate test1];
    [[DemoProtocolManager shared].mutableDelegate test2];
    [[DemoProtocolManager shared].mutableDelegate test3WithString:@"str 222"];
}

- (void)test1 {
    NSThread *thread = [NSThread currentThread];
    NSLog(@"%@",thread);
    NSLog(@"ViewController------test1");
}

- (void)test2 {
    NSThread *thread = [NSThread currentThread];
    NSLog(@"%@",thread);

    NSLog(@"ViewController------test2");
}
- (void)test3WithString:(NSString *)message {
    NSThread *thread = [NSThread currentThread];
    NSLog(@"%@",thread);
    NSLog(@"ViewController------test3WithString----%@",message);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
