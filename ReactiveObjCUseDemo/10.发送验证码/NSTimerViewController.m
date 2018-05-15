//
//  NSTimerViewController.m
//  ReactiveObjCUseDemo
//
//  Created by XieHenry on 2018/4/18.
//  Copyright © 2018年 XieHenry. All rights reserved.
//

#import "NSTimerViewController.h"

@interface NSTimerViewController ()
@property (nonatomic, strong) RACDisposable *disposable;
@property(nonatomic,strong)RACSignal * signal;

@property (nonatomic, strong) UIButton *sendButton;
@property (nonatomic, assign) int time;

@end

@implementation NSTimerViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    
    //可以省去 addTarget 添加事件和创建方法的步骤。
    self.sendButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
    self.sendButton.frame = CGRectMake((SCREEN_WIDTH-100)/2, (SCREEN_HEIGHT-50)/2-64, 100, 50);
    [self.sendButton setTitle:@"发送验证码" forState:(UIControlStateNormal)];
    [self.sendButton setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
    self.sendButton.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:self.sendButton];
    
    
    [[self.sendButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        //UIControl 可改为UIButton

        //改变按钮状态
        self.sendButton.enabled = NO;
        
        //设置倒计时
        self.time = 10;
        
        //每一秒进来
        self.signal = [RACSignal interval:1.0 onScheduler:[RACScheduler mainThreadScheduler]];
        
        self.disposable = [self.signal subscribeNext:^(id  _Nullable x) {
            //时间先减少
            self.time--;
            
            //设置文字
            NSString *btnText = self.time >0 ? [NSString stringWithFormat:@"请等待%d秒",self.time] : @"重新发送";
            
            [self.sendButton setTitle:btnText forState:self.time >0 ?UIControlStateDisabled :UIControlStateNormal];
            
            //设置按钮
            if (self.time > 0) {
                self.sendButton.enabled = NO;
            } else {
                self.sendButton.enabled = YES;
                //取消订阅
                [self.disposable dispose];
            }
            
        }];
    }];
    
}


-(void)demo {
    //事件   交给谁处理的？？   RunLoop
    /*
     RunLoop 模式
     NSDefaultRunLoopMode   默认模式
     UITrackingRunLoopMode  UI模式：只能被UI事件唤醒
     NSRunLoopCommonModes   占位模式：默认&&UI模式
     */
    
    
    //如果控制器中有一个UITableView，拖动UITableView，此NSTimer会无法打印，是因为NSTimer没有加入到UI模式下
    //    [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timerMethod) userInfo:nil repeats:YES];
    
    
    //    NSTimer *timer = [NSTimer timerWithTimeInterval:1.0 target:self selector:@selector(timerMethod) userInfo:nil repeats:YES];
    //    [[NSRunLoop currentRunLoop] addTimer:timer forMode:UITrackingRunLoopMode];
    //
    
    
    [[RACSignal interval:1.0 onScheduler:[RACScheduler scheduler]] subscribeNext:^(NSDate * _Nullable x) {
        NSLog(@"%@",[NSThread currentThread]);
    }];
}

//-(void)timerMethod {
//    NSLog(@"循环打印");
//}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
