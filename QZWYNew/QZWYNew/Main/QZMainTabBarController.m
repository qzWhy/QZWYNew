//
//  QZMainTabBarController.m
//  QZNews
//
//  Created by 000 on 17/10/11.
//  Copyright © 2017年 faner. All rights reserved.
//

#import "QZMainTabBarController.h"
#import "QZAdManager.h"
#import "QZTabBar.h"

@interface QZMainTabBarController ()<QZTabBarDelegate>

@end

@implementation QZMainTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    [QZAdManager loadLatesAdImage];
    if ([QZAdManager isShouldDisplayAd]) {
        //－－－－状态重置
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"top20"];
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"tightItem"];
        // ------本想吧广告设置成广告显示完毕之后再加载rootViewController的，但是由于前期已经使用storyboard搭建了，写在AppDelete里会冲突，只好就随便整个view广告
        UIView *adView = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
        UIImageView *adImg = [[UIImageView alloc] initWithImage:[QZAdManager getAdImage]];
        UIImageView *adBottomImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"adBottom.png"]];
        [adView addSubview:adBottomImg];
        [adView addSubview:adImg];
        adBottomImg.frame = CGRectMake(0, self.view.height - 135, self.view.width, 135);
        adImg.frame = CGRectMake(0, 0, self.view.width, self.view.height - 135);
        
        adView.alpha = 0.99f;
        [self.view addSubview:adView];
        
        [[UIApplication sharedApplication] setStatusBarHidden:YES];
        
        [UIView animateWithDuration:3 animations:^{
            adView.alpha = 1.0f;
        } completion:^(BOOL finished) {
            [[UIApplication sharedApplication] setStatusBarHidden:NO];
            [UIView animateWithDuration:0.5 animations:^{
                adView.alpha = 0.0f;
            } completion:^(BOOL finished) {
                [adView removeFromSuperview];
            }];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"QZAdvertisementKey" object:nil];
        }];
        
    } else {
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"update"];
    }
    
    QZTabBar *tabBar = [[QZTabBar alloc] init];
    tabBar.frame = self.tabBar.bounds;
    tabBar.backgroundColor = [UIColor colorWithRed:239/255.0 green:239/255.0 blue:239/255.0 alpha:1];
    
    [self.tabBar addSubview:tabBar];
    
    tabBar.delegate = self;
    
    [tabBar addImageView];
    [tabBar addBarButtonWithNorName:@"tabbar_icon_news_normal" andDisName:@"tabbar_icon_news_highlight" andtitle:@"新闻"];
    [tabBar addBarButtonWithNorName:@"tabbar_icon_reader_normal" andDisName:@"tabbar_icon_reader_highlight" andtitle:@"阅读"];
    [tabBar addBarButtonWithNorName:@"tabbar_icon_media_normal" andDisName:@"tabbar_icon_media_highlight" andtitle:@"视听"];
    [tabBar addBarButtonWithNorName:@"tabbar_icon_found_normal" andDisName:@"tabbar_icon_found_highlight" andtitle:@"发现"];
    [tabBar addBarButtonWithNorName:@"tabbar_icon_me_normal" andDisName:@"tabbar_icon_me_highlight" andtitle:@"我"];
    self.selectedIndex = 0;
    
}

#pragma mark - ********************* QZTabBarDelegate代理方法

- (void)changeSelIndexForm:(NSInteger)from to:(NSInteger)to
{
    self.selectedIndex = to;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
