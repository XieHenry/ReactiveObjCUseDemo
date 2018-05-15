//
//  KFC.m
//  ReactiveObjCUseDemo
//
//  Created by XieHenry on 2018/4/28.
//  Copyright © 2018年 XieHenry. All rights reserved.
//

#import "KFC.h"

@implementation KFC

+(instancetype)kfcWithDict:(NSDictionary *)dict {
    
    KFC * kfc = [[KFC alloc]init];
    [kfc setValuesForKeysWithDictionary:dict];
    return kfc;
}
@end
