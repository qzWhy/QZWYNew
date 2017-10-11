//
//  QZTabBar.m
//  QZNews
//
//  Created by 000 on 17/10/11.
//  Copyright © 2017年 faner. All rights reserved.
//

#import "QZTabBar.h"
#import "QZBarButton.h"
@interface QZTabBar ()

@property (nonatomic, strong) QZBarButton *selButton;
@property (nonatomic, strong) UIImageView *imageView;

@end

@implementation QZTabBar

- (void)addImageView
{
    UIImageView *imgView = [[UIImageView alloc] init];
    imgView.image = [UIImage imageNamed:@""];
    self.imageView = imgView;
    [self addSubview:imgView];
}
#pragma mark - /************************* 通过传入数据赋值图片 ***************************/
- (void)addBarButtonWithNorName:(NSString *)nor andDisName:(NSString *)dis andtitle:(NSString *)title
{
    QZBarButton *btn = [[QZBarButton alloc] init];
    
    [btn setImage:[UIImage imageNamed:nor] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:dis] forState:UIControlStateDisabled];
    
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor colorWithRed:149/155.0 green:149/155.0 blue:149/155.0 alpha:1] forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor colorWithRed:183/155.0 green:20/255.0 blue:28/255.0 alpha:1] forState:UIControlStateDisabled];
    
    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:btn];
    
    //让第一个按钮默认为选中状态
    if (self.subviews.count == 2) {
        btn.tag =1;
        [self btnClick:btn];
    }
    
}
#pragma mark - /************************* 动态加载时设置frame值 ***************************/
- (void)layoutSubviews
{
//    [super layoutSubviews];
    UIImageView *imageView = self.subviews[0];
    imageView.frame = self.bounds;
    
    for (int i = 1; i < self.subviews.count; i++) {
        UIButton *btn = self.subviews[i];
        CGFloat btnW = [UIScreen mainScreen].bounds.size.width/5;
        CGFloat btnH = 49;
        CGFloat btnX = (i-1)*btnW;
        CGFloat btnY = 0;
        btn.frame = CGRectMake(btnX, btnY, btnW, btnH);
        
        //绑定tag 便于后面使用
        btn.tag = i-1;
        
    }
}

#pragma mark - /************************* 按钮点下方法 ***************************/
- (void)btnClick:(QZBarButton *)btn
{
    //响应代理方法 实现页面跳转
    if ([self.delegate respondsToSelector:@selector(changeSelIndexForm:to:)]) {
        [self.delegate changeSelIndexForm:_selButton.tag to:btn.tag];
    }
    //设置按钮显示状态 并切换选中按钮
    _selButton.enabled = YES;
    _selButton = btn;
    btn.enabled = NO;
}

@end
