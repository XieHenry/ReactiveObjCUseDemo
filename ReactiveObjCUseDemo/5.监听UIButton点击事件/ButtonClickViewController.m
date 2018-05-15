//
//  ButtonClickViewController.m
//  ReactiveObjCUseDemo
//
//  Created by XieHenry on 2018/4/17.
//  Copyright © 2018年 XieHenry. All rights reserved.
//

#import "ButtonClickViewController.h"

@interface ButtonClickViewController ()

@end

@implementation ButtonClickViewController

- (void)viewDidLoad {
    [super viewDidLoad];


    //可以省去 addTarget 添加事件和创建方法的步骤。
    UIButton *button = [UIButton buttonWithType:(UIButtonTypeCustom)];
    button.frame = CGRectMake((SCREEN_WIDTH-100)/2, (SCREEN_HEIGHT-50)/2-64, 100, 50);
    [button setTitle:@"点击按钮" forState:(UIControlStateNormal)];
    [button setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
    [self.view addSubview:button];
    

    
    [[button rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        //UIControl 可改为UIButton
        NSLog(@"按钮被点击了"); //x是button按钮对象
    }];

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
