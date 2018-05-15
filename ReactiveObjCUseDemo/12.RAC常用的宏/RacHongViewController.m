//
//  RacHongViewController.m
//  ReactiveObjCUseDemo
//
//  Created by XieHenry on 2018/5/4.
//  Copyright © 2018年 XieHenry. All rights reserved.
//

#import "RacHongViewController.h"

@interface RacHongViewController ()
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UITextField *field;

@end

@implementation RacHongViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    /*
     RAC 中常用的宏
     1.RAC：给某个对象绑定一个属性
     2.RACObserve：监听某个对象的某个属性,返回的是一个信号。
     3.RACTuplePack:将数据打包成RACTuple
     4.RACTupleUnPack:将RAC元祖解包成对应的数据
     */
    
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake((SCREEN_WIDTH-200)/2, (SCREEN_HEIGHT-50)/2, 200, 50)];
    self.titleLabel.textColor = [UIColor blackColor];
    self.titleLabel.backgroundColor = [UIColor redColor];
    [self.view addSubview:self.titleLabel];
    
    
    self.field = [[UITextField alloc] initWithFrame:CGRectMake((SCREEN_WIDTH-200)/2, self.titleLabel.frame.origin.y + 80, 200, 50)];
    self.field.layer.borderWidth = 1;
    self.field.layer.borderColor = [UIColor grayColor].CGColor;
    [self.view addSubview:self.field];

    [self RACDemo];
}

-(void)RACTupleDemo {
    //包装元祖
    RACTuple *tuple = RACTuplePack(@"1",@"2",@"3");
    NSLog(@"%@",tuple);
    
    
    //解包
    //RACTupleUnPack()
}


-(void)RACObserveDemo {
    //只要对象的属性发生变化，这个信号就会发送数据！
    [RACObserve(self.titleLabel, text) subscribeNext:^(id  _Nullable x) {
        NSLog(@"%@",x);
    }];
    
}



-(void)RACDemo {
    //监听文本框内容
    [self.field.rac_textSignal subscribeNext:^(NSString * _Nullable x) {
        self.titleLabel.text = x;
    }];
    
    //给某个对象的某个属性绑定信号，一旦信号产生数据，就会将内容赋值给属性！
    RAC(self.titleLabel,text) = self.field.rac_textSignal;
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
