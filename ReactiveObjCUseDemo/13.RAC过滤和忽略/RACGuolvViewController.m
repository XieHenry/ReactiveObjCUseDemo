//
//  RACGuolvViewController.m
//  ReactiveObjCUseDemo
//
//  Created by XieHenry on 2018/5/7.
//  Copyright © 2018年 XieHenry. All rights reserved.
//

#import "RACGuolvViewController.h"
#import <RACReturnSignal.h>

@interface RACGuolvViewController ()

@end

@implementation RACGuolvViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    //创建信号
    RACSubject *subject = [RACSubject subject];

    //skip：跳跃几个值
    [[subject skip:2] subscribeNext:^(id  _Nullable x) {
        NSLog(@"%@",x);
    }];
    
    [subject sendNext:@"1"];
    [subject sendNext:@"2"];
    [subject sendNext:@"3"];
}

#pragma mark distinctUntilChanged：忽略掉重复数据
-(void)distinDemo {
    //创建信号
    RACSubject *subject = [RACSubject subject];
    
    
    //忽略掉重复数据
    [[subject distinctUntilChanged] subscribeNext:^(id  _Nullable x) {
        NSLog(@"%@",x);
    }];
    
    
    [subject sendNext:@"1"];
    [subject sendNext:@"1"];
    [subject sendNext:@"2"];
    [subject sendNext:@"3"];
}

#pragma mark takeUntil：到哪个结束
-(void)takeUntilDemo {
    RACSubject *subject = [RACSubject subject];
    //专门做一个标记信号
    RACSubject *signal = [RACSubject subject];
    
    
    //take:指定拿前面的哪几条数据(从前往后)
    //takeLast:指定拿前面的哪几条数据（从后往前）
    //takeUntil:直到你的标记信号发送数据的时候结束！！
    [[subject takeUntil:signal] subscribeNext:^(id  _Nullable x) {
        NSLog(@"%@",x);
        
    }];
    
    
    [subject sendNext:@"2"];
    
//    [signal sendNext:@".."];
    [signal sendCompleted]; //takeUntil 必须写
    
    [subject sendNext:@"3"];
    [subject sendNext:@"1"];
    [subject sendCompleted]; //takeLast 必须写
}



#pragma mark take
-(void)takeDemo {
   
    RACSubject *subject = [RACSubject subject];
    
    //take:指定拿前面的哪几条数据(从前往后)
    //    [[subject take:2] subscribeNext:^(id  _Nullable x) {
    //        NSLog(@"%@",x);
    //    }];
    
    //takeLast:指定拿前面的哪几条数据（从后往前）
    [[subject takeLast:2] subscribeNext:^(id  _Nullable x) {
        NSLog(@"%@",x);
    }];
    
    [subject sendNext:@"2"];
    [subject sendNext:@"3"];
    [subject sendNext:@"1"];
    [subject sendCompleted]; //takeLast 必须写
}



#pragma mark ignore:忽略
-(void)ignoreDemo {
    //ignore：忽略
    RACSubject *subject = [RACSubject subject];
    
    //忽略一些值
    //   RACSignal *ignoreSignal = [subject ignore:@"1"];
    RACSignal *ignoreSignal = [[subject ignore:@"1"] ignore:@"2"];
    
    //忽略所有值
    //    RACSignal *ignoreSignal = [subject ignoreValues];
    
    //订阅
    [ignoreSignal subscribeNext:^(id  _Nullable x) {
        NSLog(@"%@",x);
    }];
    
    //发送数据
    [subject sendNext:@"123"];
    
}


#pragma mark filter:过滤
-(void)filterDemo {
    UITextField *userNameField = [[UITextField alloc] initWithFrame:CGRectMake((SCREEN_WIDTH-300)/2, 200, 300, 50)];
    userNameField.layer.borderWidth = 1;
    userNameField.placeholder = @"请输入账号";
    userNameField.layer.borderColor = [UIColor grayColor].CGColor;
    [self.view addSubview:userNameField];
    
    
    [[userNameField.rac_textSignal filter:^BOOL(NSString * _Nullable value) {
        
        //value：源信号的内容
        return [value length] >5 ;
        //返回值：就是过滤条件，只有满足这个条件，才能获取到内容
    }] subscribeNext:^(NSString * _Nullable x) {
        NSLog(@"%@",x);
    }];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
