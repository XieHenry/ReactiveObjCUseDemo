//
//  HomeViewController.m
//  ReactiveObjCUseDemo
//
//  Created by XieHenry on 2018/4/17.
//  Copyright © 2018年 XieHenry. All rights reserved.
//

#import "HomeViewController.h"
#import "RACSignalViewController.h"
#import "RACSubjectViewController.h"
#import "NSArrayAndDictionaryViewController.h"
#import "TextFieldViewController.h"
#import "ButtonClickViewController.h"
#import "LoginButtonClickViewController.h"
#import "NotificationViewController.h"
#import "DelegateViewController.h"
#import "KVOViewController.h"
#import "NSTimerViewController.h"
#import "LiftSelectorViewController.h"
#import "RacHongViewController.h"
#import "RACMulticastConnectionVC.h"
#import "BindViewController.h"
#import "RACZuheViewController.h"
#import "RACGuolvViewController.h"

@interface HomeViewController () <UITableViewDelegate,UITableViewDataSource>
//单元格
@property (nonatomic, strong) UITableView *tableView;
//数组
@property (nonatomic, strong) NSArray *dataArray;
//详情数组
@property (nonatomic, strong) NSArray *detailArray;
@end

@implementation HomeViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"首页";
    
    [self initView];

    [self initData];
    
      
    //NotificationViewController中的通知
    [[[NSNotificationCenter defaultCenter] rac_addObserverForName:@"notiGetValue" object:nil] subscribeNext:^(NSNotification * _Nullable x) {// x 是通知对象
        NSLog(@"获取NotificationViewController控制器通知结果：%@", x.object);
    }];
}


//设置单元格数据源
- (void)initData {
    
    self.dataArray = [NSArray arrayWithObjects:@"1.RACSignal",@"2.RACSubject",@"3.RACTuple,NSArray和NSDictionary",@"4.监听UITextField的输入内容",@"5.监听UIButton点击事件",@"6.常见登录按钮逻辑处理",@"7.通知",@"8.代替代理",@"9.代替KVO监听（观察值变化）",@"10.发送验证码",@"11.多个数据都请求完后，才更新UI或类似场景",@"12.RAC常用的宏",@"13.RAC过滤和忽略",@"14.RAC组合和聚合",@"15.绑定和映射",@"16.RACMulticastConnection",nil];
    
    self.detailArray = [NSArray arrayWithObjects:@"RACSignal",@"RACSubject",@"RACTuple,rac_sequence",@"rac_textSignal",@"5.rac_signalForControlEvents",@"combineLatest",@"rac_addObserverForName",@"rac_signalForSelector",@"rac_observeKeyPath,rac_valuesForKeyPath",@"[RACSignal interval:1.0 onScheduler:]",@"rac_liftSelector",@"RAC(TARGET, ...),[RACObserve(TARGET, KEYPATH)],RACTuplePack(...),RACTupleUnpack(...)",@"filter,ignore,take,takeUntil,distinctUntilChanged,skip",@"concat,then,merge,zipWith",@"bind,flattenMap,map",@"RACMulticastConnection",nil];
}


//配置单元格
- (void)initView {
    // 设置单元格
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0,64, SCREEN_WIDTH, SCREEN_HEIGHT-64) style:UITableViewStyleGrouped];

    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
}

#pragma mark- tableView Delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"cellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier
                ];
    }
    cell.textLabel.text = [self.dataArray objectAtIndex:indexPath.row];
    cell.detailTextLabel.text = [self.detailArray objectAtIndex:indexPath.row];
    
    return cell;
}

//-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
//    return 100;
//}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UIViewController *vc;
    switch (indexPath.row) {
        case 0: //RACSignal 信号
            
            vc = [[RACSignalViewController alloc] init];
            
            break;
        case 1: //RACSubject 信号
            
            vc = [[RACSubjectViewController alloc] init];
            
            break;
        case 2: //RACTuple 元祖,遍历 Array 数组和 Dictionary 字典
            
            vc = [[NSArrayAndDictionaryViewController alloc] init];
            
            break;
        case 3: //监听 TextField 的输入改变
            
            vc = [[TextFieldViewController alloc] init];
            
            break;
        case 4: //监听 Button 点击事件
            
            vc = [[ButtonClickViewController alloc] init];

            break;
        case 5: //登录按钮状态实时监听
            
            vc = [[LoginButtonClickViewController alloc] init];

            break;
        case 6: //监听 Notification 通知事件
            
            vc = [[NotificationViewController alloc] init];

            break;
        case 7: //代替 Delegate 代理方法
            
            vc = [[DelegateViewController alloc] init];
            
            break;
        case 8: //代替 KVO 监听，观察值变化
            
            vc = [[KVOViewController alloc] init];

            break;
        case 9: //代替 NSTimer 计时器
            
            vc = [[NSTimerViewController alloc] init];

            break;
        case 10: //LiftSelectorViewController
            
            vc = [[LiftSelectorViewController alloc] init];
            
            break;
        case 11: //RAC常用的宏
            
            vc = [[RacHongViewController alloc] init];
            
            break;
        case 12: //RACGuolvViewController
            
            vc = [[RACGuolvViewController alloc] init];
            
            break;
        case 13: //RACZuheViewController
            
            vc = [[RACZuheViewController alloc] init];
            
            break;
        case 14: //BindViewController
            
            vc = [[BindViewController alloc] init];
            
            break;
        case 15: //RACMulticastConnectionVC
            
            vc = [[RACMulticastConnectionVC alloc] init];
            
            break;
        default:
            break;
    }
    
    vc.title = self.dataArray[indexPath.row];
    [self.navigationController pushViewController:vc animated:YES];
}



@end
