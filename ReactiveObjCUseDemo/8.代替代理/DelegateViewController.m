//
//  DelegateViewController.m
//  ReactiveObjCUseDemo
//
//  Created by XieHenry on 2018/4/18.
//  Copyright © 2018年 XieHenry. All rights reserved.
//

#import "DelegateViewController.h"
#import "DelegateView.h"

@interface DelegateViewController ()
@property (nonatomic,strong) DelegateView *delegateView;
@end
@implementation DelegateViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    
    self.delegateView = [[DelegateView alloc] init];
    self.delegateView.backgroundColor = [UIColor whiteColor];
    self.view = self.delegateView;
    
    //（RACSubject文件夹中的操作也可作为代理）
    //Undeclared selector 'label:' 警告去除设置
#pragma clang diagnostic push
#pragma clang diagnostic ignored"-Wundeclared-selector"
    [[self.delegateView rac_signalForSelector:@selector(label:)] subscribeNext:^(RACTuple * _Nullable x) {
        //NSLog(@"控制器里面的view中的按钮被点击了");
        NSLog(@"%@",x);
        
        RACTupleUnpack(NSString *value) = x; // x 是一个元祖，这个宏能够将 key 和 value 拆开
        NSLog(@"%@",value);
        
    }];
#pragma clang diagnostic pop
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
