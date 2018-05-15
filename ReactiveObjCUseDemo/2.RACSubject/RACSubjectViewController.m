//
//  RACSubjectViewController.m
//  ReactiveObjCUseDemo
//
//  Created by XieHenry on 2018/4/17.
//  Copyright © 2018年 XieHenry. All rights reserved.
//

#import "RACSubjectViewController.h"
#import "SubjectView.h"

@interface RACSubjectViewController ()

@end

@implementation RACSubjectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  
    SubjectView *subjectView = [[SubjectView alloc] init];
    subjectView.backgroundColor = [UIColor cyanColor];
    self.view = subjectView;
    
    //2.订阅信号
    [subjectView.btnClickSignal subscribeNext:^(id  _Nullable x) {
        self.view.backgroundColor = x;
    }];
}


#pragma mark 示例说明
-(void)racSubjectDemo {
    /* 1.创建信号：因为RACSubject继承RACSignal*/
    RACSubject *subject = [RACSubject subject];
    
    
    /* 2.订阅信号（通常在别的视图控制器中订阅，与代理的用法类似） */
    //不同的信号订阅的方式不一样（因为类型不一样，所以调用的方法不一样）
    //RACSubject处理订阅：拿到之前的_subscribers保存订阅者
    [subject subscribeNext:^(id  _Nullable x) {
        NSLog(@"信号内容：%@", x);
    }];
    
    
    /* 3.发送信号 */
    [subject sendNext:@"发送信号"];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
