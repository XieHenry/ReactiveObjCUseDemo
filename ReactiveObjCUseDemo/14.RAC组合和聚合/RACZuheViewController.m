//
//  RACZuheViewController.m
//  ReactiveObjCUseDemo
//
//  Created by XieHenry on 2018/5/7.
//  Copyright © 2018年 XieHenry. All rights reserved.
//

#import "RACZuheViewController.h"

@interface RACZuheViewController ()
@end

@implementation RACZuheViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //组合和聚合，可参考LoginButtonClickViewController中示例
}


#pragma mark zipWith:两个信号压缩，只有当两个信号同时发出信号内容，并且将内容合并成为一个元祖给你
-(void)zipWithDemo {
    //zipWith:两个信号压缩，只有当两个信号同时发出信号内容，并且将内容合并成为一个元祖给你
    //创建信号
    RACSubject *signalA = [RACSubject subject];
    RACSubject *signalB = [RACSubject subject];
    
    //压缩
    RACSignal *zipSignal =  [signalA zipWith:signalB];
    
    //接收数据   和发送顺序无关
    [zipSignal subscribeNext:^(id  _Nullable x) {
        NSLog(@"%@",x);
        
        //结果为A B
    }];
    
    
    [signalA sendNext:@"A"];
    [signalB sendNext:@"B"];
}


#pragma mark merge：根据信号发送先后顺序返回 
-(void)mergeDemo {
    //创建信号
    RACSubject *signalA = [RACSubject subject];
    RACSubject *signalB = [RACSubject subject];
    RACSubject *signalC = [RACSubject subject];
    
    //组合信号
    //    RACSignal *mergeSignal = [signalA merge:signalB];
    RACSignal *mergeSignal = [RACSignal merge:@[signalA,signalB,signalC]];
    
    //订阅
    [mergeSignal subscribeNext:^(id  _Nullable x) {
        //任意一个信号发送内容都回来到这个block
        NSLog(@"%@",x);
    }];
    
    //发送数据
    [signalC sendNext:@"数据C"];
    [signalA sendNext:@"数据A"];
    [signalB sendNext:@"数据B"];
    
    /*
    结果为
     数据C
     数据A
     数据B
    */
     
}

#pragma mark then：忽略掉第一个信号所有的值
-(void)thenDemo {
    //组合
    //创建信号
    RACSignal *signalA = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        NSLog(@"发送请求A");
        //发送数据
        [subscriber sendNext:@"数据A"];
        [subscriber sendCompleted];
        return nil;
    }];
    
    RACSignal *signalB = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        NSLog(@"发送请求B");
        //发送数据
        [subscriber sendNext:@"数据B"];
        [subscriber sendCompleted];
        
        return nil;
        
    }];
    
    //then：忽略掉第一个信号所有的值！！
    RACSignal *thenSignal = [signalA then:^RACSignal * _Nonnull{
         //返回信号就是需要组合的信号
        return signalB;
    }];
    
    //订阅信号
    [thenSignal subscribeNext:^(id  _Nullable x) {
        NSLog(@"%@",x);
    }];
}


#pragma mark concat:按顺序连接,先执行A,再执行B，最后执行C
-(void)concatDemo {
    //组合
    //创建信号
    RACSignal *signalA = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        NSLog(@"发送请求A");
        //发送数据
        [subscriber sendNext:@"数据A"];
        [subscriber sendCompleted]; //必写
        return nil;
    }];
    
    RACSignal *signalB = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        NSLog(@"发送请求B");
        //发送数据
        [subscriber sendNext:@"数据B"];
        [subscriber sendCompleted]; //必写
        
        return nil;
        
    }];
    
    RACSignal *signalC = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        NSLog(@"发送请求C");
        //发送数据
        [subscriber sendNext:@"数据C"];
        [subscriber sendCompleted]; //最后一个可写可不写
        
        return nil;
        
    }];
    
    
    //concat：按顺序组合！！
    //创建组合信号
    //    RACSignal *concatSignal = [signalA concat:signalB]; //2个的时候
    //    RACSignal *concatSignal = [[signalA concat:signalB] concat:signalC];
    
    RACSignal *concatSignal = [RACSignal concat:@[signalA,signalB,signalC]];
    //订阅组合信号
    
    [concatSignal subscribeNext:^(id  _Nullable x) {
        //既能拿到A信号的值,又能拿到B，C信号的值
        //注意:concat,除了最后一个信号，其他都必须调用sendCompleted
        NSLog(@"%@",x);
    }];
}







- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
