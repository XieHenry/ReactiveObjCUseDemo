//
//  KVOViewController.m
//  ReactiveObjCUseDemo
//
//  Created by XieHenry on 2018/4/18.
//  Copyright © 2018年 XieHenry. All rights reserved.
//

#import "KVOViewController.h"
#import <NSObject+RACKVOWrapper.h>

@interface KVOViewController ()
{
    UILabel *label;
}
@end

@implementation KVOViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    
    label = [[UILabel alloc] initWithFrame:CGRectMake(100, 100, 200, 200)];
    label.backgroundColor = [UIColor yellowColor];
    label.text = @"KVO";
    label.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:label];
    
    
    //当label.frame的值变化时调用Block，这是用KVO的机制，RAC封装了KVO
    //可以代替 KVO 监听，下面表示把监听 view 的 frame 属性改变转换成信号，只要值改变就会发送信号。
    //方法1
    [label rac_observeKeyPath:@"frame" options:NSKeyValueObservingOptionOld | NSKeyValueObservingOptionNew observer:nil block:^(id value, NSDictionary *change, BOOL causedByDealloc, BOOL affectedOnlyLastComponent) {
        //回调
        NSLog(@"value:%@---change:%@", value,change); // x 是监听属性的改变结果
    }];
    
    
    //方法2
//    [[label rac_valuesForKeyPath:@"frame" observer:self] subscribeNext:^(id  _Nullable x) {
//        NSLog(@"属性的改变1：%@", x); // x 是监听属性的改变结果
//    }];
    
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    static int x = 100;
    x = x + 50;
    label.frame = CGRectMake(100, x, 200, 200);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



@end
