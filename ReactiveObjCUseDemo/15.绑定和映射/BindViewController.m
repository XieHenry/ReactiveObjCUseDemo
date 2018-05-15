//
//  BindViewController.m
//  ReactiveObjCUseDemo
//
//  Created by XieHenry on 2018/5/5.
//  Copyright © 2018年 XieHenry. All rights reserved.
//

#import "BindViewController.h"
#import <RACReturnSignal.h>

@interface BindViewController ()
@property (nonatomic, copy) NSString *value;

@end

@implementation BindViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //创建一个信号
    RACSignal *signalA = [RACSignal createSignal:^RACDisposable *(id subscriber) {
        //这个信号里面有一个Next事件的玻璃球和一个Complete事件的玻璃球
        [subscriber sendNext:@"123"];
        //发送完成
        [subscriber sendCompleted];
        return nil;
    }];
    
    //对信号进行改进,另：可以在RACSignalViewController中查看另外一个案例。
    RAC(self, value) = [signalA map:^id(NSString *value) {
        return [NSString stringWithFormat:@"接收数据：%@",value];
    }];
    
    NSLog(@"%@",self.value);

    
}

-(void)demo1 {
    //创建信号
    RACSubject *subject = [RACSubject subject];
    
    //绑定信号
    RACSignal *signal = [subject flattenMap:^__kindof RACSignal * _Nullable(id  _Nullable value) {
        
        //block调用：只要原信号发送数据，就会调用
        //value:就是源信号发送的内容
        value = [NSString stringWithFormat:@"处理数据：%@",value];
        //返回信号用来包装修改过的内容
        return [RACReturnSignal return:value];
        
    }];
    
    //订阅绑定信号
    [signal subscribeNext:^(id  _Nullable x) {
        NSLog(@"%@",x);
    }];
    
    
    //发送数据
    [subject sendNext:@"123"];
    
}


-(void)demo {
    //bind  绑定
    //1.创建信号
    RACSubject *subject = [RACSubject subject];
    
    //2.绑定信号
    RACSignal *bindSignal = [subject bind:^RACSignalBindBlock _Nonnull{
        return ^RACSignal * (id value,BOOL *stop) {
            //block调用：只要原信号发送数据，就会调用bindBlock
            //value：源信号发送的内容
            NSLog(@"%@",value);
            //返回信号，不能传nil，返回空信号：[RACSignal empty]
            return [RACReturnSignal return:value];
        };
        
    }];
    
    //3.订阅信号
    [bindSignal subscribeNext:^(id  _Nullable x) {
        NSLog(@"绑定接收到：%@",x);
    }];
    
    //4.发送
    [subject sendNext:@"发送原始的数据"];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
