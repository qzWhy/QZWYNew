//
//  QZTabBar.h
//  QZNews
//
//  Created by 000 on 17/10/11.
//  Copyright © 2017年 faner. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol QZTabBarDelegate <NSObject>

- (void)changeSelIndexForm:(NSInteger)from to:(NSInteger)to;

@end

@interface QZTabBar : UIView

@property (nonatomic, weak) id<QZTabBarDelegate> delegate;

- (void)addImageView;
- (void)addBarButtonWithNorName:(NSString *)nor andDisName:(NSString *)dis andtitle:(NSString *)title;

@end
