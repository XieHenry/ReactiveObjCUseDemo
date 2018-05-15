//
//  LiftSelectorViewController.m
//  ReactiveObjCUseDemo
//
//  Created by XieHenry on 2018/5/3.
//  Copyright © 2018年 XieHenry. All rights reserved.
//

#import "LiftSelectorViewController.h"

@interface LiftSelectorViewController ()

@end

@implementation LiftSelectorViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    
    //使用场景：当一个界面有多个数据请求，或者一个页面分模块请求，当所有的数据都请求回来之后，在更新UI，可使用此方法
    //请求1
    RACSignal *signal1 = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        //发送请求
        NSLog(@"请求网络数据1");
        [subscriber sendNext:@"数据1 来了"];
        
        return nil;
    }];
    
    //请求2
    RACSignal *signal2 = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        //发送请求
        NSLog(@"请求网络数据2");
        [subscriber sendNext:@"数据2 来了"];
        
        return nil;
    }];
    
    //数组
    //当数组中的所有信号都发送了数据，才会执行Selector
    //方法的参数：必须和数组的信号一一对应
    //方法的参数：就是每一个信号发送的数据
    [self rac_liftSelector:@selector(updateUIWithOneData:twoData:) withSignalsFromArray:@[signal1,signal2]];
    
    
}

-(void)updateUIWithOneData:(id)oneData twoData:(id)twoData{
    //拿到数据，更新UI
    NSLog(@"%@ %@",oneData,twoData);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
