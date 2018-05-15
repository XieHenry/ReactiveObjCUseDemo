//
//  SubjectView.m
//  ReactiveObjCUseDemo
//
//  Created by XieHenry on 2018/4/28.
//  Copyright © 2018年 XieHenry. All rights reserved.
//

#import "SubjectView.h"

@implementation SubjectView

-(instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        UIButton *button = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [button setTitle:@"按钮" forState:(UIControlStateNormal)];
        [button setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
        button.frame = CGRectMake((SCREEN_WIDTH-80)/2, (SCREEN_HEIGHT-40)/2, 80, 40);
        button.backgroundColor = [UIColor redColor];
        [self addSubview:button];
        
        [[button rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {

            //3.发送信号    通知上个界面,将button的背景颜色传递
            [self.btnClickSignal sendNext:button.backgroundColor];
        }];
        
    }
    return self;
}

//1.创建信号
-(RACSubject *)btnClickSignal {
    if (!_btnClickSignal) {
        _btnClickSignal = [RACSubject subject];
    }
    return _btnClickSignal;
}


@end
