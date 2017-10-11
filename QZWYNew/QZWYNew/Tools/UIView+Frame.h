//
//  UIView+Frame.h
//  QZNews
//
//  Created by 000 on 17/10/11.
//  Copyright © 2017年 faner. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Frame)
// 自己模仿frame写出他的四个属性
@property (nonatomic, assign) CGFloat  x;
@property (nonatomic, assign) CGFloat  y;
@property (nonatomic, assign) CGFloat  width;
@property (nonatomic, assign) CGFloat  height;

- (void)addTapAction:(SEL)tapAction target:(id)target;
@end
