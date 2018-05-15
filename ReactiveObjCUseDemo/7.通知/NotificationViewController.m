//
//  NotificationViewController.m
//  ReactiveObjCUseDemo
//
//  Created by XieHenry on 2018/4/18.
//  Copyright © 2018年 XieHenry. All rights reserved.
//

#import "NotificationViewController.h"

@interface NotificationViewController ()

@end

@implementation NotificationViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    //发送通知
    NSArray *dataArray = @[@"1", @"2", @"3"];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"notiGetValue" object:dataArray];
    
    //接收通知的操作在HomeViewController中的《viewDidLoad》方法
    //RAC的通知有一个很棒的地方，add的通知，我们不需要再dealloc中进行移除.

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
