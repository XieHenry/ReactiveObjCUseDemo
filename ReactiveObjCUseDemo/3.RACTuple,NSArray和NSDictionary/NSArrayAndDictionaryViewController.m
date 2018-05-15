//
//  NSArrayAndDictionaryViewController.m
//  ReactiveObjCUseDemo
//
//  Created by XieHenry on 2018/4/17.
//  Copyright © 2018年 XieHenry. All rights reserved.
//

#import "NSArrayAndDictionaryViewController.h"
#import "KFC.h"

@interface NSArrayAndDictionaryViewController ()

@end

@implementation NSArrayAndDictionaryViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    //RACSequence：用于代替NSArray,NSDictionary,可以使用快速的遍历
    //最常见的应用场景:字典转模型
    
    //解析plist文件
    NSString * filePath = [[NSBundle mainBundle] pathForResource:@"kfc.plist" ofType:nil];
    NSArray * dictArr = [NSArray arrayWithContentsOfFile:filePath];
    
    //    NSMutableArray * arr = [NSMutableArray array];
    //    [dictArr.rac_sequence.signal subscribeNext:^(NSDictionary * x) {
    //        KFC * kfc = [KFC kfcWithDict:x];
    //        [arr addObject:kfc];
    //    }];
    
    
    
    //会将一个集合中的所有元素都映射成一个新的对象!
    NSArray * arr = [[dictArr.rac_sequence map:^id _Nullable(NSDictionary * value) {
        //返回模型!!
        return  [KFC kfcWithDict:value];
    }] array];
    NSLog(@"%@",arr);
}

#pragma mark NSArray
-(void)demo3 {
    /* 遍历数组 */
    NSArray *array = @[@"1", @"2", @"3", @"4", @"5"];
    [array.rac_sequence.signal subscribeNext:^(id  _Nullable x) {
        NSLog(@"数组内容：%@", x); // x 可以是任何对象
    }];
    
    
    /* 内容操作 */
    NSArray *newArray1 = [[array.rac_sequence map:^id _Nullable(id  _Nullable value) {
        //        NSLog(@"数组内容：%@", value);
        return @"0"; // 将所有内容替换为 0
    }] array];
    
    
    /* 内容快速替换 */
    NSArray *newArray2 = [[array.rac_sequence mapReplace:@"0"] array]; // 将所有内容替换为 0
    NSLog(@"%@---%@",newArray1,newArray2);
}

#pragma mark NSDictionary
-(void)demo2{
    /* 遍历字典 */
    NSDictionary *dictionary = @{@"key1":@"value1", @"key2":@"value2", @"key3":@"value3"};
    [dictionary.rac_sequence.signal subscribeNext:^(RACTuple * _Nullable x) {
        
        RACTupleUnpack(NSString *key, NSString *value) = x; // x 是一个元祖，这个宏能够将 key 和 value 拆开
        NSLog(@"字典内容：%@:%@", key, value);
    }];
}

#pragma mark RACTuple
-(void)demo1 {
    /* 创建元祖 */
    RACTuple *tuple = [RACTuple tupleWithObjects:@"1", @"2", @"3", @"4", @"5", nil];
    
    NSLog(@"取元祖内容：%@", tuple[0]);
    NSLog(@"第一个元素：%@", [tuple first]);
    NSLog(@"最后一个元素：%@", [tuple last]);
    
    
    /* 从别的数组中获取内容 */
    RACTuple *tuple1 = [RACTuple tupleWithObjectsFromArray:@[@"1", @"2", @"3", @"4", @"5"]];
    
    /* 利用 RAC 宏快速封装 */
    RACTuple *tuple2 = RACTuplePack(@"1", @"2", @"3", @"4", @"5");
    
    NSLog(@"%@----%@",tuple1,tuple2);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



@end
