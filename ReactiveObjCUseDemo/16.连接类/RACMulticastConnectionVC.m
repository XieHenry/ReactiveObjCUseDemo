//
//  RACMulticastConnectionVC.m
//  ReactiveObjCUseDemo
//
//  Created by XieHenry on 2018/5/4.
//  Copyright © 2018年 XieHenry. All rights reserved.
//

#import "RACMulticastConnectionVC.h"

@interface RACMulticastConnectionVC ()

@end

@implementation RACMulticastConnectionVC

- (void)viewDidLoad {
    [super viewDidLoad];

    
    //RACMulticastConnection 连接类：用于当一个信号被多次订阅的时候避免多次调用创建信号的block
    //不管订阅多少次信号，只会请求一次数据
    //RACMulticastConnection:必须要有信号
    //1.创建信号
    RACSignal *signal = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        //发送网络请求
        NSLog(@"发送请求");
       //发送数据
        [subscriber sendNext:@"请求到的数据"];
        
        return nil;
    }];
    
    
    //2.将信号转成连接类
    RACMulticastConnection *con = [signal publish];
    
    //3.订阅连接类的信号
    [con.signal subscribeNext:^(id  _Nullable x) {
        NSLog(@"A处在处理数据%@",x);
    }];
    
    [con.signal subscribeNext:^(id  _Nullable x) {
        NSLog(@"B处在处理数据%@",x);
    }];
    
    //4.连接
    [con connect];
    
    
    /*最直观的打印结果
    发送请求
    A处在处理数据请求到的数据
    B处在处理数据请求到的数据
    */
    
    
    //订阅信号
    /*
    [signal subscribeNext:^(id  _Nullable x) {
        NSLog(@"A处在处理数据%@",x);
    }];
    
    
    [signal subscribeNext:^(id  _Nullable x) {
        NSLog(@"B处在处理数据%@",x);
    }];
     
     最直观的打印结果
     发送请求
     A处在处理数据请求到的数据
     发送请求
     B处在处理数据请求到的数据
     */
    
    
  

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
