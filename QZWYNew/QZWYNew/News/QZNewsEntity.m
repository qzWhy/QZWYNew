//
//  QZNewsEntity.m
//  QZNews
//
//  Created by 000 on 17/10/9.
//  Copyright © 2017年 faner. All rights reserved.
//

#import "QZNewsEntity.h"

@implementation QZNewsEntity

+ (instancetype)newModelWithDict:(NSDictionary *)dict
{
    QZNewsEntity *model = [[self alloc] init];
    
    [model setValuesForKeysWithDictionary:dict];
    return model;
}

@end
