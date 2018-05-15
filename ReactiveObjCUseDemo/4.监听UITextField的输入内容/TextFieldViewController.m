//
//  TextFieldViewController.m
//  ReactiveObjCUseDemo
//
//  Created by XieHenry on 2018/4/17.
//  Copyright © 2018年 XieHenry. All rights reserved.
//

#import "TextFieldViewController.h"

@interface TextFieldViewController ()

@end

@implementation TextFieldViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    
    //可以省去设置 delegate 和实现代理方法的步骤
    UITextField *field = [[UITextField alloc] initWithFrame:CGRectMake((SCREEN_WIDTH-300)/2, (SCREEN_HEIGHT-50)/2-64, 300, 50)];
    field.layer.borderWidth = 1;
    field.layer.borderColor = [UIColor grayColor].CGColor;
    [self.view addSubview:field];
    

    
    //监听 UITextField 的输入（内容改变就会调用）
//    [[field rac_textSignal] subscribeNext:^(NSString * _Nullable x) {
//        NSLog(@"输入内容为：%@",x);
//    }];
    
    
    //添加监听条件
    [[field.rac_textSignal filter:^BOOL(NSString * _Nullable value) {
        
        return value.length >5; // 表示输入文字长度 > 5 时才会调用下面的 block
    }] subscribeNext:^(NSString * _Nullable x) {
        NSLog(@"输入框内容为：%@",x);
    }];

    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
