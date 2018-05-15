//
//  DelegateView.m
//  ReactiveObjCUseDemo
//
//  Created by XieHenry on 2018/5/2.
//  Copyright © 2018年 XieHenry. All rights reserved.
//

#import "DelegateView.h"

@implementation DelegateView

-(instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        UIButton *button = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [button setTitle:@"代理" forState:(UIControlStateNormal)];
        [button setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
        button.frame = CGRectMake((SCREEN_WIDTH-80)/2, (SCREEN_HEIGHT-40)/2, 80, 40);
        button.backgroundColor = [UIColor redColor];
        [button addTarget:self action:@selector(btnClick:) forControlEvents:(UIControlEventTouchUpInside)];
        [self addSubview:button];
    }
    return self;
}

-(void)btnClick:(UIButton *)button {
    [self label:@"come here"];
}


-(void)label:(NSString *)str{
    
}



@end
