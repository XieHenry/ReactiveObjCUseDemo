//
//  DelegateViewController.h
//  ReactiveObjCUseDemo
//
//  Created by XieHenry on 2018/4/18.
//  Copyright © 2018年 XieHenry. All rights reserved.
//

#import <UIKit/UIKit.h>


//步骤一：在第二个控制器.h，添加一个RACSubject代替代理。
@interface DelegateViewController : BaseViewController
@property (nonatomic, strong) RACSubject *delegateSignal;
@end
