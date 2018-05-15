//
//  KFC.h
//  ReactiveObjCUseDemo
//
//  Created by XieHenry on 2018/4/28.
//  Copyright © 2018年 XieHenry. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KFC : NSObject

@property(copy,nonatomic)NSString * name;

@property(copy,nonatomic)NSString * icon;

+(instancetype)kfcWithDict:(NSDictionary *)dict;
@end
