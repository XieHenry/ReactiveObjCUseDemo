//
//  LoginButtonClickViewController.m
//  ReactiveObjCUseDemo
//
//  Created by XieHenry on 2018/4/18.
//  Copyright © 2018年 XieHenry. All rights reserved.
//

#import "LoginButtonClickViewController.h"

@interface LoginButtonClickViewController ()

@end

@implementation LoginButtonClickViewController

- (void)viewDidLoad {
    [super viewDidLoad];


    UITextField *userNameField = [[UITextField alloc] initWithFrame:CGRectMake((SCREEN_WIDTH-300)/2, 200, 300, 50)];
    userNameField.layer.borderWidth = 1;
    userNameField.placeholder = @"请输入手机号（11位）";
    userNameField.layer.borderColor = [UIColor grayColor].CGColor;
    [self.view addSubview:userNameField];
    
    
    UITextField *passwordField = [[UITextField alloc] initWithFrame:CGRectMake((SCREEN_WIDTH-300)/2, 270, 300, 50)];
    passwordField.layer.borderWidth = 1;
    passwordField.placeholder = @"请输入密码（6-12位）";
    passwordField.layer.borderColor = [UIColor grayColor].CGColor;
    [self.view addSubview:passwordField];
    
    //可以省去 addTarget 添加事件和创建方法的步骤。
    UIButton *button = [UIButton buttonWithType:(UIButtonTypeCustom)];
    button.frame = CGRectMake((SCREEN_WIDTH-300)/2, 340, 300, 50);
    [button setTitle:@"点击按钮" forState:(UIControlStateNormal)];
    [button setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    [self.view addSubview:button];
    
    
    //下面表示只有 用户名 和 密码 输入框内容都大于 0 时，登录 按钮才可以点击，而且状态是实时监听的，一句代码就能完成这个功能。
    //reduceBlock参数：根据组合的信号关联的，必须一一对应
    //reduce 聚合
    RACSignal *loginSignal = [RACSignal combineLatest:@[userNameField.rac_textSignal,passwordField.rac_textSignal] reduce:^id _Nullable(NSString * username, NSString * password){
        
        //验证是否输入正确 手机号为11位，密码为6-12位
        if (username.length == 11 && (password.length >=6 && password.length <=12 )) {
            button.backgroundColor = [UIColor redColor];
        } else {
            button.backgroundColor = [UIColor grayColor];
        }
        return @(username.length == 11 && (password.length >=6 && password.length <=12 ));
    }];
    
    //设置按钮
    RAC(button,enabled) = loginSignal;
    
    //创建命令
    RACCommand *command = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
       //处理时间密码加密
        NSLog(@"拿到%@",input);
        
        
        return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
            //发送请求&&获取登录结果
            [subscriber sendNext:@"请求登录的数据"];
            [subscriber sendCompleted];
            return nil;
        }];
    }];
    
    //获取命令中的信号源
    [command.executionSignals.switchToLatest subscribeNext:^(id  _Nullable x) {
        NSLog(@"%@",x);
    }];
    
    //监听命令的执行过程，可以显示菊花
    [[command.executing skip:1] subscribeNext:^(NSNumber * _Nullable x) {
        NSLog(@"%@",x);
        
        if ([x boolValue]) {
            //正在执行
            NSLog(@"显示菊花");
        } else {
            NSLog(@"干掉菊花");
        }

    }];
    
    //监听登录按钮的点击
    [[button rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(UIButton *sender) {
        //处理登录事件
        [command execute:@"账号密码"];
        
        //
        NSLog(@"可以点击按钮");
    }];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
