//
//  RACSignalViewController.m
//  ReactiveObjCUseDemo
//
//  Created by XieHenry on 2018/4/17.
//  Copyright © 2018年 XieHenry. All rights reserved.
//

#import "RACSignalViewController.h"

@interface RACSignalViewController ()
@property (nonatomic, copy) NSString *value;
@end

@implementation RACSignalViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    
    /***************1***************/
    //RACSignal:信号类，当我们有数据产生，创建一个信号
    //1.创建信号(冷信号)
    //didSubscribe 调用:只要一个信号被订阅就会调用
    //didSubscribe 作用:利用subscriber发送数据
    RACSignal *signal = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        
        //3.发送数据 subscriber来发送
        [subscriber sendNext:@"发送信号"];
        
        return [RACDisposable disposableWithBlock:^{
            //只要信号取消订阅就会来到这里
            //清空资源
            NSLog(@"哥们来了！！");
        }];
//        return nil;
    }];

    
    //2.订阅信号（热信号）
    //nextBlock调用:只要订阅者发送数据就会调用
    //nextBlock作用:处理数据
    RACDisposable *disposable = [signal subscribeNext:^(id  _Nullable x) {
        //x:信号发送的内容
        NSLog(@"%@",x);
    }];
    
    //默认一个信号发送数据完毕就会主动取消订阅
    //只要订阅者在，就不会主动取消订阅
    //手动取消订阅
    [disposable dispose];
    
    
    
    /***************2***************/
    //创建一个信号
    RACSignal *signalA = [RACSignal createSignal:^RACDisposable *(id subscriber) {
        //这个信号里面有一个Next事件的玻璃球和一个Complete事件的玻璃球
        [subscriber sendNext:@"唱歌"];
        //发送完成
        [subscriber sendCompleted];
        return nil;
    }];

    //对信号进行改进，当信号里面流的是”唱歌”，就改成”跳舞”返还给self.value
    RAC(self, value) = [signalA map:^id(NSString *value) {
        if ([value isEqualToString:@"唱歌"]) {
            return @"跳舞";
        }
        self.value = value;
        return @"";
    }];

    NSLog(@"value:%@",self.value);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



@end
